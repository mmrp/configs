" Specify a directory for plugins

call plug#begin()
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'


Plug 'williamboman/mason.nvim'
Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'


" colorscheme
Plug 'mcchrish/zenbones.nvim'
Plug 'rktjmp/lush.nvim'

Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua' " recommended if need floating window support




" cnext, cprev
Plug 'tpope/vim-unimpaired'

Plug 'flazz/vim-colorschemes'

" color highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'xolox/vim-colorscheme-switcher'

Plug 'bling/vim-bufferline'

Plug 'xolox/vim-misc'

Plug 'darrikonn/vim-gofmt'

Plug 'bluz71/vim-nightfly-guicolors'

Plug 'junegunn/fzf.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'itspriddle/vim-shellcheck'

Plug 'tpope/vim-fugitive'

Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }

Plug 'glepnir/lspsaga.nvim'

" markup 
"Plug 'godlygeek/tabular'
"Plug 'preservim/vim-markdown'

"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }



"Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }


" cscope
Plug 'dhananjaylatkar/cscope_maps.nvim' " cscope keymaps
Plug 'folke/which-key.nvim' " optional [for whichkey hints]
Plug 'nvim-telescope/telescope.nvim' " roptional [for picker='telescope']
Plug 'ibhagwan/fzf-lua' " optional [for picker='fzf-lua']
Plug 'nvim-tree/nvim-web-devicons' " optional [for devicons in telescope or fzf]

" troubleshoot
Plug 'folke/lsp-trouble.nvim'
Plug 'folke/lsp-colors.nvim'

" randomquote
Plug 'kungfusheep/randomquote.nvim'

" tokyonight
Plug 'folke/tokyonight.nvim'

" tslint
Plug 'MunifTanjim/eslint.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'


Plug 'mhartington/formatter.nvim'

Plug 'VonHeikemen/lsp-zero.nvim'
" Initialize plugin system
call plug#end()

inoremap jk <ESC>

" vim-prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
" run prettier on save
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync


" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

"colorscheme gruvbox

" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

"##############################vimrc configuration #########################
function! ToggleVerbose()
    if !&verbose
        set verbosefile=~/.log/vim/verbose.log
        set verbose=15
    else
        set verbose=0
        set verbosefile=
    endif
endfunction

fun! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun

"  format cpp code
fun! Formatonsave()
  let l:lines="all" "formatdiff = 1
  pyf ~/work/scripts/clang-format.py
endfun



set tabstop=2
set shiftwidth=2
set expandtab
set mouse=a
"set tabstop=4
"set shiftwidth=4
"set noexpandtab

" Have a column marker, we use 111 for cpp code
set colorcolumn=111

" Enable auto highlight when pressing *
set hlsearch

" Display line numbers
set nu
set relativenumber

" Enable spell checking, which is not on by default for commit messages.
au FileType gitcommit setlocal spell

" Source code browsing
"source ~/.vim/cscope_maps.vim


" --------- Set number of spaces and tabs to use when using specific files ----
autocmd BufRead,BufNewFile *.cpp,.hpp setlocal ts=4 sw=2 expandtab
"autocmd BufRead,BufNewFile *.sh,*.c,*.h, setlocal ts=4 sw=4 expandtab
autocmd BufRead,BufNewFile *.py setlocal ts=4 sw=4 expandtab

" ----   Cleanup TOML/bash files after writing  -------
"

" autocmd BufWritePre *.c,*.hpp,*.cc,*.cpp,*.proto call Formatonsave()
autocmd BufWritePre *.go GoFmt
autocmd BufWritePre *.toml call TrimWhitespace()
autocmd BufWritePre *.sh call TrimWhitespace()
"autocmd BufWritePre *.py :%!black -l 110
"autocmd BufWritePre BUILD :%!buildifier -mode=check

" shortcuts

noremap <F3> :call Formatonsave()<CR>

noremap <C-d> :CocDisable<CR>
"noremap <C-d> :call CocAction('diagnosticToggle')<CR>

let mapleader=","
nnoremap <F8> :setl noai nocin nosi inde=<CR>

noremap <Leader>w :call TrimWhitespace()<CR>

" Undo highlighting
noremap <F4> :set hlsearch! hlsearch?<CR>

nmap <F9> :TagbarToggle<CR>

" buffer navigation
map <C-J> :bprev<CR>
map <C-K> :bnext<CR>

" navigate tabs
nnoremap H gT
nnoremap L gt

" write current buffer and move to next
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" paste mode toggle (needed when using autoindent/smartindent)
map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>

" shortcut
imap jj <Esc>

" lists buffers and waits for buffer number to open
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <S-x> :bd<CR>

" ------------------------ colors -------------------
" enable terminal colors
set termguicolors

