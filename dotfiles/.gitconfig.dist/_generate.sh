#!/bin/bash

program_exists git || exit

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo '# http://blog.lavoie.sl/2012/10/git-tutorial-and-global-configs.html'
echo

print_section() {
    local section_dir="${1}"
    local section="${2}"
    local section_content=""

    for config_file in $(find "${section_dir}" -mindepth 1 -maxdepth 1 -type f -not -name README); do
        local config="$(basename -s .sh "${config_file}")"
        local content="$(cat_or_exec "${config_file}")"

        if [[ -n "${content}" ]]; then
            content="$(escape_chars "${content}" '\' '"')"
            section_content="${section_content}\t${config} = \"${content}\"\n"
        fi
    done

    if [[ -n "${section_content}" ]]; then
        [ -f "${section_dir}/README" ] && cat "${section_dir}/README" | sed 's/^/# /'
        echo -e "[${section}]"
        echo -e "${section_content}"
    fi
}

for section_dir in $(find "${DIR}" -mindepth 1 -maxdepth 1 -type d); do
    section="$(basename "${section_dir}")"
    print_section "${section_dir}" "${section}"

    for subsection_dir in $(find "${section_dir}" -mindepth 1 -maxdepth 1 -type d); do
        subsection="${section} \"$(basename -s .d "${subsection_dir}")\""
        print_section "${subsection_dir}" "${subsection}"
    done
done
