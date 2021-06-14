" I do not use modelines, and they open you up to security vulnerabilities, so
" disable them!
set modelines=0
set nomodeline

" True colour support
set termguicolors

" Space is useless, make it useful (don't lose comma functionality!)
" Need to do this before plugins load!
let mapleader = "\<Space>"

" More natural split locations
set splitbelow
set splitright

" Neovim turned this off in 0.2 (apparently it was buggy?) it's not buggy for
" me: re-enable!
set mouse=a

" Configure cursor shape
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

" Don't wrap around when searching
set nowrapscan

" termcap issue on OSX requires:
"   $ infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
"   $ tic $TERM.ti
" in order for <c-h> to work as expected
" -- https://github.com/neovim/neovim/issues/2048#issuecomment-78045837

" Disable banner
let g:netrw_banner = 0
" Use vertical rather than horizontal split for preview
let g:netrw_preview   = 1
" Use tree view in netrw
let g:netrw_liststyle = 3
" Only use 20% of width when opening split/preview
let g:netrw_winsize   = 20
" Browse in vertical split
let g:netrw_browse_split = 2

call plug#begin('~/.vim/plugged')
if !exists('g:gui_oni') && !exists('g:vscode')
  "Plug 'tpope/vim-sensible'
endif
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'

Plug 'tpope/vim-ragtag'
" ragtag in all your files
let g:ragtag_global_maps = 1

" Not developing rails any more
" Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'tpope/vim-unimpaired'
" Add/remove current file to arguments list, for use with [a & ]a
nnoremap <leader>a :argadd %<cr>
nnoremap <leader>A :argdel %<cr>
" unimpaired-like tab navigation
nnoremap <silent> tt :tabnew<CR>
nnoremap <silent> [g :tabprevious<CR>
nnoremap <silent> ]g :tabnext<CR>
nnoremap <silent> [G :tabrewind<CR>
nnoremap <silent> ]G :tablast<CR>
" 'r' for 'error' (from ALE lint)
"nnoremap <silent> [r <Plug>(coc-diagnostic-prev)
"nnoremap <silent> ]r <Plug>(coc-diagnostic-next)

Plug 'ctrlpvim/ctrlp.vim'
" Don't jump to other tabs
let g:ctrlp_switch_buffer=''
"let g:ctrlp_use_caching = 1
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode=0
let g:ctrlp_cmd='CtrlPCurWD'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v\.git$|\.hg$|\.svn$|doc$|node_modules$|migrate$|_LOCAL$|nanoc[\/]output$|Timecounts-Frontend[\/]timecounts-api$|tmp$|assets$',
  \ 'file': '\v\.exe$|\.so$|\.dll|nanoc[\/]content[\/].*\.yaml$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_user_command = 'cd %s && git ls-files . -co --exclude-standard'
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" Above from https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
nnoremap <silent> <leader>p :<c-u>CtrlPBuffer<cr>

" Add git modified files support to CtrlP
" :CtrlPModified shows all files which have been modified since your last commit.
" :CtrlPBranch shows all files modified on your current branch.
Plug 'jasoncodes/ctrlp-modified.vim'
map <Leader>m :CtrlPModified<CR>
map <Leader>M :CtrlPBranch<CR>

" C-HJKL to change vim panes and tmux panes
Plug 'christoomey/vim-tmux-navigator'

"let g:airline_theme='powerlineish'
"let g:airline_theme='onedark'
"let g:airline_section_z=''
let g:airline_powerline_fonts = 1


" A      displays the mode + additional flags like crypt/spell/paste (INSERT)
" B      VCS information (branch, hunk summary) (master)
" C      filename + read-only flag (~/.vim/vimrc RO)
" X      filetype  (vim)
" Y      file encoding[fileformat] (utf-8[unix])
" Z      current position in the file
" My opinion on importance: C, A, Z, Y, X, B
let g:airline_skip_empty_sections = 1
let g:airline#extensions#default#section_truncate_width = {
    \ 'a': 60,
    \ 'b': 150,
    \ 'x': 130,
    \ 'y': 110,
    \ 'z': 90,
    \ 'warning': 80,
    \ 'error': 80,
    \ }
