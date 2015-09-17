#!/bin/bash -x
TOPRINT="${1}"
# will show as stdin
ssh ealfonso@unix.andrew.cmu.edu /usr/bin/lp - < "${TOPRINT}"
