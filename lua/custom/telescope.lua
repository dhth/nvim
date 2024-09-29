local telescope = require "telescope"
local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local theme = require("telescope.themes").get_ivy
local action_state = require "telescope.actions.state"
local finders = require "telescope.finders"
local builtin = require "telescope.builtin"

local M = {}

function M.telescope_pickers()
    local opts = theme {
        prompt_title = "~ pickers ~",
        results_title = false,
        preview_title = false,
        previewer = true,
        layout_config = {
            height = 0.9,
        },
    }

    builtin.pickers(opts)
end

function M.file_browser()
    local opts = theme {
        prompt_title = "~ file browser ~",
        results_title = false,
        show_line = false,
        previewer = true,
        preview_title = false,
        layout_config = {
            height = 0.9,
        },
    }

    builtin.pickers.file_browser(opts)
end

function M.lsp_references()
    local opts = theme {
        prompt_title = "~ references ~",
        results_title = false,
        show_line = false,
        previewer = true,
        preview_title = false,
        layout_config = {
            height = 0.9,
        },
        -- cache_picker = cache_picker_config(),
    }

    builtin.lsp_references(opts)
end

function M.edit_neovim()
    local opts = theme {
        prompt_title = "~ nvim ~",
        results_title = false,
        cwd = "~/.config/nvim",
        previewer = false,
        layout_config = {
            height = 0.6,
        },
    }

    builtin.find_files(opts)
end

function M.grep_nvim()
    local opts = theme {
        prompt_title = "~ grep ~/.config/nvim ~",
        results_title = false,
        preview_title = false,
        cwd = "~/.config/nvim",
        previewer = true,
        layout_config = {
            height = 0.6,
        },
    }

    telescope.extensions.live_grep_args.live_grep_args(opts)
end

function M.grep_projects()
    local opts = theme {
        prompt_title = "~ projects ~",
        results_title = false,
        layout_config = {
            height = 0.6,
        },
    }

    local config =
        vim.fn.systemlist 'fd . --max-depth=1 "$HOME/.config" $PROJECTS_DIR $WORK_DIR'

    pickers
        .new(opts, {
            prompt_title = "~ grep projects ~",
            finder = finders.new_table {
                results = config,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = string.gsub(
                            entry,
                            vim.fn.expand "$HOME/",
                            ""
                        ),
                        ordinal = entry,
                    }
                end,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    local args = theme {
                        prompt_title = "grep ~ " .. selection.display .. " ~",
                        results_title = false,
                        preview_title = false,
                        cwd = selection.value,
                        previewer = true,
                        layout_config = {
                            height = 0.6,
                        },
                    }
                    -- local args = {
                    --     prompt_title = "grep ~ " .. selection.display .. " ~",
                    --     cwd = selection.value,
                    --     previewer = true,
                    --     layout_config = {
                    --         height = .9,
                    --         width = .9,
                    --         horizontal = {
                    --             preview_width = 0.55,
                    --             results_width = 0.45,
                    --         },
                    --     }
                    -- }
                    telescope.extensions.live_grep_args.live_grep_args(args)
                end)
                return true
            end,
        })
        :find()
end

function M.search_projects()
    local opts = theme {
        prompt_title = "~ search projects ~",
        results_title = false,
        previewer = false,
        layout_config = {
            height = 0.6,
        },
    }

    local config =
        vim.fn.systemlist "fd . --max-depth=1 $PROJECTS_DIR $WORK_DIR $CONFIG_DIR $MAC_CONFIG_DIR"

    pickers
        .new(opts, {
            prompt_title = "~ search projects ~",
            finder = finders.new_table {
                results = config,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = string.gsub(
                            entry,
                            vim.fn.expand "$HOME/",
                            ""
                        ),
                        ordinal = entry,
                    }
                end,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    local opts_for_find_files = theme {
                        find_command = {
                            "fd",
                            "-ipH",
                            "-t=f",
                        },
                        prompt_title = "~ search " .. selection.display .. " ~",
                        results_title = false,
                        cwd = selection.value,
                        previewer = false,
                        layout_config = {
                            height = 0.6,
                        },
                    }
                    return builtin.find_files(opts_for_find_files)
                end)
                return true
            end,
        })
        :find()
end

function M.lcd_to_dir()
    local opts = theme {
        prompt_title = "~ change project ~",
        results_title = false,
        layout_config = {
            height = 0.6,
        },
    }

    local config =
        vim.fn.systemlist 'fd . -t d --max-depth=1 "$HOME/.config" $PROJECTS_DIR $WORK_DIR'

    pickers
        .new(opts, {
            finder = finders.new_table {
                results = config,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = string.gsub(
                            entry,
                            vim.fn.expand "$HOME/",
                            ""
                        ),
                        ordinal = entry,
                    }
                end,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vim.api.nvim_command "tabnew"
                    vim.api.nvim_command("lcd " .. selection.value)
                    print(
                        "👉 tab's working directory set to: "
                            .. selection.value
                    )
                end)
                return true
            end,
        })
        :find()
