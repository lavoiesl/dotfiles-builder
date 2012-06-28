#!/bin/bash

paths_dir="$SKELETON_DIR/path.d"
paths="$PATH"

if [ -d "$paths_dir" ]; then
  cd $paths_dir
  
  for path in $(ls -1 *); do
    # evaluate variables now
    dir=$(eval "echo $(cat $path)")
    if [ -d $dir -a -z "$(echo $PATH | grep $dir)" ] ; then
      paths="$paths:$dir"
    fi
  done
fi

echo "export PATH='$paths'"
