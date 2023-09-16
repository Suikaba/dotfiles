require('base')

-- Install package manager `lazy.nvim`
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

plugins = require('plugins')

require("lazy").setup(plugins)

-- Settings for latex using ott
vim.api.nvim_create_augroup('latex', {clear = true})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = {"*.otex"},
    command = 'setfiletype tex'
})


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

-- coc.nvim

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format.
-- When using nvim-autopairs, the plugin has the <CR> mapping.
-- We have to choose either `map_cr = false` in nvim-autopairs or installing coc-pairs and the below key mapping.
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Go to code navigation
keyset('n', "gd", "<Plug>(coc-definition)", {silent = true})
keyset('n', "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset('n', "gi", "<Plug>(coc-implementation)", {silent = true})
keyset('n', "gr", "<Plug>(coc-references)", {silent = true})

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

