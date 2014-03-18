#!/bin/bash

paths_dir="$SKELETON_DIR/paths"
paths="$PATH"

if [ -d "$paths_dir" ]; then
  cd $paths_dir
  
  for path in $(ls -1 *); do
    dir=$(. "$path")
    # Test if output, dir exists and not already in path
    if [ -n "$dir" -a -d "$dir" -a -z "$(echo $paths | grep -oE '[^:]+' | grep "^$dir$")" ]; then
      paths="$dir:$paths"
    fi
  done
fi

echo "path=("
# See http://stackoverflow.com/questions/11532157/unix-removing-duplicate-lines-without-sorting
echo $paths | grep -oE '[^:]+' | awk ' !x[$0]++'
echo ")"
