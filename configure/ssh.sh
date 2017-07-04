#!/bin/bash

if [[ -f "${DOTFILES_INSTALL_PATH}/.ssh/config" ]]; then
    config_dir="${DOTFILES_CONFIG_DIR}/ssh/config"
    [ -d "${config_dir}/hosts" ] || mkdir -p "${config_dir}/hosts"

    host=""

    while read line; do
        # trim leading spaces
        line="$(echo "${line}" | sed 's/^ +//')"

        if echo "${line}" | grep -qE '^(#|$)'; then
            # skip empty and commented
            continue
        elif echo "${line}" | grep -qE '^Host\s'; then
            host="$(echo "${line}" | sed -E 's/^Host +//')"
            echo > "${config_dir}/hosts/${host}"
            echo "${line}" >> "${config_dir}/hosts/${host}"
        else
            if [[ -n "${host}" ]]; then
                # per-host configs will be indented
                echo "  ${line}" >> "${config_dir}/hosts/${host}"
            else
                # global configs will have their own file
                config_name="$(echo "${line}" | grep -oE '^ *[A-Z][a-zA-Z]+ *' | head -n1 | sed 's/[^a-zA-Z]//')"
                if [[ -z "${config_name}" ]]; then
                    echo "Error: unable to parse line of ${DOTFILES_INSTALL_PATH}/.ssh/config: ${line}" >&2
                    exit
                fi

                echo "${line}" > "${config_dir}/${config_name}"
            fi
        fi
    done < "${DOTFILES_INSTALL_PATH}/.ssh/config"
fi

config_dir="${DOTFILES_CONFIG_DIR}/ssh/authorized_keys"
function ssh_add_authorized_keys() {
    local line="${1}"

    local ssh_type="$(echo "${line}" | awk '{ print $1 }')"
    local key="$(echo "${line}" | awk '{ print $2 }')"
    local comment="$(echo "${line}" | awk '{ print $3 }')"

    # skip if key already exists
    grep -qRF "${key}" "${config_dir}" && return

    while [[ -z "${comment}" ]] || echo "${comment}" | grep -q '[/ ]'; do
        echo "This authorized SSH key does not have a valid comment:"
        echo "${line}"
        comment="$(prompt_value "Please specify one now, without spaces:")"
    done

    echo "${ssh_type} ${key} ${comment}" > "${config_dir}/${comment}"
}

if [[ -f "${DOTFILES_INSTALL_PATH}/.ssh/authorized_keys" ]]; then
    [ -d "${config_dir}" ] || mkdir -p "${config_dir}"

    while read -u 3 line; do
        ssh_add_authorized_keys "${line}"
    done 3< <(grep '^ssh-' "${DOTFILES_INSTALL_PATH}/.ssh/authorized_keys")

    # Do not read from ssh-add anymore
    # while read -u 3 line; do
    #     ssh_add_authorized_keys "${line}"
    # done 3< <(ssh-add -L)
fi
