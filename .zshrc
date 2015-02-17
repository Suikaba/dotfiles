autoload -U promptinit; promptinit

autoload -U compinit; compinit

bindkey -v

unsetopt promptcr

setopt no_beep
setopt correct
setopt notify
setopt magic_equal_subst

setopt auto_cd

setopt auto_pushd
setopt pushd_ignore_dups

setopt auto_list
setopt auto_menu
setopt list_types
bindkey "^[[Z" reverse-menu-complete

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#
# history
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history
setopt hist_ignore_all_dups
setopt share_history
setopt hist_reduce_blanks

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


function history-all { history -E 1 }

#
# prompt
#
autoload -U colors; colors

local normal_prompt="%{$fg[green]%}[%m%{$reset_color%}%{$fg[cyan]%}@%{$reset_color%}%{$fg[green]%}%n]:[%{$reset_color%}%{$fg[yellow]%}%~%{$reset_color%}%{$fg[green]%}]  <%D %*>%{$reset_color%}"
local error_prompt="%{$fg[red]%}[%m@%n]:[%~]  <%D %*>%{$reset_color%}"
PROMPT="
%(?.$normal_prompt.$error_prompt)
%# "
PROMPT2='>'


# alias
#
alias ls='ls --color=auto'
alias lr='ls -R'
alias ll='ls -l'
alias la='ls -a'
alias ...='cd ../../'
alias ....='cd ../../..'

#
# vcs (todo)
#

