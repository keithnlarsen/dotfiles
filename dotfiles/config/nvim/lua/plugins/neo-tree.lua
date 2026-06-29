-- File tree on the left.  Toggle with <leader>e.
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer (file tree)" },
    { "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus file tree" },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    filesystem = {
      follow_current_file = { enabled = true }, -- highlight the open file in the tree
      use_libuv_file_watcher = true,            -- live-update on disk changes
      filtered_items = {
        visible = true,          -- show ALL files (hidden + gitignored), dimmed
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    window = { width = 48 },
    default_component_configs = {
      indent = { with_expanders = true },
    },
  },
}
