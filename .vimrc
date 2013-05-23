if &t_Co > 1
    syntax enable
endif

" エンコード指定
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8

" ファイル形式の検出を無効にする
filetype off

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
    autocmd!
    autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
    autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

"全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

"タブ幅を設定"
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set cindent

"行番号を表示
"set number

set laststatus=2 " 常にステータスラインを表示
"カーソルが何行目の何列目に置かれているかを表示する
set ruler

" Pythonの設定
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

" Execute python script C-P
function! s:ExecPy()
    exe "!" . &ft . " %"
endfunction
command! Exec call <SID>ExecPy()
autocmd FileType python map <silent> <C-P> :call <SID>ExecPy()<CR>
autocmd FileType python let g:pydiction_location = '~/.vim/pydiction/complete-dict'

let g:neocomplcache_enable_at_startup = 1

" Comment or uncomment lines from mark a to mark b.
function! CommentMark(docomment, a, b)
    if !exists('b:comment')
        let b:comment = CommentStr() . ' '
    endif
    if a:docomment
        exe "normal! '" . a:a . "_\<C-V>'" . a:b . 'I' . b:comment
    else
        exe "'".a:a.",'".a:b . 's/^\(\s*\)' . escape(b:comment,'/') . '/\1/e'
    endif
endfunction

" Comment lines in marks set by g@ operator.
function! DoCommentOp(type)
    call CommentMark(1, '[', ']')
endfunction

" Uncomment lines in marks set by g@ operator.
function! UnCommentOp(type)
    call CommentMark(0, '[', ']')
endfunction

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

let g:proj_flags = "imstc"
nmap <silent> <Leader>P <Plug>ToggleProject
nmap <silent> <Leader>p :Project<CR>


"PHP"
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l

" vi との互換性OFF
set nocompatible

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
            \ 'php' : $HOME . '/.vim/dict/php.dict',
            \ 'ctp' : $HOME . '/.vim/dict/php.dict',
            \ 'perl' : $HOME . '/.vim/dict/perl.dict'
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

"<C-e>でNERDTreeをオンオフ。いつでもどこでも。
" map <silent> <C-e>   :NERDTreeToggle<CR>
" lmap <silent> <C-e>  :NERDTreeToggle<CR>
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

"引数なしでvimを開いたらNERDTreeを起動、
"引数ありならNERDTreeは起動しない、引数で渡されたファイルを開く。
"How can I open a NERDTree automatically when vim starts up if no files were specified?
"autocmd vimenter * if !argc() | NERDTree | endif

"カラースキーマを設定
colorscheme jellybeans

set nocompatible               " be iMproved

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
NeoBundle 'klen/python-mode'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'tpope/vim-rails'
NeoBundle 'hotchpotch/perldoc-vim'
NeoBundle 'vim-scripts/SingleCompile'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'fuenor/vim-statusline'
NeoBundle 'y-uuki/unite-perl-module.vim'
NeoBundle 'y-uuki/perl-local-lib-path.vim'
NeoBundle 'mattn/excitetranslate-vim'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'qtmplsel.vim'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'YankRing.vim'
NeoBundle 'vim-scripts/Trinity'
NeoBundle 'ctags.vim'
NeoBundle 'wesleyche/SrcExpl'
NeoBundle 'taglist.vim'
"NeoBundle 'perl-support.vim'
NeoBundle 'csv.vim'
"NeoBundle 'vim-scripts/errormarker.vim'
"NeoBundle 'https://bitbucket.org/kovisoft/slimv'

" solarized カラースキーム
NeoBundle 'altercation/vim-colors-solarized'
" jellybeans カラースキーム
NeoBundle 'nanotech/jellybeans.vim'
" mustang カラースキーム
NeoBundle 'croaker/mustang-vim'
" wombat カラースキーム
NeoBundle 'jeffreyiacono/vim-colors-wombat'
" jellybeans カラースキーム
NeoBundle 'nanotech/jellybeans.vim'
" lucius カラースキーム
NeoBundle 'vim-scripts/Lucius'
" zenburn カラースキーム
NeoBundle 'vim-scripts/Zenburn'
" mrkn256 カラースキーム
NeoBundle 'mrkn/mrkn256.vim'
" railscasts カラースキーム
NeoBundle 'jpo/vim-railscasts-theme'
" pyte カラースキーム
NeoBundle 'therubymug/vim-pyte'
" molokai カラースキーム
NeoBundle 'tomasr/molokai'
" Uniteでカラースキームを管理
NeoBundle 'ujihisa/unite-colorscheme'

filetype plugin indent on
filetype indent on
syntax on

"vi上から、:NeoBundleInstallで.vimrcのNeoBundleで指定されているリポジトリのプラグインをインストールできる。
"プラグインを削除したい場合は、vimrc上からNeoBundleの記述を消して:NeoBundleCleanでできる。

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
imap <C-k> <C-m>

imap {} {}<LEFT>
imap [] []<LEFT>
imap () ()<LEFT>
imap "" ""<LEFT>
imap '' ''<LEFT>
imap <> <><LEFT>

"Lokaltog/vim-easymotion
" http://blog.remora.cx/2012/08/vim-easymotion.html
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

"ブラウザで開く
nmap gW <Plug>(openbrowser - open)

"テンプレートを開く
let g:qts_templatedir='~/.vim/template'

"CTRL - hjklでウィンドウ移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

"改行時のコメントアウトなし
autocmd FileType * setlocal formatoptions-=ro

" 保存時に行末の空白を除去する
" 保存時にtabを4スペースに変換する
function! s:remove_dust()
    let cursor = getpos(".")
    %s/\s\+$//ge
    %s/\t/    /ge
    call setpos(".", cursor)
    unlet cursor
endfunction
autocmd BufWritePre * call <SID>remove_dust()

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

",yでヤンク履歴
" YankRing.vim
" http:/nanasi.jp/articles/vim/yankring_vim.html
" https:/github.com/yuroyoro/dotfiles/blob/master/.vimrc.plugins_setting
nmap ,y :YRShow<CR>


" クリップボード共有
" http:/vim-users.jp/2010/02/hack126/
set clipboard+=unnamedplus,unnamed


"smartchr
inoremap <expr> = smartchr#loop('=', ' = ', ' == ')
inoremap <expr> , smartchr#loop(',', ', ', ' => ')
inoremap <buffer> <expr> <S-=> smartchr#loop(' + ', '+')
"inoremap <buffer> <expr> - smartchr#loop(' - ', '-')

"noswap
set noswapfile

"他のアプリでコピーした文字をVimで貼付けたい。またはその逆も
set clipboard=unnamed,autoselect

"memolist.vim
map <Leader>mn :MemoNew<CR>
map <Leader>ml :MemoList<CR>
map <Leader>mg :MemoGrep<CR>

"作業履歴の保存
if has('persistent_undo')
    set undodir=~/.vim/undo
    set undofile
endif

" ファイル形式検出、プラグイン、インデントを ON
filetype plugin indent on

" Open and close all the three plugins on the same time
nmap <F8>   :TrinityToggleAll<CR>

" Open and close the srcexpl.vim separately
nmap <F9>   :TrinityToggleSourceExplorer<CR>

" Open and close the taglist.vim separately
nmap <F10>  :TrinityToggleTagList<CR>

" Open and close the NERD_tree.vim separately
nmap <F11>  :TrinityToggleNERDTree<CR>
