-- Format-on-save via `deno fmt` (this repo's formatter — no prettier).
return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    { "<leader>cf", function() require("conform").format({ async = true }) end, desc = "Format file" },
  },
  opts = {
    formatters_by_ft = {
      typescript = { "deno_fmt" },
      typescriptreact = { "deno_fmt" },
      javascript = { "deno_fmt" },
      javascriptreact = { "deno_fmt" },
      json = { "deno_fmt" },
      jsonc = { "deno_fmt" },
      markdown = { "deno_fmt" },
      css = { "deno_fmt" },
    },
    -- Set format_on_save = false here if auto-format ever adds noise to a diff.
    format_on_save = { timeout_ms = 2500, lsp_format = "never" },
  },
}
