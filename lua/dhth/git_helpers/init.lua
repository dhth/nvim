local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local theme = require('telescope.themes').get_ivy

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local checkout = require('telescope.builtin').git_branches

local M = {}

local function create_telescope_search(opts)
    -- third column is 0 when task is supposed to be done in the background, else 1
    local config = {
        { "pull",                     "Git pull",                        "0", "pulled!" },
        { "checkout",                 checkout,                          "1", "" },
        { "push",                     M.git_push,                        "1", "" },
        { "push -u",                  M.git_push_set_upstream,           "1", "" },
        { "fetch",                    "Git fetch",                       "0", "fetched!" },
        { "diff",                     "DiffviewOpen",                    "1", "" },
        { "diff window",              M.show_diff_in_window,             "0", "" },
        { "diff branch",              M.show_diff_for_branch,            "0", "" },
        { "diff cached",              "DiffviewOpen --cached",           "1", "" },
        { "diff with master",         "Git difftool -y origin/master %", "1", "" },
        { "checkout master",          "Git checkout master",             "0", "checked out master!" },
        { "checkout master and pull", "Git checkout master | Git pull",  "0", "checked out master and pulled!" },
        { "rebase o/master",          "Git rebase origin/master",        "0", "rebased!" },
        { "stash push, rebase o/master and stash pop", "Git stash push | Git rebase origin/master | Git stash pop", "0",
            "rebased!" },
        { "stash push, checkout master, pull, and stash pop",
            "Git stash push | Git checkout master | Git pull | Git stash pop", "0",
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
                    ordinal = entry[1],
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

local function diff_commit_search(opts, commits, stage, source_commit)
    -- Allows two kinds of diffs:
    -- - diff current file
    -- - diff entire tree
    -- Can show diff in the same window or a new one
    local prompt_title
    if stage == 1 then
        prompt_title = "diff with which commit?"
        print("👉  <c-t> to diff in a new tab; <c-v> to diff a range; <c-x> to diff commit with it's parent")
    else
        prompt_title = source_commit .. ".. ?"
        print("👉  <c-t> to diff the entire tree")
    end

    pickers.new(opts, {
        prompt_title = prompt_title,
        finder = finders.new_table {
            results = commits,
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
                local commit_hash = SPLIT_STRING(SPLIT_STRING(selection.value, ">> ")[2], " <<")[1]

                if not commit_hash then
                    print("Couldn't find a commit hash")
                    return
                end

                local file_name = vim.fn.expand("%")
                if stage == 1 then
                    vim.api.nvim_exec2("only", { output = false })
                    vim.api.nvim_exec2("Gvdiffsplit! " .. commit_hash, { output = false })
                    -- For some reason, the diff doesn't align properly with just the
                    -- Gvdiffsplit command, a second diffthis is needed, after a small delay
                    vim.defer_fn(function()
                        vim.api.nvim_exec2("windo diffthis", { output = false })
                        local message = "git diff " .. commit_hash .. " -- " .. file_name
                        print("👉 " .. message)
                        vim.fn.setreg('+', message)
                    end, 5)
                else
                    vim.api.nvim_exec2("only", { output = false })
                    vim.api.nvim_exec2("DiffviewOpen " .. source_commit .. ".." .. commit_hash .. " -- %",
                        { output = false })
                    -- For some reason, the diff doesn't align properly with just the
                    -- Gvdiffsplit command, a second diffthis is needed, after a small delay
                    vim.defer_fn(function()
                        vim.api.nvim_exec2("windo diffthis", { output = false })
                        local message = "git diff " .. source_commit .. ".." .. commit_hash .. " -- " .. file_name
                        print("👉 " .. message)
                        vim.fn.setreg('+', message)
                    end, 5)
                end
            end)
            actions.select_horizontal:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                local commit_hash = SPLIT_STRING(SPLIT_STRING(selection.value, ">> ")[2], " <<")[1]

                if not commit_hash then
                    print("Couldn't find a commit hash")
                    return
                end

                if stage == 1 then
                    local file_name = vim.fn.expand("%")
                    vim.api.nvim_exec2("only", { output = false })
                    vim.api.nvim_exec2("DiffviewOpen " .. commit_hash .. "~1.." .. commit_hash .. " -- " .. file_name,
                        { output = false })
                    -- For some reason, the diff doesn't align properly with just the
                    -- Gvdiffsplit command, a second diffthis is needed, after a small delay
                    vim.defer_fn(function()
                        vim.api.nvim_exec2("windo diffthis", { output = false })
                        local message = "git diff " .. commit_hash .. "~1.." .. commit_hash .. " -- " .. file_name
                        print("👉 " .. message)
                        vim.fn.setreg('+', message)
                    end, 5)
                end
            end)
            actions.select_vertical:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                local commit_hash = SPLIT_STRING(SPLIT_STRING(selection.value, ">> ")[2], " <<")[1]

                if not commit_hash then
                    print("Couldn't find a commit hash")
                    return
                end

                return diff_commit_search(opts, commits, 2, commit_hash)
            end)
            actions.select_tab:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                local commit_hash = SPLIT_STRING(SPLIT_STRING(selection.value, ">> ")[2], " <<")[1]
                if not commit_hash then
                    print("Couldn't find a commit hash")
                    return
                end

                if stage == 1 then
                    local file_name = vim.fn.expand("%")
                    vim.api.nvim_exec2("tabe %", { output = false })
                    vim.api.nvim_exec2("Gvdiffsplit! " .. commit_hash, { output = false })
                    -- For some reason, the diff doesn't align properly with just the
                    -- Gvdiffsplit command, a second diffthis is needed, after a small delay
                    vim.defer_fn(function()
                        vim.api.nvim_exec2("windo diffthis", { output = false })
                        local message = "git diff " .. commit_hash .. " -- " .. file_name
                        print("👉 " .. message)
                        vim.fn.setreg('+', message)
                    end, 5)
                else
                    vim.api.nvim_exec2("tabe %", { output = false })
                    vim.api.nvim_exec2("DiffviewOpen " .. source_commit .. ".." .. commit_hash,
                        { output = false })
                    -- For some reason, the diff doesn't align properly with just the
                    -- Gvdiffsplit command, a second diffthis is needed, after a small delay
                    vim.defer_fn(function()
                        vim.api.nvim_exec2("windo diffthis", { output = false })
                        local message = "git diff " .. source_commit .. ".." .. commit_hash
                        print("👉 " .. message)
                        vim.fn.setreg('+', message)
                    end, 5)
                end
            end)
            return true
        end,

    }):find()
