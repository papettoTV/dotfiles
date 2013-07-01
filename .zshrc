autoload -U compinit
compinit

#http://news.mynavi.jp/column/zsh/004/index.html
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

export CLICOLOR=1
export LSCORLORS=gxfxcxdxbxegedabagacad

#for grep multibyte string
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

#alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
#alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vi=mvim
alias vim=mvim

PROMPT="%/%% "
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "

PATH=/opt/local/bin:$PATH
PATH=/Users/yokotaeiji/Documents/PJ/swirl.jp/src/cake_pet/cake/console:$PATH

alias sdev='ssh swirldev@testdeco.swirl.jp'
alias sswirl='ssh swirl@swirl.jp -p 8022'
alias sdeco='ssh swirl@49.212.32.104 -p 8022'
alias sktv='ssh swirl@49.212.125.216'
alias slivedjs='ssh -i ~/.ssh/aws_ssh_key.pem root@ec2-54-248-2-237.ap-northeast-1.compute.amazonaws.com'

alias fgrep='find . -name "*.*" | xargs grep -l'

alias gitx='/Applications/GitX.app/Contents/MacOS/GitX'
 

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
alias tidev="echo 0 > Resources/env.txt;ti build -T device --platform iphone -V 'Eiji Yokota' -P 657A7DF7-E45A-457C-9EE9-9F3939619178"
alias tiarc="echo 1 > Resources/env.txt;ti build -T device --platform iphone -V 'Eiji Yokota' -P 657A7DF7-E45A-457C-9EE9-9F3939619178"
