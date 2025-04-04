local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local git_helpers = require "custom.helpers.git"
local theme = require("telescope.themes").get_ivy
local ts_utils = require "nvim-treesitter.ts_utils"

local M = {}

function M.format_using_lsp()
    vim.lsp.buf.format { async = true }
    print "formatted 🧹"
end

function M.select()
    vim.ui.select({ "tabs", "spaces" }, {
        prompt = "Select tabs or spaces:",
        format_item = function(item)
            return "I'd like to choose " .. item
        end,
    }, function(choice)
        print("you chose: " .. choice)
    end)
end

function M.format_file()
    local file_type = vim.bo.filetype
    if file_type == "python" then
        vim.api.nvim_exec2(":silent ! ruff format %", { output = false })
    else
        vim.lsp.buf.format { async = true }
    end
end

function M.scala_run_main_file(switch_to_pane)
    switch_to_pane = switch_to_pane or false

    local file_path = vim.fn.expand "%:r"
    if not string.find(file_path, "src/main/scala/") then
        print "Error: File path does not contain 'src/main/scala/'"
        return
    end

    local mainFile =
        string.gsub((string.gsub(file_path, ".*src/main/scala/", "")), "/", ".")

    vim.cmd('silent VimuxRunCommand("runMain ' .. mainFile .. '")')
    if switch_to_pane then
        vim.cmd "silent !tmux select-pane -t .+1 && tmux resize-pane -Z"
    end
end

function M.scala_cli_run(switch_to_pane)
    switch_to_pane = switch_to_pane or false

    local filePath = vim.fn.expand "%"

    local command
    if ENDSWITH(filePath, ".test.scala") then
        command = "scala-cli test"
    else
        command = "scala-cli run"
    end

    vim.cmd('silent VimuxRunCommand("' .. command .. " " .. filePath .. '")')

    if switch_to_pane then
        vim.cmd "silent !tmux select-pane -t .+1 && tmux resize-pane -Z"
    end
end

function M.scala_run(switch_to_pane)
    local is_a_scala_cli_project = DOES_FILE_EXIST ".bsp/scala-cli.json"

    if is_a_scala_cli_project then
        M.scala_cli_run(switch_to_pane)
    else
        M.scala_run_main_file(switch_to_pane)
    end
end

local function create_telescope_search(opts)
    local file_type = vim.bo.filetype
    local config
    if file_type == "scala" then
        config = {
            { "compile" },
            { "test" },
            { "compile;test" },
            { "test:compile" },
            { "run" },
            { "stage" },
            { "dist" },
            { "docs/makeSite" },
            { "reload;fbrdCompliance" },
            { "reload;fbrdCompliance;compile" },
            { "reload;fbrdCompliance;compile;test" },
            { "fbrdCompliance;compile;test" },
            { "reload" },
            { "testQuick" },
            { "fbrdCompliance" },
            { "run" },
            { "clean" },
            { "docs/previewSite" },
        }
    else
        print "nothing configured for filetype, showing git helpers"
        return git_helpers.git_commands()
    end

    pickers
        .new(opts, {
            prompt_title = "~ " .. file_type .. " ~",
            finder = finders.new_table {
                results = config,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry[1],
                        ordinal = entry[1],
                    }
                end,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_tab:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()

                    if file_type == "scala" then
                        if string.match(selection.value[1], "run") then
                            M.scala_run(true)
                        else
                            vim.cmd(
                                'silent VimuxRunCommand("'
                                    .. selection.value[1]
                                    .. '")'
                            )
                            vim.cmd "silent !tmux select-pane -t .+1 && tmux resize-pane -Z"
                        end
                    elseif file_type == "fugitive" then
                        vim.cmd(selection.value[2])
                    end
                end)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()

                    if file_type == "scala" then
                        if string.match(selection.value[1], "run") then
                            M.scala_run()
                        else
                            vim.cmd(
                                'silent VimuxRunCommand("'
                                    .. selection.value[1]
                                    .. '")'
                            )
                        end
                    end
                    print("sent: " .. selection.value[1] .. " ⚡️")
                end)
                actions.select_vertical:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()

                    if file_type == "scala" then
                        if string.match(selection.value[1], "run") then
                            M.scala_run(true)
                        else
                            vim.cmd(
                                'silent VimuxRunCommand("'
                                    .. selection.value[1]
                                    .. '")'
                            )
                            vim.cmd "silent !tmux resize-pane -Z"
                        end
                    end
                end)
                return true
            end,
        })
        :find()
