#!/bin/bash

echo_var() {
    var=$1
    content=$(echo "$2" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\$/\\\$/g')
    echo export $var=\"$content\"
}

var_dir="$SKELETON_DIR/variables"

if [ -d "$var_dir" ]; then
    cd $var_dir
    
    for var in $(ls -1 ./*.sh); do
        var_name=$(basename -s .sh $var)
        content=$(. $var)
        if [[ -n "$content" ]]; then
            echo_var $var_name "$content"
        fi
    done


    for var in $(ls -1d ./*.d); do
        var_name=$(basename -s .d $var)

        for var2 in $(ls -1 $var/*.sh); do
            content=$(. $var2)

            if [[ -n "$content" ]]; then
                echo_var $var_name "$content"
                break
            fi
        done
    done
fi
