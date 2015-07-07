"https://github.com/yuroyoro/dotfiles/blob/master/.vimrc 参考
"-------------------------------------------------------------------------------
"" 基本設定 Basics
"-------------------------------------------------------------------------------
"let mapleader = ","              " キーマップリーダー
"set scrolloff=5                  " スクロール時の余白確保
set textwidth=0                  " 一行に長い文章を書いていても自動折り返しをしない
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set noswapfile                   " スワップファイル作らない
set noundofile                   " undoファイル作らない
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                     " ビープをならさない
set browsedir=buffer             " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
"set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
"set modelines=0                  " モードラインは無効

" OSのクリップボードを使用する
set clipboard+=unnamed
" ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2

"ヤンクした文字は、システムのクリップボードに入れる"
set clipboard=unnamed
" 挿入モードでCtrl+kを押すとクリップボードの内容を貼り付けられるようにする "
imap <C-p>  <ESC>"*pa
" 
" 文字コードと改行文字の種別を表示 
" set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" php構文チェック(:make でチェックできる)
autocmd filetype php :set makeprg=php\ -l\ %
autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l

" php構文チェック(保存時に強制チェック)
" au BufWritePost *.php !php -l %

"-------------------------------------------------------------------------------
"" 表示 Apperance
"-------------------------------------------------------------------------------
set nowrap            " 改行しない
set showmatch         " 括弧の対応をハイライト
set number            " 行番号表示
"set list              " 不可視文字表示
"set listchars=tab:>.,trail:_,extends:>,precedes:< " 不可視文字の表示形式
"set display=uhex      " 印字不可能文字を16進数で表示

"" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
"match ZenkakuSpace /　/

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" コマンド実行中は再描画しない
set lazyredraw
" 高速ターミナル接続を行う
set ttyfast
" xやdでyankしない
nnoremap d "_d


" color
set background=light
colorscheme hybrid 

" window size
set columns=150
set lines=48

" statusline を常に表示
set laststatus=2
"-------------------------------------------------------------------------------
"" インデント Indent
"-------------------------------------------------------------------------------
set autoindent   " 自動でインデント
set paste        " ペースト時にautoindentを無効に(onにするとautocomplpop.vimが動かない)
set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set cindent      " Cプログラムファイルの自動インデントを始める

"-------------------------------------------------------------------------------
"" タグ関連 Tags
"-------------------------------------------------------------------------------
"" set tags
if has("autochdir")
	" 編集しているファイルのディレクトリに自動で移動
	set autochdir
	set tags=tags;
else
	set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags
endif
      
"-------------------------------------------------------------------------------
"" 検索設定 Search
"-------------------------------------------------------------------------------
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト
"Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>

"-------------------------------------------------------------------------------
"" 移動設定 Move
"-------------------------------------------------------------------------------

" 0, 9で行頭、行末へ
nmap 9 ^
nmap 0 $

" インサートモードでもhjklで移動（Ctrl押すけどね）
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-h> <Left>
imap <C-l> <Right>




"-------------------------------------------------------------------------------
"" エンコーディング関連 Encoding
"-------------------------------------------------------------------------------
set ffs=unix,dos,mac  " 改行文字
set encoding=utf-8    " デフォルトエンコーディング

