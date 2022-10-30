local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}

local function create_telescope_search(opts)
    -- third column is 0 when task is supposed to be done in the background, else 1
    local config = {
        { "pull", "Git pull", "0", "pulled!" },
        { "fetch", "Git fetch", "0", "fetched!" },
        { "diff", "DiffviewOpen", "1", "" },
        { "diff cached", "DiffviewOpen --cached", "1", "" },
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
                vim.cmd(selection.value[2])
                if selection.value[3] == "0" then
                    print(selection.value[4])
                end

            end)
            return true
        end,

    }):find()
end

function M.git_commands()
    local opts = {
        prompt_title = "~ git ~",
        layout_config = {
            height = .5,
            width = .4,
        }
    }
    create_telescope_search(opts)
end

function M.git_push()
    vim.fn.inputsave()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD")
    local remote = vim.fn.system("git remote get-url --push origin")
    local confirmation = vim.fn.input("push " .. branch .. " to " .. remote .. " ? ")
    vim.fn.inputrestore()

    if (confirmation == "y")
    then
        print(" pushing...")
        vim.cmd("Git push")
    else
        print(" cancelled")
    end
end

return M
