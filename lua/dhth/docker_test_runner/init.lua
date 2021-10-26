local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}

local function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

local function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function mysplit (inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

local function lines_from(file)
    if not file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = mysplit(line, "::")
    end
    return lines
end

---
local function failed_test_details (inputstr, projectstr)
    local file_name = mysplit(mysplit(inputstr, ' ')[2], '::')[1]
    local function_name = mysplit(inputstr, '::')[#mysplit(inputstr, '::')]
    return {
        filename = projectstr .. '/' .. file_name,
        pattern = trim(function_name),
    }
end

local function get_failed_test_summary(file, projectstr)
    if not file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = failed_test_details(line, projectstr)
    end
    return lines
end


-- local function run_tests_with_opts(opts)
--     local config = lines_from("./testconfig")
--     pickers.new(opts, {
--         prompt_title = "colors",
--         finder = finders.new_table {
--             results = config,
--             entry_maker = function(entry)
--                 return {
--                     value = entry,
--                     display = entry[1],
--                     ordinal = entry[1],
--                 }
--             end
--         },
--         sorter = conf.generic_sorter(opts),
--         attach_mappings = function(prompt_bufnr, _)
--             actions.select_default:replace(function()
--                 actions.close(prompt_bufnr)
--                 local selection = action_state.get_selected_entry()
--                 vim.cmd("Dispatch " .. selection.value[2])
--             end)
--             return true
--         end,
--     }):find()
-- end

local function run_tests_via_vimux(opts)
    local config = lines_from("./testconfig")
    pickers.new(opts, {
        prompt_title = "colors",
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
                vim.cmd("VimuxRunCommand('" .. selection.value[2] .. ' | tee testsfailedall' ..  "')")

                vim.cmd('silent !echo "' .. selection.value[3] .. '" > testlastproject')
            end)
            return true
        end,

    }):find()
end

function M.run_tests()
    local opts = {
        prompt_title = "~ tests 🧪 ~",
        layout_config = {
            height = .5,
            width = .4,
        }
    }
    run_tests_via_vimux(opts)
end


function M.failed_test_qf()
    local last_test_project = lines_from("testlastproject")[1][1]
    vim.cmd("silent !cat testsfailedall | grep FAILED > testsfailed")
    local qf = get_failed_test_summary('testsfailed', last_test_project)
    if next(qf) then
        -- vim.fn.setqflist(qf, 'r')
        vim.fn.setqflist({}, 'r', {title="Test failures ☹️", items=qf})
        vim.cmd("copen")
    end
end

-- local function failed_test_details_from_line_nums (inputstr, projectstr)
--         local file_name = mysplit(inputstr, ':')[1]
--         local line_num = tonumber(mysplit(inputstr, ':')[2])
--         local error = trim(mysplit(inputstr, ':')[3])
--         return {
--             filename = projectstr .. '/' .. file_name,
--             lnum = line_num,
--             text = error,
--     }
--     end

-- local function get_failed_test_summary_from_line_numbers(file, projectstr)
--   if not file_exists(file) then return {} end
--   local lines = {}
--   for line in io.lines(file) do
--     lines[#lines + 1] = failed_test_details_from_line_nums(line, projectstr)
--   end
--   return lines
-- end


-- function M.failed_test_qf_from_line_numbers()
--     local last_test_project = lines_from("testlastproject")[1][1]
--     vim.cmd("silent !cat testsfailedall | grep grep '.py:[0-9]' > testsfailed")
--     local qf = get_failed_test_summary_from_line_numbers('testsfailed', last_test_project)
--     if next(qf) then
--         -- vim.fn.setqflist(qf, 'r')
--         vim.fn.setqflist({}, 'r', {title="Test failures ☹️", items=qf})
--         vim.cmd("copen")
--     end
-- end



return M
