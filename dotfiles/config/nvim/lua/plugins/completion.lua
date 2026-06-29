-- blink.cmp — the completion engine (intellisense popups, snippets, signatures).
-- One lean plugin (downloads a prebuilt fuzzy-matcher binary; no Rust toolchain).
return {
  "saghen/blink.cmp",
  version = "*", -- pin to latest release tag (ships the prebuilt binary)
  event = "InsertEnter",
  opts = {
    -- super-tab: <Tab> accepts/expands, <C-Space> opens the menu, <C-e> hides.
    keymap = { preset = "super-tab" },
    appearance = { nerd_font_variant = "mono" }, -- matches JetBrainsMono Nerd Font Mono
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    completion = {
      menu = { border = "rounded" },
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = { enabled = true }, -- inline preview of the top suggestion
    },
    signature = { enabled = true, window = { border = "rounded" } },
  },
}
