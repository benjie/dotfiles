" I do not use modelines, and they open you up to security vulnerabilities, so
" disable them!
set modelines=0
set nomodeline

" Space is useless, make it useful (don't lose comma functionality!)
" Need to do this before plugins load!
let mapleader = "\<Space>"

" More natural split locations
set splitbelow
set splitright

" Don't wrap around when searching
set nowrapscan

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-ragtag'
" ragtag in all your files
let g:ragtag_global_maps = 1
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

Plug 'michaeljsmith/vim-indent-object'

Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""
"         BENJIE STUFF
""""""""""""""""""""""""""""""""""""""""

" Map the arrow keys to be based on display lines, not physical lines
nnoremap <Down> gj
nnoremap <Up> gk

" re-source this file, install plugins
nnoremap <silent> <leader>rc :so ~/.config/nvim/vscode.init.vim \| PlugInstall<CR>

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

" Open current line on github
" Credit: http://felixge.de/2013/08/08/vim-trick-open-current-line-on-github.html
nnoremap <leader>o :!echo `git ghurl`/blob/`git rev-parse --abbrev-ref HEAD`/`git ls-tree --full-name --name-only HEAD %`\#L<C-R>=line('.')<CR> \| xargs open<CR><CR>
vnoremap <leader>o <Esc>:!echo `git ghurl`/blob/`git rev-parse --abbrev-ref HEAD`/`git ls-tree --full-name --name-only HEAD %`\#L<C-R>=line("'<")<CR>-L<C-R>=line("'>")<CR> \| xargs open<CR><CR>gv

" Maximize current pane
nnoremap <C-w>a <C-w>\|<C-w>_


"""""""""" SORTING
" Sort all items in the current indent level
nnoremap <silent> <leader>si vii:sort /\v[^=:]+/ r<CR>
" Sort all items in the current block ({})
nnoremap <silent> <leader>sb {eV}k:sort /\v[^=:]+/ r<CR>
" Sort current visual selection
vnoremap <silent> <leader>s :sort /\v[^=:]+/ r<CR>
"""""""""" /SORTING

" Insert the current file name (except extension)
inoremap <leader><leader>fn <C-R>=expand("%:t:r")<CR>

" No save backup by .swp
set nowb
set noswapfile
set noar

" Persistent undo
let &undodir=expand('$HOME/.vscode_vimundo')
set undofile

""""""""""""""""""""""""""""""""""""""""
"         VSCode Specific
""""""""""""""""""""""""""""""""""""""""

" Window navigation

nnoremap <silent> <C-j> :<C-u>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
xnoremap <silent> <C-j> :<C-u>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
nnoremap <silent> <C-k> :<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
xnoremap <silent> <C-k> :<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
nnoremap <silent> <C-h> :<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
xnoremap <silent> <C-h> :<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nnoremap <silent> <C-l> :<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
xnoremap <silent> <C-l> :<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