let g:airline_extensions = ['branch', 'ctrlp', 'hunks', 'quickfix', 'tabline', 'coc']
let g:airline#extensions#coc#enabled = 1

Plug 'vim-airline/vim-airline'
" Make it so you can read the filenames when inactive
"Plug 'vim-airline/vim-airline-themes'

"Plug 'rking/ag.vim'
Plug 'mhinz/vim-grepper'
let g:grepper = {}
let g:grepper.ag = { 'grepprf': 'ag --vimgrep --' }
" Takes a motion and greps for it
nnoremap gs  <plug>(GrepperOperator)
xnoremap gs  <plug>(GrepperOperator)
" Set up :Ag command
command! -nargs=* -complete=file Ag GrepperAg <args>

Plug 'nathanaelkane/vim-indent-guides'

" Entering multiselect:
"   Ctrl-N to multiselect current word
"   Ctrl up/down to add vertical cursors
"   Shift-arrows to start selecting pattern to multiselect
" Once in multiselect:
"   Two modes, switch with <tab>
"   n/N to get next/prev occurrance
"   [/] to jump to next/prev cursor
"   q to skip current cursor and find next
"   Q to remove current cursor and go back to previous
"   Regular vim (i,a,I,A,r,R,c,...)
" :help visual-multi
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" The following was for the previous multiple cursors plugin:
"Plug 'terryma/vim-multiple-cursors'
"" Search for the keyword using *; then Alt-j to turn search results into cursors
"nnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>
"vnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>

" Disabled because I don't use it (it clashes with `vic` from gitgutter which I prefer)
"Plug 'tomtom/tcomment_vim'

if has('nvim')
  let g:neoterm_automap_keys=" tt"
  Plug 'kassio/neoterm'
  let test#strategy = 'neoterm'
end
Plug 'janko-m/vim-test'
nnoremap <silent> <leader>t :TestNearest<CR>
nnoremap <silent> <leader>T :TestFile<CR>
nnoremap <silent> <leader>a :TestSuite<CR>
nnoremap <silent> <leader>l :TestLast<CR>
nnoremap <silent> <leader>g :TestVisit<CR>
let g:test#ruby#rspec#executable = 'zeus rspec'


"Plug 'sjl/vitality.vim'

Plug 'michaeljsmith/vim-indent-object'

Plug 'jparise/vim-graphql'

Plug 'benjie/local-npm-bin.vim'

" For project-level build results; e.g. working through errors from `tsc`
Plug 'benekastah/neomake'

"""" " Because flow is a directory maker, we'll make a fake directory maker for
"""" " eslint too.
"""" let g:neomake_eslint_d_maker = {
""""         \ 'exe': 'eslint_d',
""""         \ 'args': ['%', '-f', 'compact'],
""""         \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
""""         \ '%W%f: line %l\, col %c\, Warning - %m'
""""         \ }
"""" autocmd! BufWritePost *.js,*.jsx silent Neomake! flow eslint_d
"""" autocmd! BufWinEnter *.js,*.jsx silent Neomake! flow eslint_d
"""" let g:neomake_javascript_enabled_makers = ['eslint', 'flow']
"""" let g:neomake_jsx_enabled_makers = ['eslint', 'flow']
let g:neomake_javascript_enabled_makers = []
let g:neomake_javascriptreact_enabled_makers = []
let g:neomake_jsx_enabled_makers = []
let g:neomake_typescript_enabled_makers = ['tsc']
let g:neomake_typescriptreact_enabled_makers = ['tsc']
let g:neomake_graphql_enabled_makers = []
"let g:neomake_coffee_enabled_makers = ['coffeelint']
"let g:neomake_cjsx_enabled_makers = ['coffeelint']
"let g:neomake_ruby_rubocop_args = ['--format', 'emacs', '-D']
"let g:neomake_ruby_enabled_makers = ['rubocop']

