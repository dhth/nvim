local M = {}

function M.edit_neovim()
    opts = {
        prompt_title = "~ nvim ~",
        cwd = "~/.config/nvim",
        previewer = false,
    }

    require("telescope.builtin").find_files(opts)
end


function M.edit_dotfiles()
    opts = {
        prompt_title = "~ dotfiles ~",
        cwd = "$DOT_FILES_DIR",
        previewer = false,
    }

    require("telescope.builtin").find_files(opts)
end


function M.find_files()
    opts = {
        prompt_title = "~ files ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
        }
    }

    require("telescope.builtin").find_files(opts)
end


function M.find_dockerfiles()
    opts = {
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
    opts = {
        prompt_title = "~ docker compose ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            ".*docker.*.yml"
        }
    }

    require("telescope.builtin").find_files(opts)
end


function M.find_local_only_files()
    opts = {
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


function M.find_test_files()
    opts = {
        prompt_title = "~ tests ~",
        previewer = false,
        find_command = {
            "fd",
            "-ipH",
            "-t=f",
            ".*/tests/.*test_.*.py$"
        }
    }

    require("telescope.builtin").find_files(opts)
end

return M
