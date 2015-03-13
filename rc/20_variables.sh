#!/bin/bash

var_dir="${DOTFILES_DIR}/variables"
config_dir="${DOTFILES_CONFIG_DIR}/vars"

if [[ -d "${config_dir}" ]]; then
    for file in "${config_dir}"/*; do
        var_name="$(basename "${file}")"
        content="$(get_config_var "${var_name}")"
        if [[ -n "${content}" ]]; then
            conf_var="_DOTFILES_VAR_${var_name}"
            declare "${conf_var}=${content}"
        fi
    done
fi

if [ -d "${var_dir}" ]; then
    cd "${var_dir}"
    
    for file in $(ls -1 ./*.sh); do
        var_name="$(basename -s .sh "${file}")"
        conf_var="_DOTFILES_VAR_${var_name}"

        if [[ -n "${!conf_var}" ]]; then
            content="$(. "${file}")"

            if [[ -n "${content}" ]]; then
                declare "${conf_var}=${content}"
            fi
        fi
    done


    for folder in $(ls -1d ./*.d); do
        var_name="$(basename -s .d "${folder}")"
        conf_var="_DOTFILES_VAR_${var_name}"

        if [[ -n "${!conf_var}" ]]; then
            for file in $(ls -1 $folder/*.sh); do
                content="$(. "${file}")"

                if [[ -n "${content}" ]]; then
                    declare "${conf_var}=${content}"
                    break
                fi
            done
        fi
    done
fi

( set -o posix ; set ) | grep '^_DOTFILES_VAR_' | sed 's/^_DOTFILES_VAR_//'