" 文字コード関連from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
" 文字コードの自動認識
if &encoding !=# 'utf-8'
	  set encoding=japan
	    set fileencoding=japan
    endif
    if has('iconv')
	    let s:enc_euc = 'euc-jp'
	    let s:enc_jis = 'iso-2022-jp'
	    " iconvがeucJP-msに対応しているかをチェック
	    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# " \xad\xc5\xad\xcb"
		    let s:enc_euc = 'eucjp-ms'
		    let s:enc_jis = 'iso-2022-jp-3'
		    " iconvがJISX0213に対応しているかをチェック
	    elseif iconv("\x87\x64\x87\x6a", 'cp932','euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		    let s:enc_euc = 'euc-jisx0213'
		    let s:enc_jis = 'iso-2022-jp-3'
	    endif
	  " fileencodingsを構築
	  if &encoding ==# 'utf-8'
		  let s:fileencodings_default = &fileencodings
		  let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
		  let &fileencodings = &fileencodings .','. s:fileencodings_default
		  unlet s:fileencodings_default
	  else
		  let &fileencodings = &fileencodings .','. s:enc_jis
		  set fileencodings+=utf-8,ucs-2le,ucs-2
		  if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			  set fileencodings+=cp932
			  set fileencodings-=euc-jp
			  set fileencodings-=euc-jisx0213
			  set fileencodings-=eucjp-ms
			  let &encoding = s:enc_euc
			  let &fileencoding = s:enc_euc
		  else
			  let &fileencodings = &fileencodings .','. s:enc_euc
		  endif
	  endif
	    " 定数を処分
	       unlet s:enc_euc
	         unlet s:enc_jis
	         endif
	         " 日本語を含まない場合は fileencoding に encoding を使うようにする
		 if has('autocmd')
			 function! AU_ReCheck_FENC()
				 if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
					 let &fileencoding=&encoding
				 endif
			 endfunction
			 autocmd BufReadPost * call AU_ReCheck_FENC()
		 endif
		 " 改行コードの自動認識
		 set fileformats=unix,dos,mac
		 " □とか○の文字があってもカーソル位置がずれないようにする
		 if exists('&ambiwidth')
			 set ambiwidth=double
		 endif
               
" 指定文字コードで強制的にファイルを開く
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932


"""""""
"neobundle
"""""""
filetype off 

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim
  call neobundle#begin(expand('~/.vim/.bundle'))
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
"after install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-surround'

" comment out
NeoBundle "tyru/caw.vim.git"
nmap ,c <Plug>(caw:i:toggle)
vmap ,c <Plug>(caw:i:toggle)

"
" markdown
"
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

au BufRead,BufNewFile *.md set filetype=markdown
" let g:previm_open_cmd = 'open -a Firefox'

" for saleforce
NeoBundle 'neowit/vim-force.com'
set nocompatible

if has("unix")
	let &runtimepath=&runtimepath . ',~/vim/force.com'
elseif has("win32")
	let &runtimepath=&runtimepath . ',c:\Documents and Settings\username\vimfiles\force.com'
endif
" make sure vim loads apexcode filetype detection
runtime ftdetect/vim-force.com.vim

let g:apex_backup_folder="/backup"
let g:apex_temp_folder="/tmp"
let g:apex_properties_folder="/Users/yokotaeiji/Documents/pj/force.com/properties"
let g:apex_tooling_force_dot_com_path="/Users/yokotaeiji/.ant/lib/tooling-force.com-0.3.3.3.jar"
let g:apex_workspace_path="/Users/yokotaeiji/Documents/pj/force.com/"
"
" let g:apex_deployment_error_log="/tmp/gvim-deployment-error.log"

"neobundle end
call neobundle#end()

filetype plugin on
filetype indent on


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
    \ 'ctp' : $HOME . '/.vim/dict/php.dict'
    \ }

if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
endif
" 日本語を補完候補として取得しないようにする
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" スニペットを展開する。スニペットが関係しないところでは行末まで削除
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
smap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"

" 前回行われた補完をキャンセルします
inoremap <expr><C-g> neocomplcache#undo_completion()

" 補完候補のなかから、共通する部分を補完します
inoremap <expr><C-l> neocomplcache#complete_common_string()

" 改行で補完ウィンドウを閉じる
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"

"tabで補完候補の選択を行う
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"

" <C-h>や<BS>を押したときに確実にポップアップを削除します
inoremap <expr><C-h> neocomplcache#smart_close_popup().”\<C-h>”

" 現在選択している候補をスペースで確定します
inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" 現在選択している候補をキャンセルし、ポップアップを閉じます
inoremap <expr><C-e> neocomplcache#cancel_popup()

""
" 括弧補完
""
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>


" 保存に失敗して画面が横に伸びる対策
cnoremap W w

augroup PHP
  autocmd!
  autocmd FileType php set makeprg=php\ -l\ %
  " php -lの構文チェックでエラーがなければ「No syntax errors」の一行だけ出力される
  autocmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif
augroup END

" なくてもいいけどあった方がより便利
syntax on

" git branch
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%-14.(%l,%c%V%)\ %P 

" Require <Leader> before gu*/gU* (Change to lowr/upper case)
" （打ち間違えで）勝手に小文字になる問題の対応
noremap gu <Nop>
noremap gU <Nop>
noremap <Leader>gu gu
noremap <Leader>gU gu

" USキーボード用
noremap ; :
noremap : ;
