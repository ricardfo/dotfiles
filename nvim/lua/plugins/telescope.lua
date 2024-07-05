return {
  'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
      {"<leader>ff", ":Telescope find_files<cr>", mode = "n" },
      {"<leader>fg", ":Telescope live_grep<cr>", mode = "n" },
      {"<leader>fb", ":Telescope buffers<cr>", mode = "n" },
      {"<leader>fh", ":Telescope help_tags<cr>", mode = "n" },
  },
}
