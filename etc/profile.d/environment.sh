#!/bin/sh
#
# set my environment variables

## Exports
export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export GREP_COLOR="1;33"
export LESS="-FXRS"
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;38;5;74m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[38;5;246m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[04;38;5;146m'
# ignore this entries in history
export HISTIGNORE="&:cd:pwd:rm:l[ls]:\:[bf]g:exit"
export HISTCONTROL=erasedups:ignorespace
export HISTSIZE=10000
export HISTFILESIZE=""
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export MPD_HOST="2X1otROqGRpK4gSWFZX5Gx53c7TXdCBK@localhost"
