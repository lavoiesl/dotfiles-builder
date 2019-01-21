#!/bin/bash

kube_config_path="${DOTFILES_INSTALL_PATH}/.kube"

if [[ -d "${kube_config_path}" ]]; then
    configs=$(find "${kube_config_path}" -type f -maxdepth 1 -name 'config*' | tr "\n" :)
    if [[ -n "${configs}" ]]; then
        echo "${KUBECONFIG:+$KUBECONFIG:}${configs}" | tr : "\n" | grep . | sort | uniq | tr "\n" ":" | sed 's/:$//'
    fi
fi
