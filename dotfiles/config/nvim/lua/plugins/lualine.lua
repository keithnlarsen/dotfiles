-- Statusline (Dracula-themed).
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "dracula",
      globalstatus = true, -- one statusline for all splits
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
    },
    sections = {
      lualine_c = { { "filename", path = 1 } }, -- show relative path
    },
  },
}