end

function M.show_commands()
    local opts = theme {
        results_title = false,
        layout_config = {
            height = 0.6,
        },
    }
    create_telescope_search(opts)
end

function M.add_todo_comment()
    local opts = {
        layout_config = {
            height = 0.6,
            width = 0.4,
        },
    }
    local config = {
        { "ques", "QUES" },
        { "fixit", "FIXIT" },
    }

    pickers
        .new(opts, {
            prompt_title = "~ todo ~",
            results_title = "type",
            finder = finders.new_table {
                results = config,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry[1],
                        ordinal = entry[1],
                    }
                end,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vim.api.nvim_command(
                        "normal O" .. selection.value[2] .. ":gccj"
                    )
                end)
                return true
            end,
        })
        :find()
end

function M.reload_module()
    local file_type = vim.bo.filetype

    if file_type ~= "lua" then
        print "reload module only works from a lua file"
        return
    end

    local file_path = vim.fn.expand "%:p"
    local module_name_till_end = SPLIT_STRING(file_path, "lua/")[2]

    local module_name = SPLIT_STRING(module_name_till_end, ".lua")[1]

    vim.cmd('lua R("' .. module_name .. '")')
    print("reloaded " .. module_name .. " ⚡️")
end

function M.reload_selected_module()
    local packages =
        vim.fn.system [[find ~/.config/nvim/lua -name '*.lua' | sed 's/\.lua//' | sed "s|$HOME/.config/nvim/lua/||"]]
    local packages_array = vim.split(packages, "\n")
    table.remove(packages_array) -- remove the last entry which is a empty line
    table.insert(packages_array, "dhth")

    pickers
        .new(opts, {
            prompt_title = "~ modules ~",
            results_title = "module",
            finder = finders.new_table {
                results = packages_array,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry,
                        ordinal = entry,
                    }
                end,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vim.cmd('lua R("dhth.' .. selection.value .. '")')
                    print("reloaded dhth." .. selection.value .. " ⚡️")
                end)
                return true
            end,
        })
        :find()
end

function M.run_line_as_command()
    local line_number = vim.api.nvim_win_get_cursor(0)[1]

    local line_contents =
        vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]

    vim.cmd("silent !" .. line_contents)
end

function M.highlight_range(bufnr, start_line, end_line, highlight_duration_ms)
    local ns_id = vim.api.nvim_create_namespace "flash_highlight"
    local hl_group = "FlashRangeHighlight"

    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

    for line = start_line, end_line do
        vim.api.nvim_buf_add_highlight(bufnr, ns_id, hl_group, line - 1, 0, -1)
    end

    vim.defer_fn(function()
        vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    end, highlight_duration_ms)
end

-- This function searches for a code block (most likely in a markdown file),
-- and formats its using an external formatting tool (eg. jq). It then
-- highlights the newly formatted code block for a short duration (using
-- M.highlight_range).
-- Highlight defined here: ../../../general/highlights.vim
function M.format_code_block()
    local filetype = vim.bo.filetype
    local current_line = vim.fn.line "."
    local format_prg

    local start_line
    local end_line
    local code_block_type

    if filetype ~= "markdown" then
        print "filetype not supported"
        return
    end

    for i = current_line, vim.fn.line "^", -1 do
        if vim.fn.getline(i):match "^```" then
            start_line = i
            code_block_type = SPLIT_STRING(vim.fn.getline(i), "```")[2]
            break
        end
    end

    for i = current_line, vim.fn.line "$" do
        if vim.fn.getline(i):match "^```$" then
            end_line = i
            break
        end
    end

    if (start_line ~= nil) and (end_line ~= nil) then
        if code_block_type == "json" then
            format_prg = "jq"
        elseif code_block_type == "go" then
            format_prg = "gofmt"
        elseif code_block_type == "rust" then
            format_prg = "rustfmt"
        elseif code_block_type == "python" then
            format_prg = "black - --quiet"
        elseif code_block_type == "scala" then
            format_prg =
                "scalafmt --config .scalafmt.conf  --stdin --stdout --quiet"
        else
            print "Code block not supported"
            return
        end
        local range_string =
            string.format("%d,%d", start_line + 1, end_line - 1)
        vim.api.nvim_exec(":" .. range_string .. "!" .. format_prg, false)
    else
        print "Couldn't find a code block"
    end

    -- after formatting
    -- SLEEP(.2, function()
    local start_line_after_format = vim.fn.line "."
    local end_line_after_format

    for i = start_line_after_format, vim.fn.line "$" do
        if vim.fn.getline(i):match "^```$" then
            end_line_after_format = i
            break
        end
    end
    if end_line_after_format ~= nil then
        M.highlight_range(
            CURRENT_BUFFER_NUMBER(),
            start_line_after_format,
            end_line_after_format - 1,
            1000
        )
    end
    -- end)
