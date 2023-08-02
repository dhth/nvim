local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local checkout = require('telescope.builtin').git_branches

local M = {}

local function create_telescope_search(opts)
    -- third column is 0 when task is supposed to be done in the background, else 1
    local config = {
        { "pull", "Git pull", "0", "pulled!" },
        { "checkout", checkout, "1", "" },
        { "push", M.git_push, "1", "" },
        { "push -u", M.git_push_set_upstream, "1", "" },
        { "fetch", "Git fetch", "0", "fetched!" },
        { "diff", "DiffviewOpen", "1", "" },
        { "diff window", M.show_diff_in_window, "0", "" },
        { "diff branch", M.show_diff_for_branch, "0", "" },
        { "diff cached", "DiffviewOpen --cached", "1", "" },
        { "diff with master", "Git difftool -y origin/master %", "1", "" },
        { "checkout master", "Git checkout master", "0", "checked out master!" },
        { "checkout master and pull", "Git checkout master | Git pull", "0", "checked out master and pulled!" },
        { "rebase o/master", "Git rebase origin/master", "0", "rebased!" },
        { "stash push, rebase o/master and stash pop", "Git stash push | Git rebase origin/master | Git stash pop", "0",
            "rebased!" },
        { "stash push, checkout master, pull, and stash pop", "Git stash push | Git checkout master | Git pull | Git stash pop", "0",
            "checked out master!" },
    }
    pickers.new(opts, {
        prompt_title = "git",
        results_title = "commands",
        finder = finders.new_table {
            results = config,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry[1],
                    ordinal = entry[2],
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if type(selection.value[2]) == "string" then
                    vim.cmd(selection.value[2])
                    if selection.value[3] == "0" then
                        print(selection.value[4])
                    end
                else
                    selection.value[2]()
                end

            end)
            return true
        end,

    }):find()
end

local function diff_commit_search(opts)
    local config = 
    pickers.new(opts, {
        prompt_title = "commit?",
        results_title = "commands",
        finder = finders.new_oneshot_job({ "git log" }, opts ),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                P(selection)
            end)
            return true
        end,

    }):find()
end


function M.diff_file_with_commit()
    local opts = {
        prompt_title = "~ diff ~",
        layout_config = {
            height = .8,
            width = .4,
        }
    }
    diff_commit_search(opts)
end

function M.show_diff_in_window()
    -- third column is 0 when task is supposed to be done in the background, else 1
    local opts = {
        layout_config = {
            height = .3,
            width = .2,
        }
    }
    local config = {
        "json",
        "yaml",
    }
    pickers.new(opts, {
        prompt_title = "file type?",
        results_title = "options",
        finder = finders.new_table {
            results = config,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry,
                    ordinal = entry,
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.cmd("set filetype=" .. selection.value)
                vim.cmd("windo diffthis")
            end)
            return true
        end,

    }):find()
end

function M.git_commands()
    local opts = {
        prompt_title = "~ git ~",
        layout_config = {
            height = .8,
            width = .4,
        }
    }
    create_telescope_search(opts)
end

function M.show_diff_for_branch()
    vim.fn.inputsave()
    local base_branch = vim.fn.input("base branch? ")
    vim.fn.inputrestore()
    if (base_branch == "q")
        then
            print(" quitting..")
            return
        end
    vim.fn.inputsave()
    local target_branch = vim.fn.input("target branch? ")
    vim.fn.inputrestore()
    if (target_branch == "q")
        then
            print(" quitting..")
            return
        end
    local cmd = "DiffviewOpen origin/" .. base_branch .. "..origin/" .. target_branch
    vim.fn.inputsave()
    local confirmation = vim.fn.input(cmd .. " ? [y/n] ")
    vim.fn.inputrestore()
    if (confirmation ~= "y")
    then
        return
    end
    print(" fetching..")
    vim.cmd[[Git fetch]]
    vim.cmd(cmd)
end


function M.git_push(set_upstream)
    vim.fn.inputsave()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD")
    local remote = vim.fn.system("git remote get-url --push origin")
    local set_upstream = set_upstream or false
    local confirmation
    if (set_upstream)
    then
        confirmation = vim.fn.input("push -u " .. branch .. " to " .. remote .. " ? ")
    else
        confirmation = vim.fn.input("push " .. branch .. " to " .. remote .. " ? ")
    end
    vim.fn.inputrestore()

    if (confirmation == "y")
    then
        if (set_upstream)
        then
            print(" push -u ...")
            vim.cmd("Git push -u")
        else
            vim.cmd("Git push")
            print(" push ...")
        end
    else
        print(" cancelled")
    end
end

function M.git_push_set_upstream()
    return M.git_push(true)
end

function M.see_diff()
    local opts = {
        prompt_title = "~ see diff ~",
        previewer = false,
    }
    -- local branch = require('telescope.builtin').git_branches(opts)
    -- print("here" .. branch)
    pickers.new(opts, {
        prompt_title = "colors",
        finder = finders.new_oneshot_job({ "git",  "branch", "-a" }, opts ),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                P(selection)
            end)
            return true
        end,

    }):find()

end

return M