"augroup neomake_group
"  autocmd!
"  autocmd BufWritePost *.js,*.jsx,*.graphql silent NeomakeFile
"  autocmd BufWinEnter *.js,*.jsx,*.graphql silent NeomakeFile
"  autocmd BufWritePost *.coffee,*.cjsx silent NeomakeFile
"  autocmd BufWinEnter *.coffee,*.cjsx silent NeomakeFile
"  autocmd BufWritePost *.rb silent NeomakeFile
"  autocmd BufWinEnter *.rb silent NeomakeFile
"  let g:neomake_list_height = 5
"augroup END

Plug 'sbdchd/neoformat'
let g:neoformat_enabled_javascript = ['prettier', 'eslint_d']
let g:neoformat_enabled_javascriptreact = ['prettier', 'eslint_d']
let g:neoformat_enabled_typescript = ['prettier', 'eslint_d']
let g:neoformat_enabled_typescriptreact = ['prettier', 'eslint_d']
"let g:neoformat_enabled_json = ['prettier']
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_graphql = ['prettier']
augroup neoformat_group
  autocmd!
  autocmd FileType javascript exe "augroup neoformatauto | autocmd! BufWritePre <buffer> silent Neoformat | augroup END"
  autocmd BufWritePre *.js,*.jsx silent Neoformat
  autocmd BufWritePre *.ts,*.tsx silent Neoformat
  autocmd BufWritePre *.css silent Neoformat
  autocmd BufWritePre *.graphql silent Neoformat
  autocmd BufWritePre *.json silent Neoformat
  autocmd BufWritePre *.md silent Neoformat
augroup END

Plug 'tpope/vim-dotenv'
" To solve issues with DB timeouts when lots of tables/columns
let g:vim_dadbod_completion_force_context = 1
Plug 'tpope/vim-dadbod'
" coc-db removed as too laggy
Plug 'neoclide/jsonc.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Asynchronous Lint Engine (ALE)
" Disable auto completion because it's provided by nvim-typescript
let g:ale_completion_enabled = 0
" Disable ALS LSP because it's provided by coc.nvim
let g:ale_disable_lsp = 1
" Use the loclist, open on errors
let g:ale_set_quickfix = 0
let g:ale_set_loclist = 1
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
Plug 'w0rp/ale'
" Based on recommended settings from Flow team: https://flow.org/en/docs/editors/vim/
" Limit linters used for JavaScript.
" Disable linting in elixir so iex works
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'javascriptreact': ['eslint'],
\  'typescript': ['eslint'],
\  'typescriptreact': ['eslint'],
\  'graphql': ['eslint'],
\  'elixir': []
\}
let g:ale_fixers = {
\  'javascript': ['eslint'],
\  'javascriptreact': ['eslint'],
\  'typescript': ['eslint'],
\  'typescriptreact': ['eslint'],
\  'graphql': ['eslint'],
\  'elixir': []
\}
let g:ale_fix_on_save = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascriptreact_eslint_executable = 'eslint_d'
let g:ale_typescript_eslint_executable = 'eslint_d'
let g:ale_typescriptreact_eslint_executable = 'eslint_d'
""  'typescript': ['tslint', 'tsserver', 'prettier'],
highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)
let g:ale_sign_error = 'E' " could use emoji
let g:ale_sign_warning = 'W' " could use emoji
let g:ale_statusline_format = ['E %d', 'W %d', '']
" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%code: %%s (%linter%)'
"" Map keys to navigate between lines with errors and warnings.
"nnoremap <leader>an :ALENextWrap<cr>
"nnoremap <leader>ap :ALEPreviousWrap<cr>


Plug 'flowtype/vim-flow', { 'for': ['javascript', 'javascript.jsx'] }


" ========================================================================
" Language: JavaScript / CoffeeScript / JSON
" ========================================================================
" Stolen from
" https://github.com/davidosomething/dotfiles/blob/master/vim/vimrc

