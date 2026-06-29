-- Core keymaps. Plugin-specific maps live in each plugin's file (lua/plugins/*).
local map = vim.keymap.set

-- Quick save / quit
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })

-- Clear search highlight with Esc
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Jump to the main code editor (first normal file window), e.g. from the tree
map("n", "<leader>l", function()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype ~= "neo-tree" and vim.bo[buf].buftype == "" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  vim.cmd("wincmd l") -- fallback: just move right
end, { desc = "Go to code editor" })

-- Ctrl-h/j/k/l move between splits AND cross into adjacent tmux panes at the
-- edge — handled by vim-tmux-navigator (lua/plugins/tmux-navigator.lua), which
-- the same tmux prefix h/j/k/l + arrows also drive (see config/tmux/tmux.conf).

-- Keep selection while indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move selected lines up/down
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Center screen after big jumps
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search match (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search match (centered)" })
