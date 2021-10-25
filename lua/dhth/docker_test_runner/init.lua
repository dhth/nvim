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


local function run_tests_with_opts(opts)
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
                vim.cmd("Dispatch " .. selection.value[2])
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
            width = .5,
        }
    }
    run_tests_with_opts(opts)
end


return M
