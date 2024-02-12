#!/bin/bash

set -e

if [ $# -lt 2 ]; then
  echo "Usage: $0 <dummy_port> <binfile>" >&2
  exit 1
fi
dummy_port_fullpath="/dev/$1"
binfile="$2"

# Get the directory where the script is running.
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [ -e "${dummy_port_fullpath}" ]; then
  echo "Reset device to bootloader" >&2
  "python3 ${DIR}/reset_to_bootloader.py" "${dummy_port_fullpath}"
else
  echo "${dummy_port_fullpath} doesn't exists" >&2
  echo "Trying upload firmware without reset" >&2
fi
sleep 1

"dfu-util" -D "${binfile}" -R

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

