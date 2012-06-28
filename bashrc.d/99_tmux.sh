#!/bin/bash

if program_exists tmux; then
  echo 'if [ -z "$TMUX" ] && [ "$TERM" = "linux" -o "$TERM" = "rxvt-unicode" -o "$TERM" = "xterm-color" -o "$TERM" = "xterm-256color" -o "$TERM" = "xterm" -o  "$SSH_TTY" = "$(tty)" ]
then
  if ! tmux has-session -t main
  then
    tmux start-server
    tmux new-session -d -s main
  fi
  tmux attach-session -t main

  if [ -f ~/.no-screen ]
  then
    rm ~/.no-screen
  else
    exit
  fi
fi'
fi
