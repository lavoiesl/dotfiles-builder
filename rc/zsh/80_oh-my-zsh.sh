#!/bin/bash

oh_my_zsh_dir="${HOME}/.oh-my-zsh"

if [[ -d "${oh_my_zsh_dir}" ]]; then
    echo "ZSH='${oh_my_zsh_dir}'"

    zsh_theme="wedisagree"
    zsh_theme_dir="${oh_my_zsh_dir}/custom/themes"
    dotfiles_zsh_theme_dir="${DOTFILES_DIR}/rc/zsh/oh-my-zsh/themes"
    if [[ -d "${dotfiles_zsh_theme_dir}" ]]; then
        # symlink all included themes
        mkdir -p "${zsh_theme_dir}"
        ln -sf "${dotfiles_zsh_theme_dir}/"*.zsh-theme "${zsh_theme_dir}/"

        # automically selects the first custom theme
        theme=$(find "${dotfiles_zsh_theme_dir}" -name '*.zsh-theme' 2>/dev/null | head -n1)
        if [[ -n "${theme}" ]]; then
            zsh_theme="$(basename -s .zsh-theme "${theme}")"
        fi
    fi
    echo "ZSH_THEME='${zsh_theme}'"

    echo 'COMPLETION_WAITING_DOTS="true"'

    echo 'plugins=('
                                       echo "    battery"
                                       echo "    history"
        program_exists op           && echo "    1password"
        program_exists bower        && echo "    bower"
        program_exists brew         && echo "    brew"
        program_exists brew-cask.rb && echo "    brew-cask"
        program_exists composer     && echo "    composer"
        program_exists docker       && echo "    docker"
        program_exists fzf          && echo "    fzf"
        program_exists gem          && echo "    gem"
        program_exists git          && echo "    git"
        program_exists kubectl      && echo "    kubectl"
        program_exists npm          && echo "    npm"
        program_exists php          && echo "    symfony2"
        program_exists python       && echo "    python"
        program_exists ssh-agent    && echo "    ssh-agent"
        program_exists svn          && echo "    svn"
        program_exists tmux         && echo "    tmux"
        program_exists vagrant      && echo "    vagrant"
        [[ -d "${oh_my_zsh_dir}/custom/plugins/zsh-fzf-history-search" ]] && echo "    zsh-fzf-history-search"
    echo ')'

    echo 'zstyle :omz:plugins:ssh-agent agent-forwarding on'
    echo 'source "${ZSH}/oh-my-zsh.sh"'
fi