colorscheme molokai_dark
" Change colorscheme when using diff
if &diff
  set background=dark
"colorscheme github
  colorscheme molokai_dark
  call CocDisable<CR>
endif

" Fix the difficult-to-read default setting for diff text highlighting.  The
" bang (!) is required since we are overwriting the DiffText setting. The highlighting
" for "Todo" also looks nice (yellow) if you don't like the "MatchParen" colors.
highlight! link DiffText Todo
"MatchParen

" ------ Syntax highlighting ---------
"autocmd CursorHold * silent call CocActionAsync('highlight')


" set status line
set title
set laststatus=2
set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"

" ------- undos -------------------
" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fine
set swapfile
set directory^=~/.vim/swap//

" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" patch required to honor double slash at end
if has("patch-8.1.0251")
	" consolidate the writebackups -- not a big
	" deal either way, since they usually get deleted
	set backupdir^=~/.vim/backup//
end

" persist the undo tree for each file
"set undofile
"set undodir^=~/.vim/undo//

" use netrw


let g:netrw_liststyle = 3
set path+=**
set wildmenu

" fzf shortcuts - find files
nnoremap <silent> <F6> :Files<CR>

" rebuild cscope database
map <F5> :!cscope -Rb<CR>:cs reset<CR><CR>                                      


" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" enable rainbow for c, cpp etc
"au FileType c,cpp,objc,objcpp call rainbow#load()
" lsp setting for syntax highlighting
let g:lsp_cxx_hl_use_text_props = 1

" foldings [will work in visual mode as well]
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

command -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | cw | redraw!
nnoremap <C-G> :Ggr <cword><CR>

" we keep colors in lua/config.lua with treesitter
lua require ('config')

let g:python3_host_prog="/usr/bin/python3"

" autocomplete
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
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

  -- Set up lspconfig.
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*" }, command = [[%s/\s\+$//e]], })

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['clangd'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    cmd = {
    "/home/madan/.local/share/nvim/lsp_servers/clangd/clangd/bin/clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
		"--header-insertion-decorators",
		"--completion-style=bundled",
		"--pch-storage=memory",
		-- "--log=verbose",
    },
}

require("mason").setup()

require('mason-tool-installer').setup {

  -- a list of all tools you want to ensure are installed upon
  -- start
  ensure_installed = {

    -- you can pin a tool to a particular version
    -- { 'golangci-lint', version = 'v1.47.0' },

    -- you can turn off/on auto_update per tool
    { 'bash-language-server', auto_update = true },

    'golangci-lint',
    'lua-language-server',
    'vim-language-server',
    'gopls',
    'stylua',
    'shellcheck',
    'editorconfig-checker',
    'gofumpt',
    'golines',
    'gomodifytags',
    'gotests',
    'impl',
    'json-to-struct',
    'luacheck',
    'misspell',
    'revive',
    'shellcheck',
    'shfmt',
    'staticcheck',
    'vint',
    "eslint",
    "prettier",
  },

  -- if set to true this will check each tool for updates. If updates
  -- are available the tool will be updated. This setting does not
  -- affect :MasonToolsUpdate or :MasonToolsInstall.
  -- Default: false
  auto_update = false,

  -- automatically install / update on startup. If set to false nothing
  -- will happen on startup. You can use :MasonToolsInstall or
  -- :MasonToolsUpdate to install tools and check for updates.
  -- Default: true
  run_on_start = true,

  -- set a delay (in ms) before the installation starts. This is only
  -- effective if run_on_start is set to true.
  -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
  -- Default: 0
  start_delay = 3000, -- 3 second delay

  -- Only attempt to install if 'debounce_hours' number of hours has
  -- elapsed since the last time Neovim was started. This stores a
  -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
  -- This is only relevant when you are using 'run_on_start'. It has no
  -- effect when running manually via ':MasonToolsInstall' etc....
  -- Default: nil
  debounce_hours = 5, -- at least 5 hours between attempts to install/update
}

require('lualine').setup()

require("cscope_maps").setup()
require('nvim-treesitter.configs').setup{highlight={enable=true}}
--require("randomquote").setup()
-- vim.cmd[[colorscheme tokyonight]]


EOF

lua <<EOF
require("trouble").setup ()
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", {silent = true, noremap = true}) 
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics toggle<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble toggle lsp_document_diagnostics toggle <cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist toggle <cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})
EOF



" colorscheme nightfly
"let g:lightline = { 'colorscheme': 'nightfly' }
"let g:moonflyIgnoreDefaultColors = 1


let g:shfmt_fmt_on_save = 1

lua <<EOF
require('telescope').setup()

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})

require('go').setup()



vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format {async = false, id = args.data.client_id }
      end,
    })
  end
})
EOF

" autoformat ts/js script
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
