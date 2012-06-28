#!/bin/bash

if program_exists bm; then

  cat <<'BASHRC'
function cdbm() {
  if [ -n "$1" ]; then
    cd "`bm $1`";
  else
    bm
  fi
}
BASHRC

fi
