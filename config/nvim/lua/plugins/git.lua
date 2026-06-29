-- Git surfaces: gutter signs (gitsigns), the AI-review diff viewer (diffview),
-- and the full git TUI (lazygit).
return {
  -- Inline change signs + hunk actions in the gutter.
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
        end
        map("]c", function() gs.nav_hunk("next") end, "Next git hunk")
        map("[c", function() gs.nav_hunk("prev") end, "Prev git hunk")
        map("<leader>hp", gs.preview_hunk, "Preview hunk")
        map("<leader>hs", gs.stage_hunk, "Stage hunk")
        map("<leader>hr", gs.reset_hunk, "Reset hunk")
        map("<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
      end,
    },
  },

  -- Diffview: walk everything that changed in the working tree (what the AI did).
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff: working tree (AI changes)" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diff: this file's history" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diff: close" },
    },
    opts = { enhanced_diff_hl = true },
  },

  -- lazygit: full git TUI in a floating window.
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit", "LazyGitCurrentFile" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit (full git TUI)" },
    },
  },
}
