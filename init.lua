-- If any vim.opt.xxx option is confusing, run :help xxx
-- Don't show the mode in the last line (we have airline anyway)
vim.opt.foldenable = false
vim.opt.showmode = false
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.title = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
-- Show tabs, trailing Leaders etc
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·" }
vim.opt.smarttab = false
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.cindent = true
vim.opt.shiftwidth = 2
-- For OSCYank to work
vim.opt.clipboard = "unnamedplus"
--- Stop reindenting labels. This will stop "std:" from being indented to the
--- beginning of the file
vim.opt.cinoptions = "L0"
vim.opt.colorcolumn = "80,100"
-- TODO: Check has('termguicolors')
vim.opt.termguicolors = true

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Package manager
    -- Vim enhancements
    use {
        'phaazon/hop.nvim', -- Fast navigation (e.g., :HopWord)
        branch = 'v2',
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }
    use 'tomtom/tcomment_vim' -- Allows 'gcc' character sequence to turn a line or visual block into comments.
    use { 'junegunn/fzf', run = ':call fzf#install()' } -- Fuzzy finder (e.g., :FZF)
    use 'junegunn/fzf.vim'
    use 'ojroques/vim-oscyank' -- Allows yanking text to the system clipboard (works over ssh + tmux)
    use 'azabiong/vim-highlighter' -- Pattern based highlight
    -- Git integration
    -- Tried vim-signify and gitgutter, but:
    -- * vim-signify: snappy but stops working after a few hours. But it works with mercurial, so installed for g3 usage.
    -- * vim-gitgutter: always works, but not very reactive. Feels like it's polling git diff every 10 seconds.
    -- * [gitsigns]: super snappy and always works (currently using)
    use 'lewis6991/gitsigns.nvim' -- add/delete indication for git tracked files
    use 'tpope/vim-fugitive' -- Git wrapper (e.g., :G blame)
    -- Visual enhancements
    use 'vim-airline/vim-airline' -- Nice status line
    use 'vim-airline/vim-airline-themes'
    use {
        'goolord/alpha-nvim', -- Dashboard at vim startup
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
    }
    use 'lukas-reineke/indent-blankline.nvim'  -- Show indentation
    -- Language generic (code hightlighting, [todo]...)
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- Language specific
    use 'rhysd/vim-clang-format'
    -- Colorscheme
    use 'joshdick/onedark.vim'
    -- LSP (turn off code completion)
    use 'neovim/nvim-lspconfig'
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
    use 'derekwyatt/vim-fswitch' -- Switch between header and source file (e.g., :FSSplitRight on C/C++ files)
    -- For / and : completion (can also code complete, but the quality isn't as good as coq)
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp' -- LSP completion

    -- Code completion. If this doesn't work, try running :COQdeps.
    -- use {
    --     'ms-jpq/coq_nvim',
    --     branch = 'coq',
    --     config = function()
    --         vim.g.coq_settings = {
    --             auto_start = 'shut-up',
    --             clients = {
    --                 tree_sitter = { enabled = true },
    --                 paths = { enabled = true, resolution = { 'file' } },
    --                 snippets = { enabled = false, warn = {} },
    --                 tags = { enabled = true },
    --             },
    --             keymap = { recommended = true, jump_to_mark = '<c-m>' },
    --             display = {
    --                 preview = { positions = { north = 4, south = nil, west = 2, east = 3 } },
    --             },
    --         }
    --     end,
    -- }

    -- Display ANSI color codes
    use 'powerman/vim-plugin-AnsiEsc'
end)

-- Vim wide settings
-- netrw settings (vim default file explorer)
vim.cmd([[
  let g:netrw_liststyle = 3
  let g:netrw_browse_split = 3
  let g:netrw_altv = 1
  let g:netrw_winsize = 25
  " netrw has a command gh that toggles dotfile hiding. This is its regex.
  let ghregex='\(^\|\s\s\)\zs\.\S\+'
  let g:netrw_list_hide=ghregex
]])

