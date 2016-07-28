" Space is useless, make it useful (don't lose comma functionality!)
" Need to do this before plugins load!
let mapleader = "\<Space>"

" termcap issue on OSX requires:
"   $ infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
"   $ tic $TERM.ti
" in order for <c-h> to work as expected
" -- https://github.com/neovim/neovim/issues/2048#issuecomment-78045837

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'

Plug 'tpope/vim-ragtag'
" ragtag in all your files
let g:ragtag_global_maps = 1

Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

Plug 'tpope/vim-unimpaired'
" Add/remove current file to arguments list, for use with [a & ]a
nnoremap <leader>a :argadd %<cr>
nnoremap <leader>A :argdel %<cr>
" unimpaired-like tab navigation
nmap <silent> tt :tabnew<CR>
nmap <silent> [g :tabprevious<CR>
nmap <silent> ]g :tabnext<CR>
nmap <silent> [G :tabrewind<CR>
nmap <silent> ]G :tablast<CR>

Plug 'ctrlpvim/ctrlp.vim'
" Don't jump to other tabs
let g:ctrlp_switch_buffer=''
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v\.git$|\.hg$|\.svn$|doc$|node_modules$|migrate$|_LOCAL$|nanoc[\/]output$|Timecounts-Frontend[\/]timecounts-api$|tmp$',
"  \ 'file': '\v\.exe$|\.so$|\.dll|nanoc[\/]content[\/].*\.yaml$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }
" This disables ctrlp_custom_ignore; but `ag` does it for us
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_working_path_mode=0
let g:ctrlp_cmd='CtrlPCurWD'
nnoremap <silent> <leader>p :<c-u>CtrlPBuffer<cr>

" C-HJKL to change vim panes and tmux panes
Plug 'christoomey/vim-tmux-navigator'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='powerlineish'
"let g:airline_section_z=''
let g:airline_powerline_fonts = 1

"Plug 'rking/ag.vim'
Plug 'mhinz/vim-grepper'
" Takes a motion and greps for it
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
" Set up :Ag command
command! -nargs=* -complete=file Ag Grepper -tool ag  -query <args>

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

Plug 'tomtom/tcomment_vim'

if has('nvim')
  let g:neoterm_automap_keys=" tt"
  Plug 'kassio/neoterm'
  let test#strategy = 'neoterm'
end
Plug 'janko-m/vim-test'
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let g:test#ruby#rspec#executable = 'zeus rspec'


"Plug 'sjl/vitality.vim'

Plug 'michaeljsmith/vim-indent-object'

let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
" Above from https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/

Plug 'benjie/neomake-local-eslint.vim'
Plug 'benekastah/neomake'
"let g:neomake_javascript_eslint_exe = '/Users/benjiegillam/Documents/timecounts-frontend/node_modules/.bin/eslint'
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
autocmd! BufWritePost *.js,*.jsx silent NeomakeFile
autocmd! BufWinEnter *.js,*.jsx silent NeomakeFile
let g:neomake_coffee_enabled_makers = ['coffeelint']
let g:neomake_cjsx_enabled_makers = ['coffeelint']
autocmd! BufWritePost *.coffee,*.cjsx silent NeomakeFile
autocmd! BufWinEnter *.coffee,*.cjsx silent NeomakeFile
let g:neomake_ruby_rubocop_args = ['--format', 'emacs', '-D']
let g:neomake_ruby_enabled_makers = ['rubocop']
autocmd! BufWritePost *.rb silent NeomakeFile
autocmd! BufWinEnter *.rb silent NeomakeFile
let g:neomake_list_height = 5


" ========================================================================
" Language: JavaScript / CoffeeScript / JSON
" ========================================================================
" Stolen from
" https://github.com/davidosomething/dotfiles/blob/master/vim/vimrc

Plug 'elzr/vim-json'

" provides coffee ft
Plug 'kchmck/vim-coffee-script'
"Plug 'mintplant/vim-literate-coffeescript'
autocmd FileType litcoffee runtime ftplugin/coffee.vim

