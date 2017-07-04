#!/bin/bash

if mac_app_exists "com.googlecode.iterm2" && [ -e "${DOTFILES_INSTALL_PATH}/.iterm2_shell_integration.zsh" ]; then
    echo 'source "'"${DOTFILES_INSTALL_PATH}"'/.iterm2_shell_integration.zsh"'
fi