Plug 'elzr/vim-json'

" provides coffee ft
Plug 'kchmck/vim-coffee-script'
"Plug 'mintplant/vim-literate-coffeescript'
augroup litcoffee_coffee
  autocmd!
  autocmd FileType litcoffee runtime ftplugin/coffee.vim
augroup END

"Plug 'mtscout6/vim-cjsx'

" ----------------------------------------
" Syntax
" ----------------------------------------

" Options
" 'jelera/vim-javascript-syntax' " Jelera: No indent file
" 'pangloss/vim-javascript'      " pangloss' is probably the oldest, lot of
			   " contributors but not up-to-date
			   " Includes indent settings
" 'othree/yajs.vim'              " othree has the latest support
"                                " no indent file, fork of jelera

" The "for" is required so the syntax registers on filetype, otherwise
" yajs has trouble overriding the default js syntax due to runtime order
"Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
let g:javascript_plugin_flow = 1
"Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }

" ----------------------------------------
" Syntax Addons
" ----------------------------------------

" Options
"'gavocanov/vim-js-indent'                " Indent from pangloss
"'jiangmiao/simple-javascript-indenter'   " Alternative js indent
"'jason0x43/vim-js-indent'                " Use HTML's indenter with
				    " TypeScript support
"Plug 'gavocanov/vim-js-indent', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'jason0x43/vim-js-indent', { 'for': ['javascript', 'javascript.jsx'] }

" After syntax, ftplugin, indent for JSX
"Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
let g:jsx_ext_required = 0

" es.next support
"Plug 'othree/es.next.syntax.vim'

" extends syntax for with jQuery,backbone,etc.
"Plug 'othree/javascript-libraries-syntax.vim'

" TypeScript (only if not using oni)
if !exists('g:gui_oni') && !exists('g:vscode')
  "Plug 'leafgarland/typescript-vim'
  Plug 'HerringtonDarkholme/yats.vim'
  " Disabled in favour of coc.nvim
  " Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
  " For async completion
  "Plug 'Shougo/deoplete.nvim'
  " For Denite features
  "Plug 'Shougo/denite.nvim'
  " For function signatures in echo area
  Plug 'Shougo/echodoc.vim'
  " Enable deoplete at startup
  "let g:deoplete#enable_at_startup = 1
  " Display type info for symbol under cursor (0 because echodoc)
  "let g:nvim_typescript#type_info_on_hold = 1
  " Leave ale to display errors
  "let g:nvim_typescript#diagnostics_enable = 0


  "augroup typescript
  "  autocmd!
  "  " Output the type
  "  autocmd filetype typescript nnoremap TT :TSType<cr>
  "  " Add import to top of file
  "  autocmd filetype typescript nnoremap TI :TSGetCodeFix<cr>
  "  " Jump to definition
  "  autocmd filetype typescript nnoremap TJ :TSTypeDef<cr>
  "  " Rename the symbol
  "  autocmd filetype typescript nnoremap TR :TSRename 
  "  " Force sign column to remain open
  "  autocmd filetype typescript setl signcolumn=yes
  "augroup END
endif

" Flow type
"Plug 'flowtype/vim-flow'
"let g:flow#autoclose = 1
"let g:flow#omnifunc = 1

" ----------------------------------------
" Features
" ----------------------------------------

" Parameter completion
Plug 'othree/jspc.vim'

" gf for going to node_modules files
Plug 'moll/vim-node'

Plug 'Olical/vim-enmasse'

"Plug 'Shougo/deoplete.nvim'
"let g:deoplete#enable_at_startup = 1

Plug 'PeterRincker/vim-argumentative'

"Plug 'haya14busa/incsearch.vim'
"map /  <Plug>(incsearch-forward)
"map ?  <Plug>(incsearch-backward)
"map g/ <Plug>(incsearch-stay)
"Plug 'haya14busa/incsearch-fuzzy.vim'
"map z/ <Plug>(incsearch-fuzzy-/)
"map z? <Plug>(incsearch-fuzzy-?)
"map zg/ <Plug>(incsearch-fuzzy-stay)

Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

