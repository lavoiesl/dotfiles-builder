#!/bin/bash

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

echo="HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoreboth"
