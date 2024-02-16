#!/bin/bash

if program_exists brew; then
  if [[ ! -d "${DOTFILES_INSTALL_PATH}/.oh-my-zsh" ]]; then
    # oh-my-zsh is not installed, so we can't use the brew plugin
    echo 'eval $(brew shellenv)'
  fi
fi