Plug 'airblade/vim-gitgutter'
" [c ]c to move between hunks
" <Leader>hs to stage hunk

" Tried this out for a few months, but it annoyed me too much (too many
" parenthesis being swallowed when I type them, having to delete automatically
" inserted parenthesis when I want to wrap something in brackets, etc)
"Plug 'Raimondi/delimitMate'
"let delimitMate_expand_cr = 1
"let delimitMate_expand_space = 1

"Plug 'Wolfy87/vim-syntax-expand'
"function! ExpandJS()
"  inoremap <buffer><silent> @ <C-r>=syntax_expand#expand("@", "this.")<CR>
"  inoremap <buffer><silent> @@ <C-r>=syntax_expand#expand("@@", "this.props.")<CR>
"  inoremap <buffer><silent> @@s <C-r>=syntax_expand#expand("@@s", "this.state.")<CR>
"  inoremap <buffer><silent> @@S <C-r>=syntax_expand#expand("@@S", "this.setState({")<CR>
"  inoremap <buffer><silent> @@. <C-r>=syntax_expand#expand("@@.", "this.styles.")<CR>
"  inoremap <buffer><silent> # <C-r>=syntax_expand#expand("#", ".prototype.")<CR>
"endfunc
"autocmd! BufWinEnter *.js,*.jsx call ExpandJS()

Plug 'embear/vim-localvimrc'
" Persist capital-letter choices
let g:localvimrc_persistent=1

Plug 'benjie/pgsql.vim'
let g:sql_type_default = 'pgsql'

Plug 'ericpruitt/tmux.vim'

" Colorscheme
Plug 'nanotech/jellybeans.vim'
Plug 'joshdick/onedark.vim'

" Like vim's `f` motion, but for two characters
nmap \ <Plug>Sneak_s
nmap <bar> <Plug>Sneak_S
xmap \ <Plug>Sneak_s
xmap <bar> <Plug>Sneak_S
Plug 'justinmk/vim-sneak'

"Plug 'floobits/floobits-neovim'

" Use gS and gJ to split and join lines of text (e.g. HTML tags/attributes, postfix-if's
" in ruby, etc)
Plug 'AndrewRadev/splitjoin.vim'

Plug 'ryanoasis/vim-devicons'

" Time tracking

Plug 'wakatime/vim-wakatime'

" Adds debugging strings to your code
" <Leader>ds adds a console.log line debug
" <Leader>dS adds a console.log variable debug
Plug 'bergercookie/vim-debugstring'

Plug 'tomasiser/vim-code-dark'

" Not using elixir right now...
"Plug 'elixir-editors/vim-elixir'
"Plug 'slashmili/alchemist.vim'

" The Graveyard
"Plug 'tpope/vim-bundler'
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-endwise'
"Plug 'tpope/vim-markdown'
call plug#end()


""""""""""""""""""""""""""""""""""""""""
"         BENJIE STUFF
""""""""""""""""""""""""""""""""""""""""

" Don't unload buffers when switching (preserves undo history):
set hidden

" Make vim wait less time for <Esc> codes.
set ttimeoutlen=-1
" Seems to be required to fix neovim?
set nottimeout

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Map the arrow keys to be based on display lines, not physical lines
nnoremap <Down> gj
nnoremap <Up> gk

" re-source this file, install plugins
nnoremap <silent> <leader>rc :so ~/.config/nvim/init.vim \| PlugInstall<CR>

" cd to the directory containing the file in the buffer
nnoremap <silent> <leader>cd :lcd %:h<CR>

" mkdir the folder for the current buffer
nnoremap <silent> <leader>md :!mkdir -p %:h<CR><CR>

" '  ' maps to clear highlights
nnoremap <leader><space> :noh<cr>

" Insert variable definition for default register content using last
" inserted text.
nnoremap <leader>v O<C-a> = <C-r>"<Esc>

" Markdown macros
" Header - type = or - afterwards to choose header type
nnoremap <leader>mh yypv$r
"nnoremap <leader>ml mLyi]Go[<Esc>pA]: <Esc>`L
" Copies the link spec to bottom - defers entry
nnoremap <leader>ml mLya]Go: <Esc>0P`L
" Copies the link spec to bottom and populates with system clipboard
nnoremap <leader>mL mLya]Go: <Esc>"*p0P`L

" Search for the word under the cursor across the project
nnoremap <leader>* g*:Ag <C-r>/<cr>

" Open current line on github
" Credit: http://felixge.de/2013/08/08/vim-trick-open-current-line-on-github.html
nnoremap <leader>o :!echo `git ghurl`/blob/`git rev-parse --abbrev-ref HEAD`/`git ls-tree --full-name --name-only HEAD %`\#L<C-R>=line('.')<CR> \| xargs open<CR><CR>
vnoremap <leader>o <Esc>:!echo `git ghurl`/blob/`git rev-parse --abbrev-ref HEAD`/`git ls-tree --full-name --name-only HEAD %`\#L<C-R>=line("'<")<CR>-L<C-R>=line("'>")<CR> \| xargs open<CR><CR>gv

" Deletes current buffer
nnoremap <leader>bd :b#<bar>bd#<CR>

" Syntax syncing
nnoremap <F5> <Esc>:syntax sync fromstart<CR>
inoremap <F5> <C-o>:syntax sync fromstart<CR>

" Maximize current pane
nnoremap <C-w>a <C-w>\|<C-w>_

" Prettier divides
set fillchars+=vert:│


"""""""""" SORTING
" Sort all items in the current indent level
nnoremap <silent> <leader>si vii:sort /\v[^=:]+/ r<CR>
" Sort all items in the current block ({})
nnoremap <silent> <leader>sb {eV}k:sort /\v[^=:]+/ r<CR>
" Sort current visual selection
vnoremap <silent> <leader>s :sort /\v[^=:]+/ r<CR>
"""""""""" /SORTING

" Insert the current file name (except extension)
" Disabled because it causes a pause after pressing space whilst editing.
"inoremap <leader><leader>fn <C-R>=expand("%:t:r")<CR>

" Remember last location in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" So you can jump to files without extensions
augroup suffixes
  autocmd!
  autocmd filetype jade setl suffixesadd=.jade
  autocmd filetype stylus setl suffixesadd=.styl
  autocmd filetype javascript setl suffixesadd=.coffee,.litcoffee,.cjsx,.js,.json,.jsx
  autocmd filetype coffee setl suffixesadd=.coffee,.litcoffee,.cjsx,.js,.json,.jsx
  autocmd filetype javascript setl path+=src
  autocmd filetype coffee setl path+=src
  autocmd filetype coffee setl path+=src
augroup END

" Spell checking
augroup md_spell
  autocmd!
  autocmd filetype markdown setl spl=en spell
augroup END
hi clear SpellBad
hi SpellBad cterm=underline

" Gosh-darn tabs go away!
augroup md_no_tabs
  autocmd!
  autocmd filetype markdown setl sw=2 ts=2 et
augroup END

" No save backup by .swp
set nowb
set noswapfile
set noar

" Persistent undo
let &undodir=expand('$HOME/.vimundo')
set undofile

function! AddComponent(name, ...)
  let subpath = (a:0 >= 2) ? a:2 : ""
  exe "!./scripts/add_component.js ".shellescape(a:name)." ".shellescape(subpath)
  exe "edit src/components/".subpath."/".a:name.".js"
  exe "split src/components/".subpath."/".a:name.".scss"
  exe "vsplit src/components/".subpath."/__stories__/".a:name.".stories.js"
endfunction

command! -nargs=+ AddComponent call AddComponent(<f-args>)

" Don't syntax highlight long lines
set synmaxcol=500

if exists(':tnoremap')
  " DISABLED because it's annoying in case you need to vim in the terminal
  "" Exit terminal mode with Escape press
  "tnoremap <Esc> <C-\><C-n>

  " Allow window navigation out of terminal
  tnoremap <C-h> <C-\><C-n><C-w><C-h>
  tnoremap <C-j> <C-\><C-n><C-w><C-j>
  tnoremap <C-k> <C-\><C-n><C-w><C-k>
  tnoremap <C-l> <C-\><C-n><C-w><C-l>

  " Enable some unlikely terminal sequences to quickly escape through to vim
  tnoremap <C-w>\| <C-\><C-n><C-w>\|i
  tnoremap <C-w>= <C-\><C-n><C-w>=i
  tnoremap <C-w>- <C-\><C-n><C-w>-i

  " These are for my muscle memory for terminal splits in tmux
  tnoremap <C-s>% <C-\><C-n>:vsp<cr><C-\><C-n>:terminal<cr>
  tnoremap <C-s>" <C-\><C-n>:sp<cr><C-\><C-n>:terminal<cr>
  " Ctrl-s should exit terminal mode, instead of sleeping the terminal
  tnoremap <C-s> <C-\><C-n>

  " jumping into a terminal split should automatically go into insert mode
  augroup terminal
    autocmd!

    " No line numbers in my terminal thanks!
    autocmd TermOpen * setlocal nonumber norelativenumber

    " Jump into insert mode whenever switching into a terminal (no matter how
    " it be)
    autocmd TermOpen * startinsert
    autocmd FocusGained,BufEnter,BufWinEnter,WinEnter term://* startinsert
    "autocmd BufLeave term://* stopinsert

    " If you exit a terminal with <C-s> for example, then <C-c> should put you
    " back into the terminal insert mode. This is because of my muscle memory
    " for page up/down with tmux :D
    autocmd TermOpen * nnoremap <buffer> <C-c> i
    " Same for enter
    autocmd TermOpen * nnoremap <buffer> <cr> i
  augroup END

endif

hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Make search/visual highlights easier to read
highlight Visual cterm=NONE ctermbg=Black ctermfg=White
highlight Search cterm=NONE ctermbg=darkblue ctermfg=white

" Oni has some annoying defaults, lets undo them
if exists('g:gui_oni')
  set nonumber norelativenumber
  set shell=zsh

  " If using Oni's externalized statusline, hide vim's native statusline
  set noshowmode
  set noruler
  set laststatus=0
  set noshowcmd

  " Oni outputs '2;2u' if you do shift-space in terminal; this fixes that.
  tnoremap <s-space> <space>
endif

"colorscheme jellybeans
"colorscheme onedark
"colorscheme desert
"colorscheme morning
colorscheme codedark
let g:airline_theme = 'codedark'
"highlight Normal ctermfg=black ctermbg=white


" fzf
set rtp+=/usr/local/opt/fzf

" Keep the sign column open always
set signcolumn=yes

"-------------------------------------------------------------------------------
" coc.nvim config
" Give more space for displaying messages.
"set cmdheight=1
" Default 4s is slooooow
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[r` and `]r` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [r <Plug>(coc-diagnostic-prev)
nmap <silent> ]r <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  "autocmd FileType javascript,javascriptreact,typescript,typescriptreact,json,jsonc setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>cp  :<C-u>CocListResume<CR>
" End of coc.nvim setup
"-------------------------------------------------------------------------------

" Use correct cursor shape in Konsole
"let &t_SI = "\<Esc>[6 q"
"let &t_SR = "\<Esc>[4 q"
"let &t_EI = "\<Esc>[2 q"
"
"if exists('$TMUX')
"  let &t_SI = "\ePtmux;\e" . &t_SI . "\e\\"
"  let &t_SR = "\ePtmux;\e" . &t_SR . "\e\\"
"  let &t_EI = "\ePtmux;\e" . &t_EI . "\e\\"
"endif
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
"
