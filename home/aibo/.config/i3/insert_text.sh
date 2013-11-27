#!/usr/bin/bash

case "$1" in
  sgh) text="Sehr geehrte Damen und Herren,"
    ;;
  dsm) text="Dear Sir or Madam,"
    ;;
  *) text="$(date) - my name"
    ;;
esac

/usr/bin/xdotool sleep .1 type  - "$text"
/usr/bin/xdotool key "Return"
