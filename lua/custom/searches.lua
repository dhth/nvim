local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local theme = require("telescope.themes").get_ivy
local action_state = require "telescope.actions.state"
local finders = require "telescope.finders"
local builtin = require "telescope.builtin"

local M = {}

-- How this works:
-- 1. Read executable search definitions from two sources:
--    - project-local: $PWD/.searches/
--    - personal global: ~/.config/searches/
-- 2. Normalize both into the same entry shape:
--    { label, source, command }
-- 3. Merge them so local entries override global ones on exact label match.
-- 4. Sort locals first, then globals, alphabetically within each group.
-- 5. Show a first Telescope picker of available searches.
-- 6. When one is selected, run its command through a second Telescope
--    file picker via search_files_for_command(...).

local function search_files_for_command(prompt_title, command)
    local opts = theme {
        prompt_title = prompt_title,
        results_title = false,
        previewer = false,
        preview_title = false,
        find_command = command,
    }

    builtin.find_files(opts)
end

local function search_display(entry)
    local source = entry.source == "local" and "loc" or "gbl"
    return "[" .. source .. "] " .. entry.label
end

local function sort_searches(entries)
    table.sort(entries, function(left, right)
        return left.label < right.label
    end)
end

local function global_searches_dir()
    return vim.fn.expand "~/.config/searches"
end

local function local_searches_dir()
    return vim.fn.getcwd() .. "/.searches"
end

local function is_search_file(label, path)
    return string.sub(label, 1, 1) ~= "."
        and vim.fn.filereadable(path) == 1
        and vim.fn.executable(path) == 1
end

local function searches_from_dir(searches_dir, source)
    if vim.fn.isdirectory(searches_dir) == 0 then
        return {}
    end

    local searches = {}

    for _, label in ipairs(vim.fn.readdir(searches_dir)) do
        local path = searches_dir .. "/" .. label
        if is_search_file(label, path) then
            table.insert(searches, {
                label = label,
                source = source,
                command = { path },
            })
        end
    end

    return searches
end

local function merged_searches()
    local locals = searches_from_dir(local_searches_dir(), "local")
    local globals = searches_from_dir(global_searches_dir(), "global")
    local local_labels = {}

    sort_searches(locals)

    for _, entry in ipairs(locals) do
        local_labels[entry.label] = true
    end

    local filtered_globals = {}
    for _, entry in ipairs(globals) do
        if not local_labels[entry.label] then
            table.insert(filtered_globals, entry)
        end
    end

    sort_searches(filtered_globals)

    local searches = {}
    vim.list_extend(searches, locals)
    vim.list_extend(searches, filtered_globals)

    return searches
end

function M.searches()
    local searches = merged_searches()

    if vim.tbl_isempty(searches) then
        print "no searches defined"
        return
    end

    local opts = theme {
        prompt_title = "~ searches ~",
        results_title = false,
        previewer = false,
        preview_title = false,
        layout_config = {
            height = 0.6,
        },
    }

    pickers
        .new(opts, {
            finder = finders.new_table {
                results = searches,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = search_display(entry),
                        ordinal = entry.label,
                    }
                end,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    search_files_for_command(
                        "~ " .. selection.value.label .. " ~",
                        selection.value.command
                    )
                end)
                return true
            end,
        })
        :find()
end

return M
