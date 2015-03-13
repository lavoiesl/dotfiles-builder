#!/bin/bash

. "${DOTFILES_DIR}/dotfiles/.bashrc/common.sh"

program_exists zsh && rc_dump zsh
