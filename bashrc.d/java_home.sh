#!/bin/bash

function java_version() {
  java_exe="$1"
  if [[ -n "$java_exe" ]]; then
    $java_exe -version 2>&1 | grep 'java version' | grep -oE '[0-9\._]+' | head -n1
  fi
}

if program_exists java; then
  required_version=$(java_version java)

  if [[ -n "$required_version" ]]; then

    # Find all java binaries, but exclude common path for binaries
    for java_exe in $(locate bin/java | grep java$ | grep -vE '^(/usr(/local)?)?/bin'); do

      # check that version is the same as java in PATH
      version=$(java_version "$java_exe")
      if [ -n "$version" -a "$version" = "$required_version" ]; then
        echo "export JAVA_HOME='$(dirname $(dirname $java_exe))'"
        break
      fi
    done
  fi
fi
