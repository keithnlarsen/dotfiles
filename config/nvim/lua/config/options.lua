-- Sensible editor defaults. Read top-to-bottom; tweak freely.
local opt = vim.opt

opt.number = true            -- line numbers
opt.relativenumber = true    -- relative numbers (great for j/k motions)
opt.mouse = "a"              -- mouse works in all modes
opt.clipboard = "unnamedplus" -- yank/paste uses the macOS system clipboard
opt.termguicolors = true     -- 24-bit color (Dracula needs this)
opt.background = "dark"

opt.expandtab = true         -- spaces, not tabs
opt.shiftwidth = 2           -- 2-space indent (matches this project)
opt.tabstop = 2
opt.smartindent = true
opt.breakindent = true
opt.wrap = false

opt.ignorecase = true        -- case-insensitive search...
opt.smartcase = true         -- ...unless you type a capital
opt.inccommand = "split"     -- live preview of :substitute

opt.signcolumn = "yes"       -- always show the gutter (git/diagnostics)
opt.cursorline = true        -- highlight the current line
opt.scrolloff = 8            -- keep 8 lines of context around the cursor
opt.splitright = true        -- new vsplits go right
opt.splitbelow = true        -- new splits go below

opt.undofile = true          -- persistent undo across sessions
opt.updatetime = 250         -- faster diagnostics/git refresh
opt.timeoutlen = 400         -- how long which-key waits before popping up
opt.confirm = true           -- ask to save instead of failing :q

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- show hidden whitespace
