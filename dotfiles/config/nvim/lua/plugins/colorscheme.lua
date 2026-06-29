-- Dracula (darker background to match Alacritty's #1d1e26).
return {
  "Mofiqul/dracula.nvim",
  lazy = false,
  priority = 1000, -- load before everything else so UI is themed from the start
  config = function()
    require("dracula").setup({
      colors = { bg = "#1d1e26" }, -- the "darker" variant
      transparent_bg = false,
      italic_comment = true,
    })
    vim.cmd.colorscheme("dracula")
  end,
}
