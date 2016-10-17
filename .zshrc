autoload -U compinit
compinit

#http://news.mynavi.jp/column/zsh/004/index.html
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

# ディレクトリ名を入力するだけで移動
setopt auto_cd

# コマンド訂正
setopt correct

#ls color
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS=gxfxcxdxbxegedabagacad
# error on macbook
#eval $(gdircolors ~/.dotfiles/lscolor/dircolors-solarized/dircolors.ansi-universal)
autoload -U compinit
compinit

#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

#for grep multibyte string
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

# alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
# alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vi=mvim
alias vim=mvim
#alias vi='open -a MacVim "$@"'
alias vi='gvim "$@"'
# ファイルがない場合でも、vi開ける様http://qiita.com/b4b4r07/items/9013e19ba47fd07e87b5
function gvim() {
    if [ $# -eq 0 ]; then
        open -a MacVim
    elif [ $# -eq 1 ]; then
        if [ ! -f "$1" ]; then
            touch "$1" || return 1
        fi
        touch -t $( date -v+1S +'%Y%m%d%H%M' ) ~/.compare
        open -a MacVim "$1" && {
            sleep 0.2
            if [ ~/.compare -ot "$1" ]; then
                [ ! -s "$1" ] && rm "$1"
            fi
            rm ~/.compare
        }
    else
        echo "$@: invalid arguments"
        return 1
    fi
    return 0
}

PROMPT="%/%% "
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "

PATH=/opt/local/bin:$PATH
PATH=/Users/yokotaeiji/Documents/PJ/swirl.jp/src/cake_pet/cake/console:$PATH
PATH=/Users/yokotaeiji/bin:$PATH

alias sdev='ssh -i ~/.ssh/sakura_rsa swirldev@testdeco.swirl.jp'
alias sardev='ssh -i ~/.ssh/sakura_rsa swirl@49.212.125.216'
alias sswirl='ssh swirl.jp'
alias sdeco='ssh swirl@49.212.32.104 -p 8022'
alias sktv='ssh swirl@49.212.125.216'
alias slivedjs='ssh -i ~/.ssh/livedjs.pem root@ec2-54-248-189-104.ap-northeast-1.compute.amazonaws.com'
alias splay='ssh -i .ssh/sakura_rsa yokota@playispeace.com'

alias fgrep='find . -iname "*.*" -print0 | xargs -0 grep -i -l'
# function o() {
alias o='op' # なぜかo単体だと前の設定が残ったので間接的にalias挟んで解決
# ファイルがない場合にエラーが出るので、ファイルを作ってからオープン
# 本当は、一時的に開いて、保存しなければ空ファイルが残らないようにしたい
function op() {
 if [ ! -e "$1" ]; then
	touch $1
fi
open "$1"
}

alias gitx='/Applications/GitX.app/Contents/MacOS/GitX'
alias gith='git push heroku master && heroku logs --tail'
 

#export XMODIFIERS='@im=kinput2'
export VIM=/Applications/MacVim.app/Contents/Resources/vim
export VIMRUNTIME=/Applications/MacVim.app/Contents/Resources/vim/runtime
TERM=xterm


#mac vim
alias mvi="mvim --remote-tab-silent"
#function mvi() {
#if [ $# != 0 ]; then
#	mvim --remote-tab-silent $@ 2> /dev/null
#else
#	srvs=`mvim --serverlist 2> /dev/null`
#	if [ "$srvs" != "" ]; then
#		mvim --remote-send ":tabnew<CR>"
#	else
#		mvim
#	fi
#fi
#}

#titanium petap build
alias tisim="/Users/yokotaeiji/Documents/Titanium_Studio_Workspace/build_dev.sh"
alias ticl="ti clean"
alias tidev="ti build -T device --platform iphone -V 'Eiji Yokota (57SKK354UL)' -P DCAB8E3A-DF86-48C6-B5C5-F3113FC147FE"
alias tistg="ti build -T device --platform iphone -V 'Eiji Yokota (57SKK354UL)' -P DCAB8E3A-DF86-48C6-B5C5-F3113FC147FE"
alias tiarc="ti build -T dist-appstore -p ios --distribution-name 'Swirl Communications Co.,Ltd. (G5RKM3QJSH)' -P 8F2B4466-A614-46CD-860A-7653478C55DD"



# git settings
autoload -Uz vcs_info
precmd() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
}
PROMPT=$'%2F%n@%m%f %3F%~%f%1v%# '

# cd = cd & ls 
function chpwd() { ls; echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"}

# ビープ音を鳴らさないようにする
setopt NO_beep

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### add apache ant
export ANT_HOME="/usr/bin/apache-ant-1.9.5"
export PATH="$ANT_HOME/bin:$PATH"

# heroku shortcut
alias hdeploy="git push heroku master"
