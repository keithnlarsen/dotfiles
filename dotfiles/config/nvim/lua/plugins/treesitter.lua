-- Accurate syntax highlighting + indentation via tree-sitter parsers.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master", -- stable classic API (the new `main` branch is a WIP rewrite)
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "lua", "vim", "vimdoc", "bash", "json", "jsonc", "yaml", "toml",
      "markdown", "markdown_inline", "tsx", "typescript", "javascript",
      "html", "css", "regex", "diff", "git_config",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
