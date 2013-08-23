#!/bin/bash

i3status | (read line && echo $line && read line && echo $line && while read line
do 
  playing=''
  mpc=$(mpc)
  if grep -q '\[playing\]' <<< "$mpc"
  then
    playing="{\"name\":\"mpd\",\"full_text\":\" "$(head -n1 <<< "$mpc")" \"},"
    if grep -q 'random: on' <<< "$mpc"
    then
      line=${line/[/[{\"name\":\"mpd_rnd\",\"color\":\"\#aaaaaa\",\"full_text\":\" RND \"\},}
    fi
  fi
  echo "${line/[/[$playing}" || exit 1
done)
