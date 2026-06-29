-- LSP: intellisense, go-to-definition, hover, rename, diagnostics.
-- Scoped dual-LSP for this hybrid repo:
--   • denols → src/server/** (pure Deno)
--   • ts_ls  → everything else (Vite/React UI + shared, via tsconfig)
-- Exactly one attaches per file, so you never get double diagnostics.
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Keymaps, set once per buffer that an LSP attaches to.
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local function map(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition, "Goto definition")
        map("gr", vim.lsp.buf.references, "References")
        map("gI", vim.lsp.buf.implementation, "Goto implementation")
        map("gy", vim.lsp.buf.type_definition, "Goto type definition")
        map("K", vim.lsp.buf.hover, "Hover docs")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
        map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
        map("<leader>xx", vim.diagnostic.setloclist, "Diagnostics → list")
      end,
    })

    -- Diagnostic appearance (Dracula-friendly, rounded floats).
    vim.diagnostic.config({
      virtual_text = { prefix = "●" },
      severity_sort = true,
      underline = true,
      update_in_insert = false,
      float = { border = "rounded", source = true },
    })

    -- Completion capabilities come from blink.cmp.
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    vim.lsp.config("*", { capabilities = capabilities })

    -- Install ts_ls binary via mason; denols uses your system `deno` (brew).
    require("mason-lspconfig").setup({
      ensure_installed = { "ts_ls" },
      automatic_enable = false, -- we enable manually below with path gating
    })

    local function is_server(fname) return fname:match("/src/server/") ~= nil end

    -- Deno: ONLY for src/server/**
    vim.lsp.config("denols", {
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        if is_server(fname) then
          on_dir(vim.fs.root(fname, { "deno.json", "deno.jsonc" }))
        end
      end,
      settings = { deno = { enable = true, lint = true, unstable = true } },
    })

    -- TypeScript/React: everything EXCEPT src/server/**
    vim.lsp.config("ts_ls", {
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        if not is_server(fname) then
          on_dir(vim.fs.root(fname, { "tsconfig.json", "package.json", ".git" }))
        end
      end,
    })

    vim.lsp.enable({ "denols", "ts_ls" })
  end,
}
