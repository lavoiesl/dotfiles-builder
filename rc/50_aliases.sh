#!/bin/bash

alias_dir="$DOTFILES_DIR/aliases"

if [ -d "$alias_dir" ]; then
  cd $alias_dir
  
  for alias in $(ls -1 *.sh); do
    content="$(. ./$alias)"
    alias_name=$(basename -s .sh $alias)

    if [[ -n "$content" ]]; then
        content="$(escape_chars "${content}" '\' '"' '$')"
        echo alias $alias_name=\"$content\"
    fi
  done
fi
