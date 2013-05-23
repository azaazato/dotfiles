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
RPROMPT='%{[33m%}[%~]%{[m%}'

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


#. /usr/local/etc/profile.d/z.sh
_Z_CMD=j
. /usr/local/Cellar/z/1.5/etc/profile.d/z.sh
precmd() {
	  _z --add "$(pwd -P)"
}
