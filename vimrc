set nocompatible               " be iMproved
filetype off                   " required!

let mapleader = "\<Space>"

let g:syntastic_ruby_exec = system("/bin/echo -n '~/.rbenv/versions/'`cat ~/.rbenv/version`'/bin/ruby'")
let g:ruby_path = system('echo $HOME/.rbenv/shims')

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'brainbakery/vim-brainbakery'

"Bundle 'tpope/vim-haml'

Bundle 'pangloss/vim-javascript'
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-abolish'
"Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-unimpaired'
nnoremap <leader>a :argadd %<cr>
nnoremap <leader>A :argdel %<cr>
"Bundle 'vim-scripts/searchfold.vim'
"Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-ragtag'
Bundle 'kchmck/vim-coffee-script'
"Bundle 'mattn/gist-vim'
Bundle 'kien/ctrlp.vim'
"Bundle 'juvenn/mustache.vim'
"Bundle 'slim-template/vim-slim'
Bundle 'tpope/vim-commentary'
"Bundle 'vim-ruby/vim-ruby'

Bundle 'wgibbs/vim-irblack'
Bundle 'vim-scripts/vim-stylus'
autocmd filetype stylus setl suffixesadd=.styl
"Bundle 'airblade/vim-gitgutter'


" Following one pisses me off too much
"Bundle 'Raimondi/delimitMate'

" Don't use this: you can't use `.` to repeat dt" reliably
"Bundle 'dahu/vim-fanfingtastic'

"Bundle 'ap/vim-css-color'
"Bundle 'mileszs/ack.vim'
Bundle 'digitaltoad/vim-jade'
autocmd filetype jade setl suffixesadd=.jade
" mustache and handlebars vim mode
"Bundle 'mustache/vim-mode'
Bundle 'sjl/vitality.vim'

" Automatically close things
Bundle 'tpope/vim-endwise'

" Navigate vim windows inside tmux as if they were tmux panes
Bundle 'christoomey/vim-tmux-navigator'

" Unix command helpers, especially :Move
Bundle 'tpope/vim-eunuch'

" Plugins that I tend not to use in terminal vim
" (where I tend to favour faster startup)
if has("gui_running") || 1 > 0
  Bundle 'godlygeek/tabular'
  Bundle 'tpope/vim-fugitive'
  Bundle 'tpope/vim-git'
  Bundle 'tpope/vim-rails'
  Bundle 'tpope/vim-bundler'
  "Bundle 'vim-scripts/taglist.vim'
  Bundle 'michaeljsmith/vim-indent-object'
  "Bundle 'SirVer/ultisnips'
  Bundle 'rking/ag.vim'
  Bundle 'nathanaelkane/vim-indent-guides'
  "Bundle 'vim-scripts/Align'
  Bundle 'scrooloose/syntastic'
  " Disabled in favour of vim-commentary:
  "Bundle 'scrooloose/nerdcommenter'

  Bundle 'scrooloose/nerdtree'
  " NERDTree configuration
  let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
  map <Leader>n :NERDTreeToggle<CR>

  Bundle 'mattn/gist-vim'
  " Commented in favour of YCM
  "Bundle 'Rip-Rip/clang_complete'

  set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
  Bundle 'Lokaltog/powerline'

  "Bundle 'mattn/webapi-vim'

  " Databases access in Vim!
  "Bundle 'vim-scripts/dbext.vim'

  Bundle 'Valloric/YouCompleteMe'

  Bundle 'majutsushi/tagbar'
  nmap <F8> :TagbarToggle<CR>
endif

" Make vim wait less time for <Esc> codes.
set ttimeoutlen=10

