#!/bin/bash

set -e

PACKAGE_VERSION=1.2.0
PACKAGE_NAME=sportiduino_boards
PACKAGE_FILENAME=${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.bz2
PACKAGE_DIR=packages
PACKAGE_PATH=${PACKAGE_DIR}/${PACKAGE_FILENAME}

get_first_word() {
    echo "$1" | awk '{print $1}'
}

tar --exclude=.git --exclude=.gitignore --exclude=*.swp -cjf "${PACKAGE_PATH}" -C src avr
PACKAGE_SIZE=$(get_first_word $(wc -c "${PACKAGE_PATH}"))
PACKAGE_CHECKSUM=$(get_first_word $(sha256sum "${PACKAGE_PATH}"))

echo "{
  \"name\": \"Sportiduino boards\",
  \"architecture\": \"avr\",
  \"version\": \"${PACKAGE_VERSION}\",
  \"category\": \"Contributed\",
  \"url\": \"https://github.com/sportiduino/BoardsManagerFiles/raw/master/${PACKAGE_DIR}/${PACKAGE_FILENAME}\",
  \"archiveFileName\": \"${PACKAGE_FILENAME}\",
  \"checksum\": \"SHA-256:${PACKAGE_CHECKSUM}\",
  \"size\": \"${PACKAGE_SIZE}\",
}"