end


function M.git_diff()
    local commits = vim.fn.systemlist(
        "git --no-pager log --all --graph --oneline --pretty=format:'      >> %h <<   %d %s (%cr)' --since='1 month ago'")
    diff_commit_search(theme(), commits, 1, nil)
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
    vim.cmd [[Git fetch]]
    vim.cmd(cmd)
end

function M.git_push(set_upstream)
    vim.api.nvim_exec2("vsplit term://gpp", { output = false })
    -- vim.fn.inputsave()
    -- local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD")
    -- local remote = vim.fn.system("git remote get-url --push origin")
    -- local set_upstream = set_upstream or false
    -- local confirmation
    -- local random_string = RANDOMCHARS(2)
    -- if (set_upstream)
    -- then
    --     confirmation = vim.fn.input("push -u " ..
    --         branch .. " to " .. remote .. " ? Type [" .. random_string .. "] to confirm: ")
    -- else
    --     confirmation = vim.fn.input("push " ..
    --         branch .. " to " .. remote .. " ? Type [" .. random_string .. "] to confirm: ")
    -- end
    -- vim.fn.inputrestore()
    --
    -- if (confirmation == random_string)
    -- then
    --     if (set_upstream)
    --     then
    --         print(" push -u ...")
    --         vim.api.nvim_exec2("vsplit term://git push -u", { output = false })
    --     else
    --         print(" push ...")
    --         vim.api.nvim_exec2("vsplit term://gpp", { output = false })
    --     end
    -- else
    --     print(" cancelled/incorrect input")
    -- end
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
        finder = finders.new_oneshot_job({ "git", "branch", "-a" }, opts),
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

function M.diff_with_main_branch()
    local main_branch = TRIM(vim.fn.system('[ -f ".mainbranch" ] && cat ".mainbranch" || echo "main"'))

    print("diffing with " .. main_branch)

    vim.cmd("Gvdiffsplit! " .. main_branch .. ":%")
end

return M
