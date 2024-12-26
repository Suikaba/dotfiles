return {
    {
        'rebelot/kanagawa.nvim',
        config = function()
            require('kanagawa').setup {
                theme = "wave"
            }
            vim.cmd('colorscheme kanagawa')
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        event ={'BufNewFile', 'BufRead'},
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    "cpp",
                    "rust",
                    "python",
                    "lua",
                    "latex",
                    "vim",
                },
                highlight = {
                    enable = true,
                },
            }
        end
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        dependencies = { 'nvim-lua/plenary.nvim' },
        defaults = {
            file_ignore_patterns = {
                "^.git/",
            },
            vim_grep_arguments = { -- For `grep_string` and `live_grep`
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "-uu", -- show .gitignore and hidden files
            },
        },
        pickers = {
            -- The `find_files` settings don't work...why?
            find_files = {
                find_command = {
                    "rg",
                    "--files",
                    "--hidden",
                    "--glob"
                },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                                                -- the default case_mode is "smart_case"
            }
        },
        config = function()
            require('telescope').load_extension('fzf')
        end
    },
    {
       'lambdalisue/fern.vim',
       config = function()
           vim.g['fern#hide_cursor'] = true
           vim.g['fern#default_hidden'] = true
       end
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup {
                options = {
                    globalstatus = true,
                },
            }
        end
    },
    {
        -- Require nodejs and npm
        'neoclide/coc.nvim',
        branch = "release",
        config = function()
            vim.g.coc_global_extensions = {
                --"coc-clangd",
                --"coc-rust-analyzer",
                --"coc-python",
                --"coc-snippets",
                "coc-vimtex",
                "coc-json",
                "coc-sh",
                "coc-pairs",
            }
        end
    },
    {
        'lervag/vimtex',
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        -- config = function()
        --     require("nvim-surround").setup {}
        -- end
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false, -- This plugin is already lazy
    }
    -- Use coc-pairs if using coc.nvim.
    -- {
    --     'windwp/nvim-autopairs',
    --     event = "InsertEnter",
    --     opts = {}
    -- },
}
