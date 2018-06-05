# Set shell options
setopt always_last_prompt
setopt auto_list
setopt auto_menu
setopt auto_cd
setopt auto_name_dirs
setopt auto_remove_slash
setopt auto_param_keys
setopt auto_pushd
setopt bg_nice
setopt cdable_vars
setopt correct_all
setopt extended_glob
setopt extended_history
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt ignore_eof
setopt list_types
setopt no_beep
setopt NO_HUP
setopt multios
setopt numeric_glob_sort
setopt prompt_subst
setopt pushd_ignore_dups
setopt pushd_silent
setopt rm_star_silent
setopt sh_word_split
setopt sun_keyboard_hack
setopt noclobber
setopt nonomatch
# watch=(all)

# correct prompt
SPROMPT="correct '%R' to '%r' [nyae]? "

# use color
autoload colors
autoload -U compinit
compinit

# lib

 LD_LIBRARY_PATH='/usr/local/lib:/usr/lib:/usr/local/bin'

# command alias
alias la='ls -a'
alias lal='ls -al'
alias ll='ls -l'
alias ls='ls -cF'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# application alias
alias ps2pdf='ps2pdf -sPAPERSIZE=a4'
alias em='/Applications/Emacs.app/Contents/MacOS/Emacs'
alias vi='vim'

# ¿§¤Ä¤­¤ÎÊä´°
zstyle ':completion:*' list-colors 'di=36' 'ex=31' 'ln=35'

# Êä´°¸õÊä¤ò¥«¡¼¥½¥ë¤ÇÁªÂò¤Ç¤­¤ë
zstyle ':completion:*:default' menu select=1

# For XDVI (at least)
#export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/usr/local/bin
#export VFONTCAP=/usr/local/lib/vfont/vfontcap


# C-w: delete until previous "/"
export WORDCHARS='*?_.[];!#$%^{}<>'

# PROMPT
PROMPT='%U%B`whoami`%b%{[31m%}@%{[m%}%B%m%b%u${WINDOW:+"%{^[[32m%}[$WINDOW]%{^[[m%}"} '
#RPROMPT='%{[33m%}[%~]%{[m%}'
RPROMPT="%(?..%F{red}-%?-)%F{green}[%1(v|%F{yellow}%1v%F{green} |):%~]%f"

# PROMPT
export CC=gcc

#export GNUTERM=aqua
export GNUTERM=x11

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt share_history        # share command history data

#bindkey -v

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'

export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

setopt hist_ignore_all_dups

function peco_select_history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco_select_history
bindkey '^r' peco_select_history

alias -g B='`git branch | peco | sed -e "s/^\*[ ]*//g"`'

p() { peco | while read LINE; do $@ $LINE; done }
alias gp='ghq list -p | p cd'

export PATH=$PATH:/usr/local/src/spark/bin
export PATH=$PATH:/Users/suzukishota/bin

export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# aws cli local mode
alias laws='aws --endpoint-url http://localhost:8080'

# git
alias g='git'
alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
alias -g R='`git remote | peco --prompt "GIT REMOTE>" | head -n 1`'
# alias -g LR='`git branch -a | peco --query "remotes/ " --prompt "GIT REMOTE BRANCH>" | head -n 1 | sed "s/^\*\s*//" | sed "s/remotes\/[^\/]*\/\(\S*\)/\1 \0/"`'
alias -g LR='`git branch -a | peco --query "remotes/ " --prompt "GIT REMOTE BRANCH>" | head -n 1 | sed "s/^\*\s*//" | sed "s/remotes\/[^\/]*\/\(\S*\)/\1 /"`'

# rbenv
# eval "$(rbenv init -)"

bindkey "^@" kill-line

# docker
#alias docker='docker --tlsverify=false'

alias dps='docker ps --format "{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Command}}\t{{.RunningFor}}"'
alias dpsa='docker ps -a --format "{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Command}}\t{{.RunningFor}}"'
alias dexec='docker exec -it `dps| peco | cut -f 1` /bin/bash'
alias dkill='docker kill `dps| peco | cut -f 1`'
alias drm='docker rm `dpsa| peco | cut -f 1`'

# ctags
alias ctags="`brew --prefix`/bin/ctags"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

alias vim='nvim'

ssh-add -A 2> /dev/null

alias git="nocorrect git"

#git¥Ö¥é¥ó¥ÁÌ¾É½¼¨
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%c%u%b'
zstyle ':vcs_info:git:*' actionformats '%c%u%b|%a'

#¥«¥ì¥ó¥È¥Ç¥£¥ì¥¯¥È¥ê/¥³¥Þ¥ó¥Éµ­Ï¿
local _cmd=''
local _lastdir=''
preexec() {
  _cmd="$1"
  _lastdir="$PWD"
}
#git¾ðÊó¹¹¿·
update_vcs_info() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
#¥«¥ì¥ó¥È¥Ç¥£¥ì¥¯¥È¥êÊÑ¹¹»þ/git´ØÏ¢¥³¥Þ¥ó¥É¼Â¹Ô»þ¤Ë¾ðÊó¹¹¿·
precmd() {
  _r=$?
  case "${_cmd}" in
    git*|stg*) update_vcs_info ;;
    *) [ "${_lastdir}" != "$PWD" ] && update_vcs_info ;;
  esac
  return $_r
}

eval "$(pyenv virtualenv-init -)"
