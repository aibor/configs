#!/bin/bash

i3status | (read line && echo $line && read line && echo $line && while read line
do 
  playing="{\"name\":\"mpd\",\"full_text\":\" $(mpc current) \"},"
  if grep -q 'random: on' <(mpc)
  then
    line=${line/[/[{\"name\":\"mpd_rnd\",\"color\":\"\#aaaaaa\",\"full_text\":\" RND \"\},}
  fi
  echo "${line/[/[$playing}" || exit 1
done)
