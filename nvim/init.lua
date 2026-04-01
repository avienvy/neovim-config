vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.scrolloff = 9
vim.opt.mouse = ""
vim.opt.guicursor = ""
vim.opt.listchars = { space = "", eol = "", tab = ">-", trail = "-", extends = "~", precedes = "~", conceal = "+", nbsp = "&" }
-- Jump out of brackets with Tab in Insert Mode
vim.keymap.set('i', '<Tab>', function()
  local col = vim.fn.col('.')
  local line = vim.fn.getline('.')
  local char = line:sub(col, col)
  if char == '"' or char == "'" or char == ')' or char == ']' or char == '}' then
    return '<Right>'
  end
  return '<Tab>'
end, { expr = true })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
        
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {
    "nvim-mini/mini.statusline",
    version = false,
    config = function()
        require('mini.statusline').setup({})
    end,
    },
    {
    "stevearc/oil.nvim",
    opts = {}, 
    keys = {
       { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    lazy = false,
    },
    {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'soft'
      vim.g.gruvbox_material_foreground = 'material' -- alternative: 'mix' or 'original'
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_italic = 1
    vim.cmd([[colorscheme gruvbox-material]])
    end,
    },
    {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
    },
    {
    "vyfor/cord.nvim",
    opts = {
    text = {
        workspace = '',
        editing = function(opts)
          return string.format("Editing %s [Line: %s]", opts.filename, opts.cursor_line, opts.cursor_column)
        end,
      },
      timer = {
        interval = 1500,
        },
      },
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
