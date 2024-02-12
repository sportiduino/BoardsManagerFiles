#!/bin/bash

set -e

if [ $# -lt 3 ]; then
  echo "Usage: $0 <dfu_util> <dummy_port> <binfile>" >&2
  exit 1
fi

dfu_util="$1"
dummy_port_fullpath="/dev/$2"
binfile="$3"

# Get the directory where the script is running.
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [ -e "${dummy_port_fullpath}" ]; then
  echo "Reset device to bootloader" >&2
  "${DIR}/reset_to_bootloader.py" "${dummy_port_fullpath}"
  sleep 2
else
  echo "${dummy_port_fullpath} doesn't exists" >&2
  echo "Trying upload firmware without reset" >&2
fi

"${dfu_util}" -D "${binfile}"

#COUNTER=3
#while
#  "dfu-util" -D "${binfile}" -R
#  ((ret = $?))
#do
#  if [ $ret -eq 74 ] && [ $((--COUNTER)) -gt 0 ]; then
#    # I/O error, probably because no DFU device was found
#    echo "Trying ${COUNTER} more time(s)" >&2
#    sleep 1
#  else
#    exit $ret
#  fi
#done

