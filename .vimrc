" Author  Ricardo Fontoura

"""""""""""""""""""""""""""
" configurações gerais
"""""""""""""""""""""""""""
syntax enable " habilita syntax

let mapleader=","

set nocompatible " usa VIM padrão, não compatível com VI

filetype plugin indent on " ativa a detecção do arquivo, plugin e recuo

set hlsearch incsearch smartcase " ativa o contraste de cores na busca de palavras e encontra em maiúsculo ou minisculo

set ruler " habilita informções da posição do cursor

set number " habilita numeração das linhas do arquivo

set showcmd " mostra comandos sendo executados

set showmatch " mostra o correspondente de ( { [

set autoindent " copia a indentação da linha corrente para a nova linha

set tabstop=4 " número de colunas para o comando <TAB>

" número de espaços a serem usados para cada etapa de (auto) recuo. Usado para 'Cident', >>, <<, etc.
set shiftwidth=4

" número de espaços que um <TAB> conta para enquanto executa a edição de operações, como inserir um <TAB> ou usando <BS>.
set softtabstop=4

" no modo inserir use o número apropriado de espaços para inserir um <TAB>. Os espaços são usados
" em recuos com os comandos '<' e '<'. E quando autoindent está ativado.
set expandtab

set pastetoggle=<F2> " para a indentação quando colar com o mouse

"colorscheme darkblue " esquema de cores do vim

set background=dark

set backspace=indent,eol,start " mais poder ao backspacing

set nobackup noswapfile " disabilita backup e swapfile

set wildmenu " autocompletar visual para o menu de comando

set laststatus=2 " ativa a barra de status

set list

set listchars=tab:>-,eol:¬,trail:▸

"""""""""""""""""""""""""""""""""""""""""""""""""
" Barra de Status
"""""""""""""""""""""""""""""""""""""""""""""""""
" mostrar o titulo do arquivo
set statusline+=%1*%f
set statusline+=%2*%m
set statusline+=%1*
set statusline+=%=
set statusline+=%-10y
set statusline+=%3*%{(&fenc!=''?&fenc:&enc)}\[%{&ff}]
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
"""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufNewFile,BufRead *.twig set syntax=html

"""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""
" Desabilitando as setas
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

inoremap jj <ESC>
inoremap ( ()<esc>i