end

function M.edit_dotfiles()
    local opts = {
        prompt_title = "~ dotfiles ~",
        cwd = "$DOT_FILES_DIR",
        previewer = false,
    }

    builtin.find_files(opts)
end

function M.find_files()
    local opts = {
        prompt_title = "~ files ~",
        previewer = false,
        -- find_command = {
        --     "fd",
        --     "-ipH",
        --     "-t=f",
        -- },
    }

    builtin.find_files(opts)
end

function M.enter_file_path()
    local function create_mappings(prompt_bufnr, _)
        actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.api.nvim_exec2(
                'norm!i--8<-- "' .. selection.value .. '"',
                { output = false }
            )
        end)
        return true
    end
    local opts = theme {
        prompt_title = "~ insert link to file ~",
        results_title = false,
        previewer = false,
        layout_config = {
            height = 0.6,
        },
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            "--relative-path",
        },
        attach_mappings = create_mappings,
    }

    builtin.find_files(opts)
end

function M.search_md_files()
    local opts = {
        prompt_title = "~ search markdown ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            "-e=md",
        },
    }

    builtin.find_files(opts)
end

function M.search_nearby_files()
    local current_dir = vim.fn.expand "%:p:h"
    local opts = {
        prompt_title = "~ files nearby 🚎 ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            "--search-path=" .. current_dir,
            "--max-depth=2",
        },
    }

    builtin.find_files(opts)
end

function M.nearby_file_browser()
    local opts = {
        prompt_title = "~ files nearby 🚎 ~",
        previewer = false,
        cwd = telescope.utils.buffer_dir(),
        hidden = true,
        layout_config = {
            height = 0.8,
        },
    }

    telescope.extensions.file_browser.file_browser(opts)
end

function M.find_dockerfiles()
    local opts = {
        prompt_title = "~ dockerfiles ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            ".*Dockerfile.*",
        },
    }

    builtin.find_files(opts)
end

function M.find_docker_compose_files()
    local opts = {
        prompt_title = "~ docker compose ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            ".*docker.*.yml",
        },
    }

    builtin.find_files(opts)
end

function M.find_local_only_files()
    local opts = {
        prompt_title = "~ local only ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            "local_only.*",
        },
    }

    builtin.find_files(opts)
end

function M.find_test_files(search_str, prompt_title)
    local file_pattern
    local prompt
    if prompt_title then
        prompt = prompt_title
    else
        prompt = "~ tests ~"
    end
    if search_str then
        file_pattern = search_str
    else
        local file_type = vim.bo.filetype
        if file_type == "python" then
            file_pattern = ".*/tests/.*test_.*.py$"
        elseif file_type == "scala" then
            file_pattern = ".*Spec.scala$"
        else
            file_pattern = ".*test.*"
        end
    end
    local opts = {
        prompt_title = prompt,
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            "--case-sensitive",
            file_pattern,
        },
        -- cache_picker = cache_picker_config(),
    }

    builtin.find_files(opts)
end

function M.search_wiki()
    local opts = {
        prompt_title = "~ wiki ~",
        -- cwd = "$WIKI_DIR",
        find_command = {
            "fd",
            "-t=f",
            "-e=md",
            "--search-path=/Users/dht93/Projects/knowledge",
        },
        previewer = false,
    }
    builtin.find_files(opts)
end

function M.search_work_wiki()
    local opts = {
        prompt_title = "~ work wiki ~",
        -- cwd = "$WORK_WIKI_DIR",
        find_command = {
            "fd",
            "-t=f",
            "-e=md",
            "--search-path=/Users/dht93/Projects/deeplynx-wiki",
        },
        previewer = false,
    }
    builtin.find_files(opts)
end

function M.search_dirs(search_directory)
    local opts = {
        prompt_title = "~ search dir ~",
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            "--search-path=" .. search_directory,
        },
        previewer = false,
    }
    builtin.find_files(opts)
end

function M.search_linked_tests()
    local file_name = vim.fn.expand "%:t:r"
    local test_file = "test_" .. file_name
    local opts = {
        prompt_title = "~ linked tests ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            test_file,
        },
        layout_config = {
            height = 0.8,
        },
    }

    builtin.find_files(opts)
end

function M.search_changed_files()
    local opts = {
        prompt_title = "~ changed files ~",
        previewer = false,
        find_command = {
            "git",
            "--no-pager",
            "diff",
            "--name-only",
            "--diff-filter=ACMRT",
            "HEAD",
        },
    }

    builtin.find_files(opts)
end

function M.files_to_quickfix()
    local opts = {
        prompt_title = "~ changed files ~",
        previewer = false,
        find_command = {
            "git",
            "diff",
            "--name-only",
            "--diff-filter=ACMRT",
            "HEAD",
        },
    }

    builtin.find_files(opts)
end

local function get_path(str, sep)
    sep = sep or "/"
    return str:match("(.*" .. sep .. ")")
end

