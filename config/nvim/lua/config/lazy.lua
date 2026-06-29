-- Bootstrap lazy.nvim — the plugin MANAGER (it only downloads/loads plugins;
-- it imposes no config of its own). This is NOT a distro.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } }, -- load every file in lua/plugins/
  install = { colorscheme = { "dracula" } },
  checker = { enabled = false },             -- don't auto-check for updates
  change_detection = { notify = false },
  ui = { border = "rounded" },
})

-- Open the plugin manager UI with <leader>L
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy (plugin manager)" })
