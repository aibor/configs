#!/bin/bash
#
# connect to or launch ssh agent instance
# connect to ssh-agent if it's running
if PID=$(pgrep ssh-agent); then
  export SSH_AUTH_SOCK=$(find /tmp/ssh* -name "agent*")
  export SSH_AGENT_PID=$PID
fi