-- Tab settings
vim.cmd([[
  au TabLeave * let g:lasttab = tabpagenr()
  nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
  vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
]])

-- Basic settings
vim.cmd([[
  let g:onedark_termcolors = 256
  let g:onedark_terminal_italics = 1
  let g:onedark_color_overrides = {
  \ "background": {"gui": "#2A2E38", "cterm": "235", "cterm16": "0" },
  \ "purple": { "gui": "#c678DF", "cterm": "170", "cterm16": "5" },
  \}
  syntax on
  if (has("autocmd"))
    let s:colors = onedark#GetColors()
    augroup colorextend
      autocmd!
      " Make `Function`s bold in GUI mode
      autocmd ColorScheme * call onedark#extend_highlight("Special", { "fg": s:colors.yellow })
    augroup END
  endif
  colo onedark
]])

-- vim-airline settings
vim.cmd([[
  let g:airline_symbols = {'linenr': ' ↓', 'colnr': ' →', 'maxlinenr': ''}
  let g:airline_section_b = ''
  let g:airline_section_y = ''
  let g:airline_section_z = airline#section#create(['%p%%', 'linenr', 'maxlinenr', 'colnr'])
  let g:airline_section_error = ''
  let g:airline_section_warning = ''
  let g:airline_skip_empty_sections = 1
]])

-- vim-highlighter key mapping
vim.cmd([[
  let HiSet   = 'f<CR>'
  let HiErase = 'f<BS>'
  let HiClear = 'f<C-L>'
]])

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- vim-highlighter go next
keymap('n', 'gn', ':Hi}<CR>', opts)
keymap('n', 'gN', ':Hi{<CR>', opts)
keymap('n', 'g]', ':Hi><CR>', opts)
keymap('n', 'g[', ':Hi<<CR>', opts)
-- helix like mapping
keymap('n', 'gl', '$', opts)
keymap('n', 'gs', '^', opts)
keymap('n', 'gh', '0', opts)
keymap('n', 'miw', 'ebve', opts)
keymap('v', 'gl', '$', opts)
keymap('v', 'gs', '^', opts)
keymap('v', 'gh', '0', opts)
-- Tab navigation
keymap('n', '<C-H>', 'gT', opts)
keymap('n', '<C-L>', 'gt', opts)
keymap('n', '<Leader>1', '1gt', opts)
keymap('n', '<Leader>2', '2gt', opts)
keymap('n', '<Leader>3', '3gt', opts)
keymap('n', '<Leader>4', '4gt', opts)
keymap('n', '<Leader>5', '5gt', opts)
keymap('n', '<Leader>6', '6gt', opts)
keymap('n', '<Leader>7', '7gt', opts)
keymap('n', '<Leader>8', '8gt', opts)
keymap('n', '<Leader>9', '9gt', opts)
vim.cmd [[ au TabLeave * let g:lasttab = tabpagenr() ]]
keymap('n', '<C-0>', ':exe "tabn ".g:lasttab<CR>', opts)
keymap('v', '<C-0>', ':exe "tabn ".g:lasttab<CR>', opts)
-- Leader mapping to space bar
keymap('n', '<Space>', '<Leader>', {})
keymap('v', '<Space>', '<Leader>', {})
-- Come to this file
keymap('n', '<Leader>ei', ':e ~/.config/nvim/init.lua<CR>', opts)
-- Configure vim-oscyank
keymap('v', '<Leader>y', ':OSCYankVisual<CR>', opts)
vim.g.oscyank_term = 'default'
-- Copy file name
keymap('n', '<C-g>p', ':let @+=expand("%")<CR>', opts)
keymap('n', '<C-g>l', ':let @+=expand("%") . ";l=" . line(".")<CR>', opts)
-- Buffer management
keymap('n', '<Leader>F', ':Files<CR>', opts)
keymap('n', '<Leader>b', ':Buffers<CR>', opts)
keymap('n', '<Leader>fd', ':Files platforms/darwinn<CR>', opts) -- Google3 Darwinn Repo
-- Turn off highlight
keymap('n', '<C-c><C-c>', ':nohls<CR>', opts)
keymap('n', 'i', ':nohls<CR>i', opts)
-- Hop config
keymap('n', 'gw', ':HopWord<CR>', opts)
keymap('n', 'g/', ':HopPattern<CR>', opts)
-- Navbuddy
keymap('n', '<C-n>', ':Navbuddy<CR>', opts)
-- Let Visual Block mode to persist after >, <
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)
keymap('v', '//', 'y/<C-R>"<CR>', opts)
-- Fswitch mapping
keymap('n', '<Leader>oo', ':FSHere<cr>', opts)
keymap('n', '<Leader>ol', ':FSSplitRight<cr>', opts)
keymap('n', '<Leader>oh', ':FSSplitLeft<cr>', opts)
-- Tabnew
keymap('n', '<Leader>t', ':tabnew ', opts)

