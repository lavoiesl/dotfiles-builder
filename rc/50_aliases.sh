#!/bin/bash

alias_dir="${DOTFILES_DIR}/aliases"

if [ -d "${alias_dir}" ]; then
  cd "${alias_dir}"
  
  for alias in *; do
    [[ -f "${alias}" ]] || continue

    content="$(cat_or_exec "./${alias}")"
    alias_name="$(basename -s .sh "${alias}")"

    [[ -n "$content" ]] || continue

    content="$(escape_chars "${content}" '\' '"' '$')"
    echo alias $alias_name=\"$content\"
  done
fi
