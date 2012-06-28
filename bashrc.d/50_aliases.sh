#!/bin/bash

alias_dir="$SKELETON_DIR/alias.d"

if [ -d "$alias_dir" ]; then
  cd $alias_dir
  
  for alias in $(ls -1 *); do
    # Escape backslashes and double-quotes
    content=$(cat $alias | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\$/\\\$/g')
    echo alias $alias=\"$content\"
  done
fi
