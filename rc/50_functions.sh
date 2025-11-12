#!/bin/bash

function_dir="${DOTFILES_DIR}/functions"

if [ -d "${function_dir}" ]; then
  cd "${function_dir}"
  
  for function in *; do
    [[ -f "${function}" ]] || continue

    content="$(cat_or_exec "./${function}")"
    function_name="$(basename -s .sh "${function}")"

    [[ -n "$content" ]] || continue

    cat <<EOF
$function_name() {
$(echo "${content}" | sed 's/^/  /')
}

EOF
  done
fi