end

function M.add_link_to_md()
    local clipboard_contents = vim.api.nvim_exec("echo getreg('*')", true)

    if string.find(clipboard_contents, "\n") then
        print "Clipboard contains multiple lines"
        return
    end

    if not string.match(clipboard_contents, "^http.*") then
        print "Clipboard doesn't contain a url"
        return
    end

    local url_to_add = clipboard_contents

    local current_bufnr = vim.fn.bufnr "%"

    local line_count = vim.fn.line "$"

    local last_line = vim.fn.getline(line_count)

    local pattern = "^%[(%d+)%]: http.*$"

    local lines_to_add
    local new_url_number

    if string.match(last_line, pattern) then
        local captured_digit = string.match(last_line, pattern)
        new_url_number = tonumber(captured_digit) + 1
        lines_to_add = { "[" .. new_url_number .. "]: " .. url_to_add }
    else
        new_url_number = 1
        lines_to_add = { "", "[" .. new_url_number .. "]: " .. url_to_add }
    end

    if lines_to_add then
        local lines = vim.api.nvim_buf_get_lines(current_bufnr, 0, -1, false)
        local extended_lines = vim.list_extend(lines, lines_to_add)
        vim.api.nvim_buf_set_lines(current_bufnr, 0, -1, false, extended_lines)
    end

    if new_url_number then
        vim.api.nvim_exec("normal! a" .. "[" .. new_url_number .. "]", false)
    end
end

function M.dstll()
    local file_path = vim.fn.expand "%"
    local file_type = vim.bo.filetype

    vim.cmd "vnew"
    vim.cmd "setlocal buftype=nofile"
    vim.cmd("setlocal filetype=" .. file_type)
    vim.cmd "setlocal nobuflisted"

    local bufnr = vim.fn.bufnr "%"

    local command = "echo '" .. file_path .. "' | dstll -plain"

    vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = function(_, data, _)
            table.remove(data, #data)
            vim.api.nvim_buf_set_text(bufnr, 0, 0, 0, 0, data)
        end,
    })
end

function M.d2_code_to_file()
    if vim.bo.filetype ~= "d2" then
        print "not a d2 file"
        return
    end

    local file_name = vim.fn.expand "%:t:r"

    local current_dir_rel = vim.fn.expand "%:h"

    local command = {
        "d2",
        current_dir_rel .. "/" .. file_name .. ".d2",
        current_dir_rel .. "/assets/" .. file_name .. ".svg",
    }

    local on_exit_fn = function(obj)
        P(obj.stderr)
    end

    vim.system(command, { text = true }, on_exit_fn)
end

function M.format_d2()
    local full_file_path = vim.fn.expand "%:p"

    local command = "d2 fmt " .. full_file_path

    vim.cmd("silent !" .. command)
end

function M.format_terraform()
    local full_file_path = vim.fn.expand "%:p"

    local command = "terraform fmt " .. full_file_path

    vim.cmd("silent !" .. command)
end

function M.add_return_type_arrow()
    local file_type = vim.bo.filetype

    local command
    if file_type == "rust" then
        command = "normal! A -> "
    else
        print "nothing configured"
    end

    vim.api.nvim_command(command)
end

function M.add_semicolon()
    local file_type = vim.bo.filetype

    local command
    if file_type == "rust" then
        command = "normal! A;"
    else
        print "nothing configured"
    end

    vim.cmd(command)
    vim.cmd "stopinsert"
