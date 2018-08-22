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

call plug#begin('~/.vim/plugged')
if !exists('g:gui_oni')
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

Plug 'ctrlpvim/ctrlp.vim'
" Don't jump to other tabs
let g:ctrlp_switch_buffer=''
let g:ctrlp_use_caching = 1
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

let g:airline_theme='powerlineish'
"let g:airline_section_z=''
let g:airline_powerline_fonts = 1
let g:airline#extensions#default#section_truncate_width = {
    \ 'a': 50,
    \ 'b': 79,
    \ 'x': 60,
    \ 'y': 88,
    \ 'z': 45,
    \ 'warning': 80,
    \ 'error': 80,
    \ }
let g:airline_extensions = ['branch', 'ctrlp', 'hunks', 'quickfix', 'tabline']
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

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

Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_insert_maps={ "\<C-r>": 1 }
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction
" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

" Search for the keyword using *; then Alt-j to turn search results into cursors
nnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>
vnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>

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

"Plug 'benekastah/neomake' " DISABLED in favour of vim-ale

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
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_graphql_enabled_makers = ['eslint']
let g:neomake_coffee_enabled_makers = ['coffeelint']
let g:neomake_cjsx_enabled_makers = ['coffeelint']
let g:neomake_ruby_rubocop_args = ['--format', 'emacs', '-D']
let g:neomake_ruby_enabled_makers = ['rubocop']

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

Plug 'benjie/neoformat'
let g:neoformat_enabled_javascript = ['eslint_d']
let g:neoformat_enabled_typescript = ['prettier']
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

" Asynchronous Lint Engine (ALE)
Plug 'w0rp/ale'
" Based on recommended settings from Flow team: https://flow.org/en/docs/editors/vim/
" Limit linters used for JavaScript.
" Disable linting in elixir so iex works
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'typescript': ['tslint', 'prettier'],
\  'graphql': ['eslint'],
\  'elixir': []
\}
highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)
let g:ale_sign_error = 'E' " could use emoji
let g:ale_sign_warning = 'W' " could use emoji
let g:ale_statusline_format = ['E %d', 'W %d', '']
" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter% says %s'
" Map keys to navigate between lines with errors and warnings.
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>


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
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
let g:jsx_ext_required = 0

" es.next support
"Plug 'othree/es.next.syntax.vim'

" extends syntax for with jQuery,backbone,etc.
Plug 'othree/javascript-libraries-syntax.vim'


" TypeScript
"Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" For async completion
Plug 'Shougo/deoplete.nvim'
" For Denite features
Plug 'Shougo/denite.nvim'
" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1


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
"Plug 'nanotech/jellybeans.vim'
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

  " jumping into a terminal split should automatically go into insert mode
  augroup terminal
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * startinsert
    autocmd FocusGained,BufEnter,BufWinEnter,WinEnter term://* startinsert
    "autocmd BufLeave term://* stopinsert
  augroup END

endif

hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

highlight Visual cterm=NONE ctermbg=Black ctermfg=White

" Oni has some annoying defaults, lets undo them
if exists('g:gui_oni')
  set nonumber norelativenumber
  set shell=zsh

  " If using Oni's externalized statusline, hide vim's native statusline, 
  set noshowmode
  set noruler
  set laststatus=0
  set noshowcmd
endif

colorscheme onedark
