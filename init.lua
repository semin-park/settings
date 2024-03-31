-- If any vim.opt.xxx option is confusing, run :help xxx
-- Don't show the mode in the last line (we have airline anyway)
vim.opt.showmode = false
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.title = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
-- Show tabs, trailing Leaders etc
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·" }
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.cindent = true
vim.opt.shiftwidth = 4
-- For OSCYank to work
vim.opt.clipboard = "unnamedplus"
--- Stop reindenting labels. This will stop "std:" from being indented to the
--- beginning of the file.
vim.opt.cinoptions = "L0"
vim.opt.colorcolumn = "80,120"
-- TODO: Check has('termguicolors')
vim.opt.termguicolors = true
vim.opt.foldenable = false

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Package manager
    --- Vim enhancements
    use {
        'smoka7/hop.nvim', -- Fast navigation (e.g., :HopWord)
        tag = 'v2.5.1',
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }
    use 'tomtom/tcomment_vim' -- Allows 'gcc' character sequence to turn a line or visual block into comments.
    use { 'junegunn/fzf', run = ':call fzf#install()' } -- Fuzzy finder (e.g., :FZF)
    use 'junegunn/fzf.vim'
    use 'ojroques/vim-oscyank' -- Allows yanking text to the system clipboard (works over ssh + tmux)
    --- Git integration
    -- Tried vim-signify and gitgutter, but:
    -- * vim-signify is snappy but stops working after a few hours of working with git (maybe rebase or branch change
    --   messes something up?
    -- * vim-gitgutter always works, but it's not very reactive. Feels like it's polling git diff every 10 seconds or
    --   something like that.
    -- * gitsigns is super snappy and always works, so this is what I'm using now.
    use 'lewis6991/gitsigns.nvim' -- add/delete indication for git tracked files
    use 'tpope/vim-fugitive' -- Git wrapper (e.g., :G blame)
    --- Visual enhancements
    use 'vim-airline/vim-airline' -- Nice status line
    use {
        'goolord/alpha-nvim', -- Dashboard at vim startup
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
    }
    --- Language generic (code hightlighting, [todo]...)
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    --- Language specific
    use 'rhysd/vim-clang-format'
    use 'derekwyatt/vim-fswitch' -- Switch between header and source file (e.g., :FSSplitRight on C/C++ files)
    use {
        'dart-lang/dart-vim-plugin',
        config = function()
            vim.g.dart_style_guide = 2
        end
    }
    --- Colorscheme
    use 'rktjmp/lush.nvim' -- Show color in realtime (Required by gruvbox.)
    use { 'ellisonleao/gruvbox.nvim',
        requires = { 'rktjmp/lush.nvim' },
    }
    use 'drewtempelmeyer/palenight.vim'
    use 'joshdick/onedark.vim'
    --- LSP (turn off code completion)
    use 'neovim/nvim-lspconfig'
    use {
        'williamboman/mason.nvim',
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
    use 'williamboman/mason-lspconfig.nvim'
    use 'mrcjkb/rustaceanvim'
    use {
        'SmiteshP/nvim-navbuddy',
        requires = {
            'neovim/nvim-lspconfig',
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim',
            'numToStr/Comment.nvim',        -- Optional
            'nvim-telescope/telescope.nvim' -- Optional
        }
    }
    --- For / and : completion (can also code complete, but the quality isn't as good as coq)
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp' -- LSP completion

    --- Code completion. If this doesn't work, try running :COQdeps.
    use {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        config = function()
            vim.g.coq_settings = {
                auto_start = 'shut-up',
                clients = {
                    tree_sitter = { enabled = true },
                    paths = { enabled = true, resolution = { 'file' } },
                    snippets = { enabled = false, warn = {} },
                    tags = { enabled = true },
                },
                keymap = { recommended = true, jump_to_mark = '<c-m>' },
                display = {
                    preview = { positions = { north = 4, south = nil, west = 2, east = 3 } },
                },
            }
        end,
    }
end)

--- Vim wide settings
--- Basic settings
vim.g.colors_name = 'onedark'
vim.opt.syntax = 'on'
vim.opt.background = 'dark'

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
--- helix like mapping
keymap('n', 'gl', '$', opts)
keymap('n', 'gs', '^', opts)
keymap('n', 'gh', '0', opts)
keymap('n', 'miw', 'ebve', opts)
keymap('v', 'gl', '$', opts)
keymap('v', 'gs', '^', opts)
keymap('v', 'gh', '0', opts)
--- Fswitch mapping
keymap('n', '<Leader>oo', ':FSHere<cr>', opts)
keymap('n', '<Leader>ol', ':FSSplitRight<cr>', opts)
keymap('n', '<Leader>oh', ':FSSplitLeft<cr>', opts)
--- Tab navigation
keymap('n', '<C-h>', 'gT', opts)
keymap('n', '<C-l>', 'gt', opts)
--- Leader mapping to space bar
keymap('n', '<Space>', '<Leader>', {})
keymap('v', '<Space>', '<Leader>', {})
--- Come to this file
keymap('n', '<Leader>ei', ':e ~/.config/nvim/init.lua<CR>', opts)
--- Configure vim-oscyank
keymap('v', '<Leader>y', ':OSCYank<CR>', opts)
vim.g.oscyank_term = 'default'
--- Buffer management
keymap('n', '<Leader>F', ':Files<CR>', opts)
keymap('n', '<Leader>b', ':Buffers<CR>', opts)
--- Turn off highlight
keymap('n', '<C-c><C-c>', ':nohls<CR>', opts)
keymap('n', 'i', ':nohls<CR>i', opts)
--- Hop config
keymap('n', 'gw', ':HopWord<CR>', opts)
keymap('n', 'g/', ':HopPattern<CR>', opts)
--- Navbuddy
keymap('n', '<C-n>', ':Navbuddy<CR>', opts)
--- Let Visual Block mode to persist after >, <
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)
keymap('v', '//', 'y/<C-R>"<CR>', opts)

--- gitsigns setup
require('gitsigns').setup()

-- vim should be aliased to `local=1 nvim`
if (os.getenv("local") ~= nil)
then
    -- Treesitter tuning
    require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "c", "cpp", "python", "lua", "go", "rust" },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
        -- List of parsers to ignore installing (for "all")
        ignore_install = { "javascript" },
        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
        highlight = {
            -- `false` will disable the whole extension
            enable = true,
            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            disable = function(_, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
    }
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
end

--- LSP config
require("mason").setup()
require("mason-lspconfig").setup()

require("nvim-navbuddy").setup {
    lsp = {
        auto_attach = true,   -- If set to true, you don't need to manually use attach function in lspconfig.xxx.setup
    },
}
local lspconfig = require('lspconfig')
lspconfig.clangd.setup {}
lspconfig.lua_ls.setup {}
-- Nothing to do for Rust, since 'rustaceanvim' is doing lspconfig setup behind the scenes

--- LSP Mappings.
vim.keymap.set('n', '<C-F>', function() vim.lsp.buf.format { async = true } end, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)

-- Stop vim entering comments automatically upon enter
vim.cmd [[autocmd FileType * setlocal formatoptions-=cro]]

-- nvim-cmp config (use it for / and : completion; Code completion quality is not the best)
local cmp = require 'cmp'
-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

