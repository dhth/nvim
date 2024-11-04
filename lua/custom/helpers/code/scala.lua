local M = {}

function M.writeBoilerplateWithMain()
    local file_path = vim.fn.expand "%:r" -- src/main/scala/package/name/FileName.scala
    if not string.find(file_path, "src/main/scala/") then
        print "Error: File path does not contain 'src/main/scala/'"
        return
    end

    local mainFile = -- package.name.FileName
        (string.gsub(file_path, ".*src/main/scala/", ""))

    local parts = {}
    for part in string.gmatch(mainFile, "([^/]+)") do
        table.insert(parts, part)
    end

    local packageName = table.remove(parts) -- package.name
    local fileName = table.concat(parts, ".") -- FileName

    local lines = {
        "package " .. fileName,
        "",
        "object " .. packageName .. " {",
        "  def main(args: Array[String]): Unit = {",
        "  }",
        "}",
    }

    vim.api.nvim_buf_set_lines(
        vim.api.nvim_get_current_buf(),
        0,
        -1,
        false,
        lines
    )
end

return M
