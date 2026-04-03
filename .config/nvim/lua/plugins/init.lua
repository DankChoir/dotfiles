return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.nvimlint"
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = true,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup()
        end,
      },
    },
    config = function()
      dofile(vim.g.base46_cache .. "syntax")
      require "configs.treesitter"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
      },
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = require "configs.mason",
  },

  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup {
        lightbulb = {
          enable = false,
        },
      }
    end,
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.noice"
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  { import = "nvchad.blink.lazyspec" },
  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^6", -- Recommended
  --   lazy = false, -- This plugin is already lazy
  -- },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- lsp_keymaps = false,
      -- other options
    },
    config = function(lp, opts)
      require("go").setup(opts)
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,

    -- For `nvim-treesitter` users.
    priority = 49,

    dependencies = {
      "saghen/blink.cmp",
    },

    config = function()
      require("markview.extras.checkboxes").setup {
        --- Default checkbox state(used when adding checkboxes).
        ---@type string
        default = "X",

        --- Changes how checkboxes are removed.
        ---@type
        ---| "disable" Disables the checkbox.
        ---| "checkbox" Removes the checkbox.
        ---| "list_item" Removes the list item markers too.
        remove_style = "disable",

        --- Various checkbox states.
        ---
        --- States are in sets to quickly change between them
        --- when there are a lot of states.
        ---@type string[][]
        states = {
          { " ", "/", "X" },
          { "<", ">" },
          { "?", "!", "*" },
          { '"' },
          { "l", "b", "i" },
          { "S", "I" },
          { "p", "c" },
          { "f", "k", "w" },
          { "u", "d" },
        },
      }
    end,
  },
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require("blame").setup {}
    end,
  },
}
