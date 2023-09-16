vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Basically `set xxx` in vim corresponds to `vim.opt.xxx=<bvalue>`
-- `vim.bo` and `vim.wo` are for setting buffer-scoped and window-scoped options, resp.
vim.opt.number = true
vim.wo.number = true
vim.wo.relativenumber = false
vim.opt.mouse = 'a' -- Enable mouse
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true -- Enable highlight search results
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 2
vim.opt.laststatus = 3 -- Enable global status line

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true

vim.opt.scrolloff = 10
vim.opt.shell = 'zsh'
vim.opt.inccommand = 'split'
vim.opt.breakindent = true
vim.opt.wrap = true
vim.opt.helplang = 'en'
vim.opt.updatetime = 300
-- vim.opt.showtabline = 1 -- When use barbar.nvim
vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.wrap = true

-- Show invisible texts
vim.opt.listchars = { tab = '>-', trail = '*', nbsp = '+' }

-- Python3
vim.cmd([[
    let g:python3_host_prog = '/usr/bin/python3'
]])

-- Leader Key
vim.g.mapleader = ' '

-- Key bindings
local keymap = vim.keymap
-- Split views
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
-- Switch active window
keymap.set('n', 'sh', '<C-w>h')
keymap.set('n', 'sk', '<C-w>k')
keymap.set('n', 'sj', '<C-w>j')
keymap.set('n', 'sl', '<C-w>l')

-- Move with physical lines instead of logical lines
keymap.set('n','j','gj')
keymap.set('n','k','gk')

-- Escape by jj
keymap.set('i','jj','<Esc>')

-- Open the settings
keymap.set('n','<F1>',':edit $MYVIMRC<CR>')

