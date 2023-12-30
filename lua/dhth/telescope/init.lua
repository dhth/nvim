local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local action_state = require "telescope.actions.state"
local finders = require "telescope.finders"

local M = {}

function M.edit_neovim()
    local opts = {
        prompt_title = "~ nvim ~",
        cwd = "~/.config/nvim",
        previewer = false,
    }

    require("telescope.builtin").find_files(opts)
end

function M.grep_nvim()
    local opts = {
        prompt_title = "~ nvim grep ~",
        cwd = "~/.config/nvim",
        previewer = true,
    }

    require("telescope").extensions.live_grep_args.live_grep_args(opts)
end

function M.grep_project(project_location)
    if (not project_location) then
        print("project location is not valid")
        return
    end

    local project_location_split = SPLIT(project_location, "/")
    if (#project_location_split == 0) then
        print("project location is not valid")
        return
    end

    if not DOES_DIRECTORY_EXIST(project_location) then
        print("directory does not exist: " .. project_location)
        return
    end

    local project_name
    if (project_location_split[#project_location_split] == "/") then
        project_name = project_location_split[#project_location_split - 1]
    else
        project_name = project_location_split[#project_location_split]
    end

    local opts = {
        prompt_title = "grep ~ " .. project_name .. " ~",
        cwd = project_location,
        previewer = true,
    }

    require("telescope").extensions.live_grep_args.live_grep_args(opts)
end

function M.grep_projects()
    local opts = {
        layout_config = {
            height = .8,
            width = .8,
        }
    }


    local config = vim.fn.systemlist("fd . --max-depth=1 \"$HOME/.config\" $PROJECTS_DIR $WORK_PROJECTS_DIR")

    pickers.new(opts, {
        prompt_title = "~ grep projects ~",
        finder = finders.new_table {
            results = config,
            try_maker = function(entry)
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
                return M.grep_project(selection.value)
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
