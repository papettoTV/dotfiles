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
autoload -U compinit
compinit

#for grep multibyte string
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

# ssh playispeace server alias
alias splay='ssh -i .ssh/sakura_rsa yokota@playispeace.com'

# custom file name grep
alias fgrep='find . -iname "*.*" -print0 | xargs -0 grep -i -l'

# open alias
alias o='open'

# コマンドプロンプト左側の表示
autoload -Uz vcs_info
precmd() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
}
PROMPT=$'%3F%~%f%1v%# '
# 
SPROMPT="%r is correct? [n,y,a,e]: "

# cd = cd & ls 
function chpwd() { ls; echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"}

# ビープ音を鳴らさないようにする
setopt NO_beep

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# php
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
# laravel
export PATH="$HOME/.composer/vendor/bin:$PATH"

# heroku shortcut
alias hdeploy="git push heroku master"

# curl時の "zsh: no matches found:" 対策
setopt nonomatch

# nodebrew用
export PATH=$HOME/.nodebrew/current/bin:$PATH

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# aws cli version2
alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'

# conda
export PATH=/Users/eijiyokota/miniforge3/bin/:$PATH  
