#! /bin/sh
# set editor to emacs, nvim or others
export VISUAL=$(
  for e in ec-nox ec nvim vim emacs nano vi; do
    hash "$e" >/dev/null 2>&1 && echo "$e" && break
  done
)
export EDITOR=${VISUAL}
