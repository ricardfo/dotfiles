return {
  {"voldikss/vim-floaterm",
    keys = {
      {"<leader>t",":FloatermToggle<CR>", mode = "n"},
      {"<leader>t", "<C-\\><C-n>:FloatermToggle<CR>", mode = "t"},
      {"<leader>n", "<C-\\><C-n>:FloatermNew<CR>", mode = "t"},
      {"<leader>h", "<C-\\><C-n>:FloatermPrev<CR>", mode = "t"},
      {"<leader>l", "<C-\\><C-n>:FloatermLast<CR>", mode = "t"},
    },
    config = function()
      vim.g.floaterm_gitcommit = 'floaterm'
      vim.g.floaterm_autoinsert = 1
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
      vim.g.floaterm_wintitle = 0
    end,
  }
}
