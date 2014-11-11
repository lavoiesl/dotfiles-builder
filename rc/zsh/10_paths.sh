#!/bin/bash

echo "path=("
    . "${SKELETON_DIR}/rc/common/paths.sh" | sed -e 's/^/    "/' -e 's/$/"/'
echo ")"
