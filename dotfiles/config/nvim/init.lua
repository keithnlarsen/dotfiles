-- ~/.config/nvim/init.lua — entry point. Keep this tiny; everything lives in
-- lua/config (settings) and lua/plugins (one file per concern, all yours).

-- Leader keys MUST be set before plugins load.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.lazy") -- bootstraps the plugin manager + imports lua/plugins/*
