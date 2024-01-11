local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local theme = require('telescope.themes').get_ivy
local action_state = require "telescope.actions.state"
local finders = require "telescope.finders"
local builtin = require "telescope.builtin"

local M = {}

function M.edit_neovim()
    local opts = theme({
        prompt_title = "~ nvim ~",
        results_title = false,
        cwd = "~/.config/nvim",
        previewer = false,
        layout_config = {
            height = .6,
        }
    })

    require("telescope.builtin").find_files(opts)
end

function M.grep_nvim()
    local opts = {
        prompt_title = "~ nvim grep ~",
        results_title = false,
        preview_title = false,
        cwd = "~/.config/nvim",
        previewer = true,
    }

    require("telescope").extensions.live_grep_args.live_grep_args(opts)
end

function M.grep_projects()
    local opts = theme({
        prompt_title = "~ projects ~",
        results_title = false,
    })

    local config = vim.fn.systemlist("fd . --max-depth=1 \"$HOME/.config\" $PROJECTS_DIR $WORK_DIR")

    pickers.new(opts, {
        prompt_title = "~ grep projects ~",
        finder = finders.new_table {
            results = config,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = string.gsub(entry, vim.fn.expand("$HOME/"), ""),
                    ordinal = entry,
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                local args = theme({
                    prompt_title = "grep ~ " .. selection.display .. " ~",
                    results_title = false,
                    preview_title = false,
                    cwd = selection.value,
                    previewer = true,
                })
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
                require("telescope").extensions.live_grep_args.live_grep_args(args)
            end)
            return true
        end,

    }):find()
end

function M.search_projects()
    local opts = theme({
        prompt_title = "~ search projects ~",
        results_title = false,
        previewer = false,
        layout_config = {
            height = .6,
        }
    })

    local config = vim.fn.systemlist("fd . --max-depth=1 \"$HOME/.config\" $PROJECTS_DIR $WORK_DIR")

    pickers.new(opts, {
        prompt_title = "~ search projects ~",
        finder = finders.new_table {
            results = config,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = string.gsub(entry, vim.fn.expand("$HOME/"), ""),
                    ordinal = entry,
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                local opts_for_find_files = theme({
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
                        height = .6,
                    }
                })
                return builtin.find_files(opts_for_find_files)
            end)
            return true
        end,

    }):find()
end

function M.lcd_to_dir()
    local opts = {
        layout_config = {
            height = .8,
            width = .8,
        }
    }

    local config = vim.fn.systemlist("fd . -t d --max-depth=1 \"$HOME/.config\" $PROJECTS_DIR $WORK_DIR")

    pickers.new(opts, {
        prompt_title = "~ change project ~",
        finder = finders.new_table {
            results = config,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = string.gsub(entry, vim.fn.expand("$HOME/"), ""),
                    ordinal = entry,
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.api.nvim_command('tabnew')
                vim.api.nvim_command('lcd ' .. selection.value)
                print("👉 tab's working directory set to: " .. selection.value)
            end)
            return true
        end,

    }):find()
end

function M.edit_dotfiles()
    local opts = {
        prompt_title = "~ dotfiles ~",
        cwd = "$DOT_FILES_DIR",
        previewer = false,
    }

    require("telescope.builtin").find_files(opts)
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

    require("telescope.builtin").find_files(opts)
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

    require("telescope.builtin").find_files(opts)
end

function M.search_nearby_files()
    local current_dir = vim.fn.expand('%:p:h')
    local opts = {
        prompt_title = "~ files nearby 🚎 ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            "--search-path=" .. current_dir,
            "--max-depth=2"
        },
    }

    require("telescope.builtin").find_files(opts)
end

function M.nearby_file_browser()
    local opts = {
        prompt_title = "~ files nearby 🚎 ~",
        previewer = false,
        cwd = require("telescope.utils").buffer_dir(),
        hidden = true,
        layout_config = {
            height = 0.8,
        },
    }

    require "telescope".extensions.file_browser.file_browser(opts)
end

function M.find_dockerfiles()
    local opts = {
        prompt_title = "~ dockerfiles ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            ".*Dockerfile.*"
        }
    }

    require("telescope.builtin").find_files(opts)
end

function M.find_docker_compose_files()
    local opts = {
        prompt_title = "~ docker compose ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            ".*docker.*.yml"
        },
    }

    require("telescope.builtin").find_files(opts)
end

function M.find_local_only_files()
    local opts = {
        prompt_title = "~ local only ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            "local_only.*"
        }
    }

    require("telescope.builtin").find_files(opts)
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
            file_pattern
        }
    }

    require("telescope.builtin").find_files(opts)
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
    require("telescope.builtin").find_files(opts)
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
    require("telescope.builtin").find_files(opts)
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
    require("telescope.builtin").find_files(opts)
end

function M.search_linked_tests()
    local file_name = vim.fn.expand('%:t:r')
    local test_file = 'test_' .. file_name
    local opts = {
        prompt_title = "~ linked tests ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            test_file
        },
        layout_config = {
            height = 0.8,
        },
    }

    require("telescope.builtin").find_files(opts)
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

    require("telescope.builtin").find_files(opts)
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

    require("telescope.builtin").find_files(opts)
end

local function get_path(str, sep)
    sep = sep or '/'
    return str:match("(.*" .. sep .. ")")
end


-- this is a good example to see how custom mappings work
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#replacing-actions
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#performing-an-arbitrary-command-by-extending-existing-find_files-picker
local function create_file_mapping(prompt_bufnr, map)
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
            vim.cmd([[tabedit ]] .. path .. fname)
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
    local opts = {
        prompt_title = "~ create file ~",
        previewer = false,
        attach_mappings = create_file_mapping
    }
    require('telescope.builtin').find_files(opts)
end

-- diff view open commit
M.show_commit = function()
    local opts = {
        prompt_title = "~ show commit ~",
        previewer = false,
        attach_mappings = show_commit_mappings
    }
    require('telescope.builtin').git_commits(opts)
end


function M.search_related_files()
    local current_file = vim.fn.expand('%:t:r')
    local file_type = vim.bo.filetype
    local entity_name
    if file_type == "python" then
        require("dhth.telescope").find_test_files('test_' .. current_file .. '.*.py$')
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
                require("dhth.telescope").find_test_files('/' .. entity_name .. '.*' .. file_kinds_regex .. '.scala',
                    "~ files related to " .. entity_name .. ":" .. file_kinds[i] .. " ~")
                kind_matched = true
                break
            end
        end
        if not kind_matched then
            require("dhth.telescope").find_test_files('/' .. current_file .. '.*.scala',
                "~ files related to " .. current_file .. ":" .. "Any " .. " ~")
        end
    else
        print("No related files found")
    end
end

return M
