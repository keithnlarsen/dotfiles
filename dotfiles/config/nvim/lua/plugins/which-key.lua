-- which-key: press <leader> (Space) and a popup shows every shortcut. Your
-- in-editor twin of the tmux `prefix ?` cheatsheet — key for relearning.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({ preset = "modern" })
    wk.add({
      { "<leader>b", group = "buffer" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>c", group = "code" },
      { "<leader>x", group = "diagnostics" },
      { "<leader>h", group = "hunk (git)" },
    })
  end,
}
