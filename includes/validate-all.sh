#!/bin/bash

run_unix_cmd() {
  # $1 is the line number
  # $2 is the cmd to run
  # $3 is the expected exit code
  output=`$2 2>&1`
  exit_code=$?
  if [[ $exit_code -ne $3 ]]; then
    printf "failed (incorrect exit status code) on line $1.\n"
    printf "  - exit code: $exit_code (expected $3)\n"
    printf "  - command: $2\n"
    if [[ -z $output ]]; then
      printf "  - output: <none>\n\n"
    else
      printf "  - output: <starts on next line>\n$output\n\n"
    fi
    exit 1
  fi
}

DATE=`date +%Y-%m-%d`

# Validation of the "list-pagination" module

printf "Testing ietf-list-pagination-snapshot.yang (pyang)..."
command="pyang -Werror --ietf --max-line-length=72 ietf-system-capabilities@2021-04-02.yang ietf-list-pagination@2023-10-19.yang ../ietf-list-pagination-snapshot\@*.yang"
run_unix_cmd $LINENO "$command" 0
command="pyang --canonical ietf-system-capabilities@2021-04-02.yang ../ietf-list-pagination-snapshot\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-list-pagination-snapshot.yang (yanglint)..."
command="yanglint ietf-datastores@2018-02-14.yang ietf-yang-library@2019-01-04.yang ietf-system-capabilities@2021-04-02.yang ../ietf-list-pagination-snapshot\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"