Plug 'mtscout6/vim-cjsx'

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
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }

" ----------------------------------------
" Syntax Addons
" ----------------------------------------

" Options
"'gavocanov/vim-js-indent'                " Indent from pangloss
"'jiangmiao/simple-javascript-indenter'   " Alternative js indent
"'jason0x43/vim-js-indent'                " Use HTML's indenter with
				    " TypeScript support
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }

" es.next support
"Plug 'othree/es.next.syntax.vim'

" extends syntax for with jQuery,backbone,etc.
Plug 'othree/javascript-libraries-syntax.vim'

" After syntax, ftplugin, indent for JSX
Plug 'mxw/vim-jsx'

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

Plug 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
Plug 'haya14busa/incsearch-fuzzy.vim'
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

Plug 'junegunn/vim-easy-align'

Plug 'airblade/vim-gitgutter'
" [c ]c to move between hunks
" <Leader>hs to stage hunk

Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

Plug 'Wolfy87/vim-syntax-expand'
function! ExpandJS()
  inoremap <silent> @ <C-r>=syntax_expand#expand("@", "this.")<CR>
  inoremap <silent> @@ <C-r>=syntax_expand#expand("@@", "this.props.")<CR>
  inoremap <silent> @@s <C-r>=syntax_expand#expand("@@s", "this.state.")<CR>
  inoremap <silent> @@S <C-r>=syntax_expand#expand("@@S", "this.setState({")<CR>
  inoremap <silent> @@. <C-r>=syntax_expand#expand("@@.", "this.styles.")<CR>
  inoremap <silent> # <C-r>=syntax_expand#expand("#", ".prototype.")<CR>
endfunc
autocmd! BufWinEnter *.js,*.jsx call ExpandJS()

Plug 'embear/vim-localvimrc'
" Persist capital-letter choices
let g:localvimrc_persistent=1

Plug 'exu/pgsql.vim'
let g:sql_type_default = 'pgsql'

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
nmap <Down> gj
nmap <Up> gk

" re-source this file, install plugins
nmap <silent> <leader>rc :so ~/.config/nvim/init.vim \| PlugInstall<CR>

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" mkdir the folder for the current buffer
nmap <silent> <leader>md :!mkdir -p %:h<CR><CR>

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
vnoremap <leader>o <Esc>:!echo `git ghurl`/blob/`git rev-parse --abbrev-ref HEAD`/`git ls-tree --full-name --name-only HEAD %`\#L<C-R>=line("'<")<CR>-<C-R>=line("'>")<CR> \| xargs open<CR><CR>gv

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
nmap <silent> <leader>si vii:sort /\v[^=:]+/ r<CR>
" Sort all items in the current block ({})
nmap <silent> <leader>sb {eV}k:sort /\v[^=:]+/ r<CR>
" Sort current visual selection
vmap <silent> <leader>s :sort /\v[^=:]+/ r<CR>
"""""""""" /SORTING

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" So you can jump to files without extensions
autocmd filetype jade setl suffixesadd=.jade
autocmd filetype stylus setl suffixesadd=.styl
autocmd filetype javascript setl suffixesadd=.coffee,.litcoffee,.cjsx,.js,.json,.jsx
autocmd filetype coffee setl suffixesadd=.coffee,.litcoffee,.cjsx,.js,.json,.jsx
autocmd filetype javascript setl path+=src
autocmd filetype coffee setl path+=src

" No save backup by .swp
set nowb
set noswapfile
set noar

" Persistent undo
let &undodir=expand('$HOME/.vimundo')
set undofile

function! AddComponent(name)
  exe "!./add_component ".shellescape(a:name)
  exe "split src/components/".a:name.".jsx"
endfunction

command! -nargs=1 AddComponent call AddComponent(<f-args>)

" Don't syntax highlight long lines
set synmaxcol=120

" Exit terminal mode with Escape press
if exists(':tnoremap')
  tnoremap <Esc> <C-\><C-n>
endif