-- this is a good example to see how custom mappings work
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#replacing-actions
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#performing-an-arbitrary-command-by-extending-existing-find_files-picker
local function create_file_mapping(prompt_bufnr, _)
    actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local path = get_path(selection[1])
        local fname = vim.fn.input(path)
        if fname then
            if string.find(fname, "/") then
                local new_path = get_path(fname)
                vim.cmd([[silent !mkdir -p ]] .. path .. new_path)
            end
            vim.cmd([[silent !touch ]] .. path .. fname)
            vim.cmd([[edit ]] .. path .. fname)
        end
    end)
    actions.select_vertical:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local path = get_path(selection[1])
        local fname = vim.fn.input(path)
        if fname then
            if string.find(fname, "/") then
                local new_path = get_path(fname)
                vim.cmd([[silent !mkdir -p ]] .. path .. new_path)
            end
            vim.cmd([[silent !touch ]] .. path .. fname)
            vim.cmd([[vnew ]] .. path .. fname)
        end
    end)
    return true
end

local function show_commit_mappings(prompt_bufnr, map)
    actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local commit_hash = selection.value
        vim.cmd("DiffviewOpen " .. commit_hash .. "~1.." .. commit_hash)
    end)
    return true
end

-- creates a new file alongside a file chosen from find_files
M.create_new_file_at_location = function()
    local opts = theme {
        prompt_title = "~ create file ~",
        results_title = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
        },
        previewer = false,
        layout_config = {
            height = 0.6,
        },
        -- cache_picker = cache_picker_config(),
        attach_mappings = create_file_mapping,
    }
    builtin.find_files(opts)
end

-- diff view open commit
M.show_commit = function()
    local opts = {
        prompt_title = "~ show commit ~",
        previewer = false,
        attach_mappings = show_commit_mappings,
    }
    builtin.git_commits(opts)
end

-- diff view open commit
M.search_document_symbols = function(symbol_type)
    local prompt_title
    local symbols_to_search

    if symbol_type == "function" then
        prompt_title = symbol_type
        symbols_to_search = { symbol_type }
    else
        prompt_title = "symbols"
        symbols_to_search = { "function", "method", "class", "struct" }
    end

    local opts = theme {
        prompt_title = "~ " .. prompt_title .. " ~",
        results_title = false,
        symbol_width = 50,
        symbol_type_width = 12,
        symbols = symbols_to_search,
        preview_title = false,
        layout_config = {
            height = 0.6,
        },
        -- cache_picker = cache_picker_config(),
    }
    builtin.lsp_document_symbols(opts)
end

function M.search_related_files()
    local current_file = vim.fn.expand "%:t:r"
    local file_type = vim.bo.filetype
    local entity_name
    if file_type == "python" then
        M.find_test_files("test_" .. current_file .. ".*.py$")
    elseif file_type == "scala" then
        local file_kinds = {
            "ManagementControllerSpec",
            "ManagementController",
            "ControllerSpec",
            "Controller",
            "ServiceSpec",
            "Service",
            "RepositorySpec",
            "Repository",
            "TestData",
            "ApiModule",
            "Module",
            "ApiSpec",
            "Endpoints",
            "Spec",
            "",
        }
        local file_kinds_regex = "(" .. table.concat(file_kinds, "|") .. ")"
        local kind_matched = false
        for i = 1, #file_kinds do
            if string.find(current_file, file_kinds[i]) then
                entity_name = string.gsub(current_file, file_kinds[i], "")
                M.find_test_files(
                    "/" .. entity_name .. ".*" .. file_kinds_regex .. ".scala",
                    "~ files related to "
                        .. entity_name
                        .. ":"
                        .. file_kinds[i]
                        .. " ~"
                )
                kind_matched = true
                break
            end
        end
        if not kind_matched then
            M.find_test_files(
                "/" .. current_file .. ".*.scala",
                "~ files related to " .. current_file .. ":" .. "Any " .. " ~"
            )
        end
    else
        print "No related files found"
    end
end

function M.open_dir_in_explorer()
    local opts = theme {
        prompt_title = "~ open dir ~",
        results_title = false,
        layout_config = {
            height = 0.6,
        },
    }

    local config = vim.fn.systemlist "fd . -t d --max-depth=5"

    pickers
        .new(opts, {
            finder = finders.new_table {
                results = config,
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
                    vim.api.nvim_command("NnnPicker " .. selection.value)
                end)
                return true
            end,
        })
        :find()
end

function M.diagnostics()
    local opts = theme {
        prompt_title = "~ diagnostics ~",
        results_title = false,
        preview_title = false,
        previewer = true,
        layout_config = {
            height = 0.6,
        },
    }

    builtin.diagnostics(opts)
end

--- grep projects
NOREMAP_SILENT("n", "g<c-g>", M.grep_projects)

--- search projects
NOREMAP_SILENT("n", "<leader>sp", M.search_projects)

--- LCD to dir
NOREMAP_SILENT("n", "<leader>pp", M.lcd_to_dir)

--- Open dir in explorer
NOREMAP_SILENT("n", "<leader>dw", M.open_dir_in_explorer)

return M
