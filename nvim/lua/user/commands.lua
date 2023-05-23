local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("filetype_blade", { clear = true })
autocmd({"BufRead", "BufNewFile"}, {
    group = "filetype_blade",
    pattern = "*.blade.php",
    command = "setlocal filetype=html"
})

augroup("setIndent", { clear = true })
autocmd("FileType", {
  group = "setIndent",
  pattern = { "yaml", "css", "text", "markdown", "html", "javascript", "lua", "twig", "*.blade.php" },
  command = "setlocal sw=2 ts=2 sts=2"
})

autocmd({"BufWritePre"}, {
    pattern = {"*"},
    callback = function(ev)
        save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

