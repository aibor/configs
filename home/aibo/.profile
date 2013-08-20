if [[ -z "$DISPLAY" ]] && [[ -z "$SSH_CLIENT" ]] && [[ ! -a "/tmp/.X11-unix/X0" ]] && [[ "`whoami`" != "root" ]]; then
  
  exec ssh-agent startx
  logout

fi
