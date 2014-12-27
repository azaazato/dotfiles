" ファイル形式の検出を無効にする
filetype off
" エンコード指定
set encoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,sjis,cp932
"ハイライト検索
set hlsearch

" vi との互換性OFF
set nocompatible

"noswap
set noswapfile

"タブ幅を設定"
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set cindent

"改行時のコメントアウトなし
autocmd FileType * setlocal formatoptions-=ro

"カラースキーマを設定
colorscheme jellybeans

" カレント行ハイライトON
set cursorline
highlight CursolLine ctermbg=Black

" Ruby
autocmd FileType ruby setl autoindent
autocmd FileType ruby setl tabstop=2 expandtab shiftwidth=2 softtabstop=2

" Python
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

let g:neocomplcache_enable_at_startup = 1

" Return string used to comment line for current filetype.
function! CommentStr()
    if &ft == 'cpp' || &ft == 'java' || &ft == 'javascript'
        return '//'
    elseif &ft == 'vim'
        return '"'
    elseif &ft == 'python' || &ft == 'perl' || &ft == 'sh' || &ft == 'R' || &ft == 'ruby' || &ft == 'pyx'
        return '#'
    elseif &ft == 'lisp'
        return ';'
    endif
    return ''
endfunction

nnoremap <Leader>c <Esc>:set opfunc=DoCommentOp<CR>g@
nnoremap <Leader>C <Esc>:set opfunc=UnCommentOp<CR>g@
vnoremap <Leader>c <Esc>:call CommentMark(1,'<','>')<CR>
vnoremap <Leader>C <Esc>:call CommentMark(0,'<','>')<CR>

" 補完ウィンドウの設定
set completeopt=menuone
" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1

" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1

" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1

let g:neocomplcache_enable_camel_case_completion  =  1

" ポップアップメニューで表示される候補の数
let g:neocomplcache_max_list = 20

" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 3

" ディクショナリ定義
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'perl' : $HOME . '/.vim/dict/perl.dict',
            \ 'ruby' : $HOME . '/.vim/dict/ruby.dict'
            \ }

if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

"スニペットを展開する。スニペットが関係しないところでは行末まで削除
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
smap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"

" 前回行われた補完をキャンセルします
inoremap <expr><C-g> neocomplcache#undo_completion()

" 補完候補のなかから、共通する部分を補完します
inoremap <expr><C-l> neocomplcache#complete_common_string()

" 改行で補完ウィンドウを閉じる
"inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"

"tabで補完候補の選択を行う
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"

"<C-h>や<BS>を押したときに確実にポップアップを削除します
inoremap <expr><C-h> neocomplcache#smart_close_popup().”\<C-h>”

" 現在選択している候補を確定します
inoremap <expr><C-y> neocomplcache#close_popup()

"現在選択している候補をキャンセルし、ポップアップを閉じます
inoremap <expr><C-e> neocomplcache#cancel_popup()

""" unite.vim
" 入力モードで開始する
" " let g:unite_enable_start_insert=1
" " バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

set laststatus=2 " 常にステータスラインを表示
set statusline=%f%m%=%l,%c\ %{'['.(&fenc!=''?&fenc:&enc).']\ ['.&fileformat.']'}%{fugitive#statusline()}
" ブランチ名をステータス行に表示
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"set tags=~/.tags

"<C-e>でNERDTreeをオンオフ。いつでもどこでも。
"   map <silent> <C-e>   :NERDTreeToggle<CR>
" lmap <silent> <C-e>  :NERDTreeToggle<CR>
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle/'))
endif
" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'int3/vim-extradite'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'tpope/vim-rails'
NeoBundle 'hotchpotch/perldoc-vim'
NeoBundle 'vim-scripts/SingleCompile'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'fuenor/vim-statusline'
NeoBundle 'y-uuki/unite-perl-module.vim'
NeoBundle 'y-uuki/perl-local-lib-path.vim'
NeoBundle 'mattn/excitetranslate-vim'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'qtmplsel.vim'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'YankRing.vim'
NeoBundle 'ctags.vim'
NeoBundle 'wesleyche/SrcExpl'
NeoBundle 'ack.vim'
NeoBundle 'thinca/vim-scouter'
NeoBundle 'Align'
NeoBundle 'Simple-Javascript-Indenter'
NeoBundle 'syntastic'
NeoBundle 'vim-coffee-script'
NeoBundle 'taglist.vim'
NeoBundle 'csv.vim'

" カラースキーム
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'therubymug/vim-pyte'
NeoBundle 'tomasr/molokai'
NeoBundle 'ujihisa/unite-colorscheme'

filetype plugin indent on
filetype indent on
syntax on

set backspace=indent,eol,start

"perldoc
noremap K :Perldoc<CR>
setlocal iskeyword-=/

"前回閉じたときの場所を記憶
if has("autocmd")
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \   exe "normal! g'\"" |
                \ endif
endif

autocmd FileType perl :map <C-n> <ESC>:!perl -cw %<CR>
autocmd FileType perl :map <C-e> <ESC>:!perl %<CR>
autocmd FileType ruby :map <C-n> <ESC>:!ruby -cW %<CR>
autocmd FileType ruby :map <C-e> <ESC>:!ruby %<CR>

imap <C-c> <C-[>

"Lokaltog/vim-easymotion
" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" 「;」 + 何かにマッピング
let g:EasyMotion_leader_key=";"
" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1
" カラー設定変更
"hi EasyMotionTarget ctermbg=none ctermfg=red
"hi EasyMotionShade  ctermbg=none ctermfg=blue
set lcs=tab:>.,eol:$,trail:_,extends:\
map ,ptv :'<,'>! perltidy

"テンプレートを開く
let g:qts_templatedir='~/.vim/template'

" 保存時に行末の空白を除去する
function! s:remove_dust()
    let cursor = getpos(".")
    %s/\s\+$//ge
    call setpos(".", cursor)
    unlet cursor
endfunction
autocmd BufWritePre * call <SID>remove_dust()

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

",yでヤンク履歴
" YankRing.vim
nmap gW <Plug>(openbrowser - open)
" http:/nanasi.jp/articles/vim/yankring_vim.html
" https:/github.com/yuroyoro/dotfiles/blob/master/.vimrc.plugins_setting
nmap ,y :YRShow<CR>

"他のアプリでコピーした文字をVimで貼付けたい。またはその逆も
set clipboard=unnamed,autoselect
set clipboard+=unnamedplus,unnamed

"smartchr
inoremap <expr> = smartchr#loop('=', ' = ', ' == ')
inoremap <expr> , smartchr#loop(',', ', ', ' => ')
inoremap <buffer> <expr> <S-=> smartchr#loop(' + ', '+')

"作業履歴の保存
if has('persistent_undo')
    set undodir=~/.vim/undo
    set undofile
endif

" Ack
nmap <Space>a :let a=expand("<cword>")<CR>:Ack <C-R>=expand(a)<CR>
nmap <Space>A :Ack
nnoremap <Space>n :cnext<CR>
nnoremap <Space>p :cprevious<CR>

" for Fugitive {{{
nnoremap <Space>gd :<C-u>Gdiff<Enter>
nnoremap <Space>gs :<C-u>Gstatus<Enter>
nnoremap <Space>gl :<C-u>Glog<Enter>
nnoremap <Space>ga :<C-u>Gwrite<Enter>
nnoremap <Space>gc :<C-u>Gcommit<Enter>
nnoremap <Space>gC :<C-u>Git commit --amend<Enter>
nnoremap <Space>gb :<C-u>Gblame<Enter>
" }}}
