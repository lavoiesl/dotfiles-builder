#!/bin/bash

if [[ -d "${DOTFILES_INSTALL_PATH}/.oh-my-zsh" ]]; then
    echo "ZSH='${DOTFILES_INSTALL_PATH}/.oh-my-zsh'"

    zsh_theme="wedisagree"
    if [[ -d "${DOTFILES_DIR}/rc/zsh/oh-my-zsh/themes" ]]; then
        # symlink all included themes
        [[ -d "${DOTFILES_INSTALL_PATH}/.oh-my-zsh/custom/themes" ]] || mkdir "${DOTFILES_INSTALL_PATH}/.oh-my-zsh/custom/themes"
        ln -sf "${DOTFILES_DIR}/rc/zsh/oh-my-zsh/themes/"*.zsh-theme "${DOTFILES_INSTALL_PATH}/.oh-my-zsh/custom/themes/"

        # automically selects the first custom theme
        theme=$(find "${DOTFILES_DIR}/rc/zsh/oh-my-zsh/themes" -name '*.zsh-theme' 2>/dev/null | head -n1)
        if [[ -n "${theme}" ]]; then
            zsh_theme="$(basename -s .zsh-theme "${theme}")"
        fi
    fi
    echo "ZSH_THEME='${zsh_theme}'"

    echo 'COMPLETION_WAITING_DOTS="true"'

    echo 'plugins=('
                                       echo "    battery"
                                       echo "    history"
        program_exists bower        && echo "    bower"
        program_exists brew         && echo "    brew"
        program_exists brew-cask.rb && echo "    brew-cask"
        program_exists composer     && echo "    composer"
        program_exists docker       && echo "    docker"
        program_exists gem          && echo "    gem"
        program_exists git          && echo "    git"
        program_exists npm          && echo "    npm"
        program_exists php          && echo "    symfony2"
        program_exists python       && echo "    python"
        program_exists ssh-agent    && echo "    ssh-agent"
        program_exists svn          && echo "    svn"
        program_exists tmux         && echo "    tmux"
        program_exists vagrant      && echo "    vagrant"
    echo ')'

    echo 'zstyle :omz:plugins:ssh-agent agent-forwarding on'
    echo 'source "${ZSH}/oh-my-zsh.sh"'
fi

