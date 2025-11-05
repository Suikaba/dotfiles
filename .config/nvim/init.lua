require('base')
require('config.lazy')
require('config.lsp')

plugins = require('plugins')

require("lazy").setup(plugins)

-- Settings for latex using ott
vim.api.nvim_create_augroup('latex', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = {"*.otex"},
    command = 'setfiletype tex'
})

vim.cmd[[set completeopt+=menuone,noselect,popup]]

-- Key bindings
local keyset = vim.keymap.set

-- fern.vim
keyset('n', '<Leader>e', '<Cmd>Fern . -drawer<CR>')
keyset('n', '<Leader>E', '<Cmd>Fern . -drawer -reveal=%<CR>')

-- telescope.nvim
local builtin = require('telescope.builtin')
keyset('n', '<Leader>ff', ':Telescope find_files find_command=rg,--hidden,--ignore,--files<CR>', {})
--keyset('n', '<Leader>ff', builtin.find_files, {})
keyset('n', '<Leader>fg', builtin.live_grep, {})
keyset('n', '<Leader>fb', builtin.buffers, {})
keyset('n', '<Leader>fh', builtin.help_tags, {})

