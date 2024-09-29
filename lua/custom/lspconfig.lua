local M = {}

function M.show_file_definition_path()
    local position_params = vim.lsp.util.make_position_params()

    vim.lsp.buf_request(
        0,
        "textDocument/definition",
        position_params,
        function(err, result, _, _)
            if err ~= nil then
                print("err from LSP: " .. err)
                do
                    return
                end
            end
            if result == nil then
                print "⛔️"
                do
                    return
                end
            end
            local responseUri = result[1].uri

            local stripped_file_path = string.gsub(responseUri, "file://", "")
            if stripped_file_path == vim.fn.expand "%:p" then
                print "👉 same file"
                vim.lsp.buf.definition()
            else
                -- all of the weird substitutions below are because I couldn't figure out how to
                -- substitute strings with "/" and "-" in them
                local stripped_file_path_transformed =
                    string.gsub(stripped_file_path, "/", ">")
                stripped_file_path_transformed =
                    string.gsub(stripped_file_path_transformed, "-", "<")
                local cwd = string.gsub(vim.fn.getcwd(), "/", ">")
                cwd = string.gsub(cwd, "-", "<")
                local relative_file_path =
                    string.gsub(stripped_file_path_transformed, cwd, "")
                local relative_file_path_cleaned =
                    string.gsub(relative_file_path, ">", "/")
                relative_file_path_cleaned =
                    string.gsub(relative_file_path_cleaned, "<", "-")
                relative_file_path_cleaned = "."
                    .. string.gsub(relative_file_path_cleaned, "<", "-")

                print("👉 " .. relative_file_path_cleaned)
            end
        end
    )
end

return M
