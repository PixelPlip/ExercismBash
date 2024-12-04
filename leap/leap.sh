#!/usr/bin/env bash

if ! [[ "$1" =~ ^[0-9]+$ && "$#" -eq 1 ]]; then
  echo "Usage: leap.sh <year>"
  exit 1
fi

if ((("$1" % 4 == 0 && "$1" % 100 != 0) || "$1" % 400 == 0)); then
  echo "true";
else
  echo "false"
fi