set number
syntax on
set autoread " Automatically reload changes if detected
set ruler
set encoding=utf8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
"set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,*.rbc,*.class,.svn,vendor/gems/*
set wildignore+=*/.hg/*,*/.svn/*,*/LOCAL/*,*/log/*
set wildignore+=*/tags
set wildignore+=*/sessions/*
"Coffeescript
"set wildignore+=*/node_modules/*
"Rails
set wildignore+=*/doc/*
" Patter ignore when use the completion in search file
set wildignore+=*.o,*.obj,*~,#*#,*.pyc,*.tar*,*.avi,*.ogg,*.mp3

" Status bar
set laststatus=2

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" CTags
map <Leader>rt :!/usr/local/bin/ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

function! s:setupWrapping()
  setlocal wrap
  setlocal wrapmargin=2
  setlocal textwidth=72
endfunction

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,Guardfile}    set ft=ruby
"
" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupWrapping()

" Objective-C, c
function! s:objcSettings()
  setlocal ts=4
  setlocal sw=4
  setlocal noexpandtab
  setlocal nolist
endfunction
au BufRead,BufNewFile *.{c,m,h} call s:objcSettings()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript
au BufRead,BufNewFile *.txt call s:setupWrapping()

" Mustache configuration
au BufNewFile,BufRead *.mustache        setf mustache

" Yaml Configuration
au BufRead,BufNewFile *.{yml,yaml} set foldmethod=indent

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}

" Use modeline overrides
"set modeline
"set modelines=10

set cursorline

" Default color scheme
color ir_black

" Show (partial) command in the status line
set showcmd
" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" No save backup by .swp
set nowb
set noswapfile
set noar

" Delete all whitespace in end of line
autocmd BufWritePre *.{coffee,js,h,m} :%s/\s\+$//e

" Autocomplete Fabricator gem
autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=model()

" Autocomplete Fabricator gem
autocmd User Rails Rnavcommand decorator app/decorators -suffix=_decorator.rb -default=model()

set foldmethod=syntax

let g:Powerline_symbols = 'fancy'
set t_Co=256

let Tlist_Auto_Update = 'true'
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

let g:tagbar_type_coffee = {
    \ 'ctagstype' : 'coffee',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 'm:methods',
        \ 'f:functions',
        \ 'v:variables',
        \ 'f:fields',
    \ ]
\ }

"spell check when writing commit logs
autocmd filetype svn,*commit* set spell

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|doc$\|node_modules$\|migrate$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" mkdir the folder for the current buffer
nmap <silent> <leader>md :!mkdir -p %:h<CR><CR>

" Reload vimrc; install bundle
nmap <silent> <leader>rc :so ~/.vimrc \| BundleInstall<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

if has("gui_macvim") && has("gui_running")
  set guioptions=egmrt
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <D-]> >gv
  vmap <D-[> <gv

  nmap <D-]> >>
  nmap <D-[> <<

  omap <D-]> >>
  omap <D-[> <<

  imap <D-]> <Esc>>>i
  imap <D-[> <Esc><<i

  " Bubble single lines
  nmap <D-Up> [e
  nmap <D-Down> ]e
  nmap <D-k> [e
  nmap <D-j> ]e

  " Bubble multiple lines
  vmap <D-Up> [egv
  vmap <D-Down> ]egv
  vmap <D-k> [egv
  vmap <D-j> ]egv

  " Map Command-# to switch tabs
  map  <D-0> 0gt
  imap <D-0> <Esc>0gt
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt
else
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <A-]> >gv
  vmap <A-[> <gv

  nmap <A-]> >>
  nmap <A-[> <<

  omap <A-]> >>
  omap <A-[> <<

  imap <A-]> <Esc>>>i
  imap <A-[> <Esc><<i

  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  "nmap <C-k> [e
  "nmap <C-j> ]e

  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
  "vmap <C-k> [egv
  "vmap <C-j> ]egv

  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>

  " Map Control-# to switch tabs
  map  <C-0> 0gt
  imap <C-0> <Esc>0gt
  map  <C-1> 1gt
  imap <C-1> <Esc>1gt
  map  <C-2> 2gt
  imap <C-2> <Esc>2gt
  map  <C-3> 3gt
  imap <C-3> <Esc>3gt
  map  <C-4> 4gt
  imap <C-4> <Esc>4gt
  map  <C-5> 5gt
  imap <C-5> <Esc>5gt
  map  <C-6> 6gt
  imap <C-6> <Esc>6gt
  map  <C-7> 7gt
  imap <C-7> <Esc>7gt
  map  <C-8> 8gt
  imap <C-8> <Esc>8gt
  map  <C-9> 9gt
  imap <C-9> <Esc>9gt
endif


au ColorScheme *.{md,mdown,mkd,mkdn,markdown,mdwn} highlight ExtraWhitespace ctermbg=red guibg=red
" Ensure 5 lines of context always visible about cursor
set scrolloff=5
" ', ' maps to clear highlights
nnoremap <leader><space> :noh<cr>
" ',cd' changes directory to the current file's parent
nnoremap <leader>cd :lcd %:h<cr>
" Open a new vertical split and then switch to it.
nnoremap <leader>w <C-w>v<C-w>l
" Insert variable definition for default register content using last
" inserted text.
nnoremap <leader>v O<C-a> = <C-r>"<Esc>
" Control-[hjkl] navigate between splits.
" Disabled because of vim-tmux-navigator
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l
set background=dark
" 
" Markdown macros
" Header - type = or - afterwards to choose header type
nnoremap <leader>mh yypv$r
"nnoremap <leader>ml mLyi]Go[<Esc>pA]: <Esc>`L
" Copies the link spec to bottom - defers entry
nnoremap <leader>ml mLya]Go: <Esc>0P`L
" Copies the link spec to bottom and populates with system clipboard
nnoremap <leader>mL mLya]Go: <Esc>"*p0P`L

" Open current line on github
" Credit: http://felixge.de/2013/08/08/vim-trick-open-current-line-on-github.html
nnoremap <leader>o :!echo `git ghurl`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line('.')<CR> \| xargs open<CR><CR>
vnoremap <leader>o <Esc>:!echo `git ghurl`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line("'<")<CR>-<C-R>=line("'>")<CR> \| xargs open<CR><CR>gv

" Deletes
nnoremap <leader>bd :b#<bar>bd#<CR>
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} setlocal spell spelllang=en
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" Don't unload buffers when switching (preserves undo history):
set hidden
"*****************************************************************************
" Vim Sessions
"*****************************************************************************
" ignore 'options' because of latex-suite (would be pointless to save that!)
set sessionoptions=blank,curdir,folds,help,resize,tabpages,winsize
map <leader>ss :mksession! ~/.vim/.session<cr>
map <leader>sr :source ~/.vim/.session<cr>

" Don't have YouCompleteMe ignore any files
" (especially not Markdown!)
let g:ycm_filetypes_to_completely_ignore = {}
let g:ycm_complete_in_comments_and_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
"let g:ycm_semantic_triggers =  {
"  \   'c' : ['->', '.'],
"  \   'objc' : ['->', '.'],
"  \   'cpp,objcpp' : ['->', '.', '::'],
"  \   'perl,php' : ['->'],
"  \   'cs,java,javascript,d,vim,ruby,python,perl6,scala,vb,elixir' : ['.'],
"  \   'coffee' : ['.'],
"  \   'lua' : ['.', ':'],
"  \   'erlang' : [':'],
"  \ }

set guifont=Menlo\ for\ Powerline

let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ctrlp_clear_cache_on_exit=0
" Have CtrlP use Vim's cwd not it's smarty pants stuff.
let g:ctrlp_working_path_mode=0
let g:ctrlp_cmd='CtrlPCurWD'
nnoremap <silent> <leader>p :<c-u>CtrlPBuffer<cr>

" Code folding based on indent for CoffeeScript
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
" Unfold one level
"au BufNewFile,BufReadPost *.coffee normal zMzr
" Unfold fully
au BufNewFile,BufReadPost *.coffee normal zn
au BufNewFile,BufReadPost * normal zn

" UltiSnips completion function that tries to expand a snippet. If there's no
" snippet for expanding, it checks for completion window and if it's
" shown, selects first element. If there's no completion window it tries to
" jump to next placeholder. If there's no placeholder it just returns TAB key 
function! g:UltiSnips_Complete()
  call UltiSnips_ExpandSnippet()
  if g:ulti_expand_res == 0
    call UltiSnips_JumpForwards()
    if g:ulti_jump_forwards_res == 0
      if pumvisible()
        return "\<C-n>"
      else
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction
let g:UltiSnipsExpandTrigger = "<Tab>"
if has("gui_running")
  exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
endif

" Meta-Tab forces UltiSnips to jump forwards (for if autocomplete is
" being a pain).
inoremap <silent> <M-Tab> <C-R>=UltiSnips_JumpForwards()<cr>

" Open ultisnips edits in vertical split
let g:UltiSnipsEditSplit = 'vertical'

" Opens UltiSpips editor
nmap <silent> <leader>es :UltiSnipsEdit<CR>

" Prevent numbers like 007 being manipulated as octal
set nrformats=

" Toggle between relative and absolute line numbering
function! g:ToggleNuMode()
  if(&rnu == 1)
    set number
  else
    set relativenumber
  endif
endfunc
noremap <C-n> :call g:ToggleNuMode()<cr>

" Syntax syncing
nnoremap <F5> <Esc>:syntax sync fromstart<CR>
inoremap <F5> <C-o>:syntax sync fromstart<CR>