-- indent-blankline settings
require('ibl').setup()

-- gitsigns setup
require('gitsigns').setup{
    on_attach = function(bufnr)
        gitsigns = require('gitsigns')
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', '<Leader>n', function()
            if vim.wo.diff then
                vim.cmd.normal({'gn', bang = true})
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', '<Leader>N', function()
            if vim.wo.diff then
                vim.cmd.normal({'gp', bang = true})
            else
                gitsigns.nav_hunk('prev')
            end
        end)
    end
}

-- Treesitter tuning
require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "cpp", "python", "lua", "go", "rust" },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,
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

-- LSP config
require("nvim-navbuddy").setup {
    lsp = {
        auto_attach = true,   -- If set to true, you don't need to manually use attach function in lspconfig.xxx.setup
    },
}
vim.cmd [[
  augroup filetype_settings
      autocmd FileType mlir map <C-F> :%!mlir-beautify --no_back_up --mlir_path '%:p'<CR>
  augroup END
]]
-- nvim_lspconfig.tblgen_lsp_server.setup{}
-- Nothing to do for Rust, since 'rustaceanvim' is doing lspconfig setup behind the scenes
-- nvim_lspconfig.sumneko_lua.setup {}
-- nvim_lspconfig.gopls.setup {}
-- nvim_lspconfig.clangd.setup {}
-- nvim_lspconfig.mlir_lsp_server.setup{}

vim.diagnostic.config({
  virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
  signs = { severity = { min = vim.diagnostic.severity.WARN } },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
})

-- LSP Mappings.
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
vim.cmd [[autocmd FileType c setlocal autoindent noexpandtab softtabstop=8 shiftwidth=8]]
vim.cmd [[autocmd FileType dts setlocal autoindent noexpandtab]]

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

-- MLIR syntax highlighting
vim.cmd [[au BufRead,BufNewFile *.mlir set filetype=mlir]]
vim.cmd [[au BufRead,BufNewFile *.mlir.DISABLED set filetype=mlir]]
-- Python tab should be 2 spaces
vim.cmd [[au Filetype python setl ts=2 sts=2 sw=2]]

-- fzf tuning
vim.cmd([[
  function! s:list_buffers()
    redir => list
    silent ls
    redir END
    return split(list, "\n")
  endfunction

  function! s:delete_buffers(lines)
    execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
  endfunction

  command! BD call fzf#run(fzf#wrap({
    \ 'source': s:list_buffers(),
    \ 'sink*': { lines -> s:delete_buffers(lines) },
    \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
  \ }))
]])

vim.cmd([[
  au! BufEnter *.cc let b:fswitchdst = 'h,hh,hpp' | let b:fswitchlocs = '.'
  au! BufEnter *.h let b:fswitchdst = 'c,cc,cpp' | let b:fswitchlocs = '.'
]])
