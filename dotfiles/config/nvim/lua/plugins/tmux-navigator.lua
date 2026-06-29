-- Seamless split/pane navigation between Neovim and tmux.
--
-- One keystroke moves to the next Neovim split, or — when nvim has no split
-- left in that direction — crosses into the adjacent tmux pane (the plugin
-- shells out to `tmux select-pane`). tmux's `prefix h/j/k/l` and `prefix`
-- arrows forward the keystroke here when the focused pane is running nvim
-- (see config/tmux/tmux.conf, the `is_vim` detector). Inside nvim, plain
-- Ctrl-h/j/k/l drive the same motion directly.
return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
  },
  -- We define the mappings ourselves (below); don't let the plugin add its own.
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>",  desc = "Go to left split / tmux pane" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>",  desc = "Go to lower split / tmux pane" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>",    desc = "Go to upper split / tmux pane" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to right split / tmux pane" },
  },
}
