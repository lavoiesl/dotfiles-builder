#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo '# http://blog.lavoie.sl/2012/10/git-tutorial-and-global-configs.html'
echo

print_section() {
    local section_dir="${1}"
    local section="${2}"
    local section_content=""

    for config_file in $(find "${section_dir}" -type f -depth 1 -not -name README); do
        if echo "${config_file}" | grep -q '\.sh$'; then
            local content="$(. "${config_file}")"
            local config="$(basename -s .sh "${config_file}")"
        else
            local content="$(cat "${config_file}")"
            local config="$(basename "${config_file}")"
        fi

        if [[ -n "${content}" ]]; then
            # Escape backslashes and double-quotes
            content=$(echo "${content}" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g')
            section_content="${section_content}\t${config} = \"${content}\"\n"
        fi
    done

    if [[ -n "${section_content}" ]]; then
        [ -f "${section_dir}/README" ] && cat "${section_dir}/README" | sed 's/^/# /'
        echo -e "[${section}]"
        echo -e "${section_content}"
    fi
}

for section_dir in $(find "${DIR}" -type d -depth 1); do
    section="$(basename "${section_dir}")"
    print_section "${section_dir}" "${section}"

    for subsection_dir in $(find "${section_dir}" -type d -depth 1); do
        subsection="${section} \"$(basename -s .d "${subsection_dir}")\""
        print_section "${subsection_dir}" "${subsection}"
    done
done
