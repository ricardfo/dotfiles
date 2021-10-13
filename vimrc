" Author  Ricardo Fontoura

" Basic Settings {{{

syntax enable " habilita syntax

let mapleader=","
let maplocalleader="\\"

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_winsize = 75
let g:netrw_sort_options = 'i'
let g:netrw_hide = 1
let g:netrw_list_hide= '^\.git/$,^\.vagrant/$'
autocmd FileType netrw setl bufhidden=delete

set nocompatible " usa VIM padrão, não compatível com VI

filetype plugin indent on " ativa a detecção do arquivo, plugin e recuo

set pastetoggle=<F2> " para a indentação quando colar com o mouse

set hlsearch incsearch smartcase " ativa o contraste de cores na busca de palavras e encontra em maiúsculo ou minisculo

set ruler relativenumber " habilita informções da posição do cursor

set number " habilita numeração das linhas do arquivo

set showcmd " mostra comandos sendo executados

set showmatch " mostra o correspondente de ( { [

set autoindent " copia a indentação da linha corrente para a nova linha

set smartindent " melhora a indentação

set splitright " ao dividir a janela verticalmente, a nova ocupa a direita

set splitbelow " ao dividir a janela horizontalmente, a nova ocupa abaixo

set visualbell " não bipe

set tabstop=4 " número de colunas para o comando <TAB>

" número de espaços a serem usados para cada etapa de (auto) recuo. Usado para 'Cident', >>, <<, etc.
set shiftwidth=4

" número de espaços que um <TAB> conta para enquanto executa a edição de operações, como inserir um <TAB> ou usando <BS>.
set softtabstop=4

" This is a list of directories which will be searched when using :find command
set path+=**

" no modo inserir use o número apropriado de espaços para inserir um <TAB>. Os espaços são usados
" em recuos com os comandos '<' e '<'. E quando autoindent está ativado.
set expandtab

" redesenha quando necessário
set lazyredraw

"colorscheme darkblue " esquema de cores do vim
colorscheme darkblue

"deixa a linha do cursor em destaque
set cursorline

let g:rehash256 = 1

set background=dark

set backspace=indent,eol,start " mais poder ao backspacing

set nobackup noswapfile " disabilita backup e swapfile

set wildmenu " autocompletar visual para o menu de comando

set laststatus=2 " ativa a barra de status

set list " mostra caracteres ocultos

set listchars=tab:>-,eol:¬,trail:▸ " lista de caracteres ocultos

set ttyfast " envia mais caracteres ao terminal, melhorando o redraw de janelas

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

"set tagrelative
set tags+=.git/tags;tags

set tabline=%!MyTabLine()

" }}}

" Status Line {{{

" mostrar o titulo do arquivo
set statusline+=%1*%f
set statusline+=%2*%m
set statusline+=%1*
set statusline+=%=
set statusline+=%-10y
set statusline+=%3*%9{(&fenc!=''?&fenc:&enc)}\[%{&ff}]
set statusline+=%5p%%
set statusline+=%=
set statusline+=%5l
set statusline+=/
set statusline+=%-4L
highlight User1 ctermfg=white ctermbg=darkblue
highlight User2 ctermfg=white ctermbg=red
highlight User3 ctermfg=white ctermbg=blue
highlight NonText guifg=red
highlight SpecialKey guifg=red
highlight ModeMsg ctermfg=black ctermbg=gray

" }}}

" Vimscript file settings {{{

if has("autocmd")

    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.md,*.css :call <SID>StripTrailingWhitespaces()
    autocmd BufNewFile,BufRead *.yml setlocal filetype=yaml
    autocmd FileType yaml setlocal sw=2 ts=2 sts=2
    autocmd FileType css setlocal sw=2 ts=2 sts=2
    autocmd FileType javascript setlocal sw=4 ts=4 sts=4
    autocmd FileType json setlocal sw=4 ts=4 sts=4

    augroup filetype_html
      autocmd!
      autocmd BufNewFile,BufRead *.twig,*.blade.php setlocal filetype=html
      autocmd FileType html,twig,blade.php setlocal sw=2 ts=2 sts=2
    augroup END

    augroup filetype_vim
      autocmd!
      autocmd FileType vim setlocal foldmethod=marker
    augroup END

    augroup filetype_php
      autocmd!
      autocmd FileType php nnoremap <buffer> <localleader>c I#<esc>
      autocmd FileType php setlocal foldmethod=marker foldlevel=1 foldmarker={,}
    augroup END

    " Don't automatically continue comments after newline
    autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

    autocmd Filetype gitcommit setlocal spell textwidth=72

endif

" }}}

" Custom Functions {{{

" tira os espaços em branco à direita no final dos arquivos.
" Isto é chamado na gravação do buffer do grupo acima.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunc

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/.git/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/.git/tags"

  if filereadable(tagfilename)
    let cmd = 'ctags -R -f ' . tagfilename . ' "' . f . '"'
    call DelTagOfFile(f)
    let resp = system(cmd)
  endif
endfunction

autocmd BufWritePost *.php silent! call UpdateTags() &

" cleans up the way the default tabline looks
" will show tab numbers next to the basename of the file
" from :help setting-tabline
function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    let s .= '[' . (i + 1) . ']' " set the tab page number (for viewing)
    let s .= '%' . (i + 1) . 'T' " set the tab page number (for mouse clicks)
    let s .= '%{MyTabLabel(' . (i + 1) . ')} ' " the label is made by MyTabLabel()
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'
  return s
endfunction

" with help from http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line
function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufnr = buflist[winnr - 1]
  let file = bufname(bufnr)
  let buftype = getbufvar(bufnr, 'buftype')

  if buftype == 'nofile'
    if file =~ '\/.'
      let file = substitute(file, '.*\/\ze.', '', '')
    endif
  else
    let file = fnamemodify(file, ':p:t')
  endif
  if file == ''
    let file = '[No Name]'
  endif
  return file
endfunction

" }}}

" Mappings {{{
"
" Desabilitando as setas
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Move up and down by visible lines if current line is wrapped
" nnoremap j gj
nnoremap k gk

"inoremap <esc> <nop>
inoremap jk <esc>

" alterna (exibe/oculta) números
nnoremap <leader>n :set number! relativenumber!<CR>
" alterna (exibe/oculta) caracteres invisiveis
nnoremap <leader>l :set list!<CR>
" alterna (exibe/oculta) destaque da pesquisa
nnoremap <leader>s :set hlsearch!<CR>
" coloca aspas na palavra abaixo do cursor
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
" coloca aspas simples na palavra abaixo do cursor
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

"control + direction to change panes
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

"set autochdir
"nnoremap gf :vertical wincmd f<CR>

noremap <leader>h :read ~/.vim/templates/skeleton.html<CR>

nnoremap ç :

" Shift + direção para mudar de tabs
noremap <S-l> gt
noremap <S-h> gT

vmap <silent> <leader>c :norm i#<ESC>

"executa ctags -R -f .git/tags .
nnoremap <leader>ct :!ctags -Rf .git/tags .<cr><cr>

" }}}
