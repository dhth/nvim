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
        previewer = false,
    }

    require("telescope.builtin").live_grep(opts)
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
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
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

    require("telescope.builtin").file_browser(opts)
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


function M.find_test_files(search_str)
    local file_pattern
    if search_str then
        file_pattern = search_str
    else
        file_pattern = ".*/tests/.*test_.*.py$"
    end
    local opts = {
        prompt_title = "~ tests ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
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
            "diff",
            "--name-only",
            "--diff-filter=ACMRT",
            "HEAD",
        },
    }

    require("telescope.builtin").find_files(opts)
end

return M
