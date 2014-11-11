#!/bin/bash

editor_dir="$SKELETON_DIR/editor.d"

if [ -d "$editor_dir" ]; then
  cd $editor_dir
  
  for editor in $(ls -1 *); do
    content="$(escape_chars "${editor}" '\' '"' '$')"
    if [[ -n "$content" ]]; then
      echo "export EDITOR=\"$content\""
      echo "export VISUAL=\"$content\""
      break
    fi
  done
fi
