local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}

local function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end


local function failed_test_details (inputstr, projectstr)
    local file_name = mysplit(mysplit(inputstr, ' ')[2], '::')[1]
    --- function name is a bit tricky to extract
    -- examples:
    -- FAILED tests/test_file.py::TestClass::test_with_parameterize[param1]
    -- FAILED tests/test_file.py::TestClass::test_with_parameterize[param2]
    -- FAILED tests/test_file.py::TestClass::test_example_2
    -- FAILED tests/test_file.py::TestClass::test_example_3 - sq...
    -- FAILED tests/test_file.py::TestClass::test_example_4 - sq...
    local function_name = mysplit(mysplit(mysplit(inputstr, '::')[#mysplit(inputstr, '::')], ' ')[1], '[')[1]
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


local function scala_test_results_to_qf()
    print("running tests...")
    local cmd = "sbt test"
    local state = {}

    local test_details
    local test_details_raw
    vim.fn.jobstart(SPLIT(cmd, " "), {
        stdout_buffered = true,
        on_stdout = function(_, data)
            for _, line in ipairs(data) do
                if string.match(line, 'Spec.scala:') then
                    test_details_raw = TRIM(vim.fn.system('echo \'' .. line .. '\' | python $HOME/.config/nvim/lua/dhth/command_to_buffer/helper.py'))
                    test_details = vim.json.decode(test_details_raw)
                    table.insert(state, test_details)
                end
            end
        end,
        on_exit = function ()
            local failed = {}
            local full_file_path
            for _, details in ipairs(state) do
                full_file_path = TRIM(vim.fn.system("fd -ipH -t f " .. details.file_name .. ".scala"))
                failed[#failed + 1] = {
                    filename = full_file_path,
                    lnum=details.lnum,
                    type='E',
                    text=details.error_message,
                }
            end
            if #state > 0 then
                vim.fn.setqflist({}, 'r', {title="Test failures ❌ ", items=failed})
                print("test results ready, [" .. #state .. "] failure(s) 🧪")
                -- vim.cmd("copen")
            else
                print("no failing tests ✅")
            end
        end
    }
    )
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
    local file_type = vim.bo.filetype
    --- this will search for test files containing the name of the current file
    if file_type == "scala" then
        scala_test_results_to_qf()
    elseif file_type == "python" then
        local last_test_project = lines_from("testlastproject")[1][1]
        vim.cmd("silent !cat testsfailedall | grep 'FAILED ' > testsfailed")
        local qf = get_failed_test_summary('testsfailed', last_test_project)
        if next(qf) then
            -- vim.fn.setqflist(qf, 'r')
            vim.fn.setqflist({}, 'r', {title="Test failures ❌ ", items=qf})
            vim.cmd("copen")
        end
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
--         vim.fn.setqflist({}, 'r', {title="Test failures ☹️  ", items=qf})
--         vim.cmd("copen")
--     end
-- end


function M.search_tests_for_current_file()
    local current_file = vim.fn.expand('%:t:r')
    local file_type = vim.bo.filetype
    --- this will search for test files containing the name of the current file
    if file_type == "python" then
        require ("dhth.telescope").find_test_files('test_' .. current_file .. '.*.py$')
    elseif file_type == "scala" then
        require ("dhth.telescope").find_test_files(current_file .. 'Spec.scala')
        -- then file_pattern = ".*/test/scala/.*test_.*.py$"
    end
    -- vim.cmd("silent !cat testsfailedall | grep 'FAILED ' > testsfailed")
    -- local qf = get_failed_test_summary('testsfailed', last_test_project)
    -- if next(qf) then
    --     -- vim.fn.setqflist(qf, 'r')
    --     vim.fn.setqflist({}, 'r', {title="Test failures ☹️  ", items=qf})
    --     vim.cmd("copen")
    -- end
end


function M.go_to_next_test()
    local current_file = vim.fn.expand('%:t:r')
    local file_type = vim.bo.filetype
    if file_type == "scala" then
        -- vim.fn.search('".*" in .* { .* =>$')
        vim.cmd([[silent vimgrep /".*" in .*/ %]])
        -- vim.cmd([[Telescope quickfix]])
        require ("telescope.builtin").quickfix({
            previewer=false,
            trim_text=true,
            ignore_filename=true,
            sorting_strategy="ascending",
    })
    end
end


return M