end

local definition_win_id = nil
local definition_match_id = nil

function M.show_definition()
    local params = vim.lsp.util.make_position_params()
    local current_win = vim.api.nvim_get_current_win()

    vim.lsp.buf_request(
        0,
        "textDocument/definition",
        params,
        function(err, result, _, _)
            if err then
                print("Error: " .. err.message)
                return
            end

            if not result or vim.tbl_isempty(result) then
                print "Definition not found"
                return
            end

            -- Handle the case where result is a list of locations or a single location
            local location = result[1]
            if type(result) == "table" and result.targetUri then
                location = result
            end

            if not location or not location.targetUri then
                print "Invalid location or targetUri"
                return
            end

            local uri = location.targetUri
            local bufnr = vim.uri_to_bufnr(uri)
            vim.fn.bufload(bufnr)
            local start_line = location.targetRange.start.line

            -- Create or reuse the buffer on the right-hand side
            if
                definition_win_id
                and vim.api.nvim_win_is_valid(definition_win_id)
            then
                vim.api.nvim_set_current_win(definition_win_id)
            else
                vim.cmd "vsplit"
                definition_win_id = vim.api.nvim_get_current_win()
            end

            vim.api.nvim_win_set_buf(definition_win_id, bufnr)
            vim.api.nvim_win_set_cursor(
                definition_win_id,
                { start_line + 1, 0 }
            )
            vim.cmd "normal! zt"
            vim.cmd "normal! 10k"
            vim.cmd "normal! 10j"

            if definition_match_id then
                local success, _ =
                    pcall(vim.fn.matchdelete, definition_match_id)
                if success then
                    definition_match_id = nil
                end
            end

            definition_match_id = vim.fn.matchadd(
                "DefinitionHighlight",
                "\\%" .. (start_line + 1) .. "l"
            )

            vim.api.nvim_set_current_win(current_win)
        end
    )
end

--- Adds a print statement for the word under the cursor.
-- eg. running this when on "app_state" will add the following line
-- ```rust
-- let app_state = AppState {
--     server_info,
--     config,
-- };
-- println!("app_state: {:?}", app_state); // <- here
-- ```
function M.print_item()
    local current_word = vim.fn.expand "<cword>"

    local print_statement
    local ft = vim.bo.filetype
    if ft == "scala" then
        print_statement =
            string.format('println(s"%s: ${%s}")', current_word, current_word)
    elseif ft == "rust" then
        print_statement = string.format(
            'println!("%s: {:?}", %s);',
            current_word,
            current_word
        )
    elseif ft == "go" then
        print_statement = string.format(
            'fmt.Printf("%s: %%s", %s)',
            current_word,
            current_word
        )
    else
        print "unsupported file type"
        return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_node = ts_utils.get_node_at_cursor()

    if not cursor_node then
        print "no Treesitter parser found"
        return
    end

    local parent_node = cursor_node:parent()

    if not parent_node then
        print "couldn't find the parent node"
        return
    end

    local _, _, end_row, _ = parent_node:range()

    local current_line = vim.api.nvim_get_current_line()
    local current_indent = current_line:match "^%s*"

    vim.api.nvim_buf_set_lines(
        bufnr,
        end_row + 1,
        end_row + 1,
        false,
        { current_indent .. print_statement }
    )
end

--- code helpers
NOREMAP_SILENT("n", "<leader>ch", M.show_commands)
NOREMAP_SILENT("n", "M", M.show_commands)

--- code helpers
NOREMAP_SILENT("n", "t<c-j>", M.show_commands)

--- run line as command
NOREMAP_SILENT("n", "<Leader>ru", M.run_line_as_command)

--- run line as command
NOREMAP_SILENT("n", "<Leader>ru", M.run_line_as_command)

--- add return type arrow
-- NOREMAP_SILENT("n", "L", M.add_return_type_arrow)

--- add semicolon
NOREMAP_SILENT("i", ";;", M.add_semicolon)
NOREMAP_SILENT("n", ";;", M.add_semicolon)

-- NOREMAP_SILENT("n", "L", M.show_definition)
NOREMAP_SILENT("n", "<leader>db", M.print_item)

return M
