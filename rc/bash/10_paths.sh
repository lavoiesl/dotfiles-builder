#!/bin/bash

paths="$("${SKELETON_DIR}/rc/common/paths.sh" | tr \"\\n\" ':' | sed s/:$//)"

echo "export PATH='$paths'"
