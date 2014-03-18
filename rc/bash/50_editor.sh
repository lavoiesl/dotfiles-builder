#!/bin/bash

editor_dir="$SKELETON_DIR/editor.d"

if [ -d "$editor_dir" ]; then
  cd $editor_dir
  
  for editor in $(ls -1 *); do
    # Escape backslashes and double-quotes
    content=$(. $editor | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\$/\\\$/g')
    if [[ -n "$content" ]]; then
      echo "export EDITOR=\"$content\""
      echo "export VISUAL=\"$content\""
      break
    fi
  done
fi
