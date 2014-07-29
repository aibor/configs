#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

##### PROMPT #####

if [[ ${EUID} == 0 ]]; then
  PROMPTCOLOR='\033[1;31m'
else
  PROMPTCOLOR='\033[1;37m'
fi
if [ -n "$SSH_CLIENT" ];then
  HOST='\[\033[1;33m\]@\[\033[1;32m\]\h'
fi
PROMPT_COMMAND='RET=$?'
RETCOLOR='$(if [ $RET != 0 ]; then echo "\e[1;31m"; else echo "\e[1;36m"; fi)'
PS1="\[$PROMPTCOLOR\]\u$HOST \`if [ \"\w\" != \"~\" ]; then echo -e '\[\e[1;36m\]\w ';fi\`\[$PROMPTCOLOR\]>>\[$RETCOLOR\]>\[\e[0m\] "
PS2='> '
PS3='> '
PS4='+ '

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
                                                        
    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    SCREENTITLEPROGRAM='\[\ek\e\\\]'
    PS1="${SCREENTITLEPROGRAM}${PS1}" 
    ;;
esac

##### TERM #####
[ -n "$TMUX" ] && export TERM=screen-256color
[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
shopt -s histappend
shopt -s checkwinsize
eval $(dircolors -b)
    

##### Alias #####
# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# renaming default command aliases
alias ping='ping -c 5'
alias mkdir='mkdir -p -v'
alias ls='ls --color=auto'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -I'
alias view='vim -R'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias df='df -h'
alias du='du -c -h'
#alias ssh="sshkchk && ssh"
#alias git="sshkchk && git"
alias dmenu_run="dmenu_run -fn -*-terminus-bold-*-*--14-*-*-*-*-*-* -p 'Do:' -nb '#1a1a1a' -nf '#636363' -sb '#4d87c7' -sf '#c3c3c3'"

# new default command aliases
alias ll='ls -lah --color=auto'
alias lt='ls -lahtr --color=auto'
alias du1='du --max-depth=1'
alias openports='netstat -plnt'
alias pgfl='pgrep -fl'

# git aliases
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gdc='git diff --cached'
alias gds='git diff --staged'

# special crap
alias mirrorupdate='sudo reflector --sort rate -l 5 -p http --save /etc/pacman.d/mirrorlist && sudo pacman -Syy'
alias getexternalip='curl ip.aibor.de ; echo'


##### Functions #####
findall() {
  find / -name "*$@*" 2>/dev/null
}

env() {
  exec /usr/bin/env "$@" | grep -v -e ^LESS_TERMCAP_ -e ^LS_COLORS |
  column -t -s = | sed -e s/^/$'\e\[1;33m'/ -e s/\ /\&$'\e\[0;0m'/
}

mergepdf() {
  gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=$1 $@ 
} 

bak() {
  local e=1 i
  (($#)) || return
  for i; do
    [[ ! -r $i ]] && echo "$0: file is unreadable: \`$i'" >&2 && continue
    cp -v -i $i{,.bak}
    e=$?
  done
  return $e
}

sshkchk() {
  local i=0
  while [[ i -lt 3 ]] &&
      [[ SSH_AGENT_PID ]] && 
      [[ SSH_AUTH_SOCK ]] && 
      [[ $(ssh-add -l | grep -c ".ssh/id_rsa (RSA)") -eq 0 ]];
  do
    ssh-add
    i=$(( $i + 1 ))
  done
}

sysup() {
  sudo pacman -Syu
  echo -e "\033[1;34m:: \033[1;37mStarte AUR Aktualisierung...\033[0m"
  if [ $(cower -qub | wc -l) -gt 0 ]; then
    mkdir -p /tmp/build && cd /tmp/build && cower -ud && ls
  else
    echo " Es gibt nichts zu tun"
  fi
}

