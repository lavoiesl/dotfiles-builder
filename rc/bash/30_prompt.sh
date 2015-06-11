#!/bin/bash

if program_exists tput && tput setaf 1 >/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  echo_export_single_quote 'CLICOLOR' '1'
  echo_export_single_quote 'LSCOLORS' 'exfxcxdxbxegedabagacad'

  if [ -f "$HOME/.zer0prompt.sh" ]; then
    echo ". $HOME/.zer0prompt.sh"
    echo "zer0prompt"
  else
    echo_export_single_quote 'PS1' '\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '
  fi
else
  echo_export_single_quote 'PS1' '\u@\h:\w\\$ '
fi
