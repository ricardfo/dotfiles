return {
  {"nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {"<leader>e",":NvimTreeToggle<CR>", mode = "n"},
      {"<leader>n",":NvimTreeFindFileToggleCR>", mode = "n"},
    },
    version = "*",
    init = function()
      -- disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      --
    end,
    config = function()
      require("nvim-tree").setup {
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
          custom = { "^.git$" },
        },
        git = {
          ignore = false,
        },
      }
    end,
  }
}
