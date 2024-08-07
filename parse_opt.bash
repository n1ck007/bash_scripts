#!/usr/bin/env bash
# Reference: https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash?page=1&tab=scoredesc#tab-top
# 
# Example input: 
#   ./parse_opt.bash All -b world you need --optA hello is love. -c
# Example output:
#   optA = hello
#   optB = world
#   optC = TRUE
#   Number of positional args: 5l args: 5
#   pos_args[0] = All
#   pos_args[1] = you
#   pos_args[2] = need
#   pos_args[3] = is
#   pos_args[4] = love.
# 
# This scripts parses commands with GNU style options both short and long with and without arguments
# as well as optionless (positional) arguments (arg1 arg2 arg3 ...)
# 
# RegEx for command options. OPT represents all possible allowable options and arguments.
# The string {ALNUM} is an indepentant value and can be changed to fit the use case.
# 
# ALNUM='[0-9A-Za-z]'
# ARG='{ALNUM}+'
# SHORT='-{ALNUM} {ARG}'
# LONG='--{ALNUM}+(-{ALNUM}+)* {ARG}'
# OPT='({SHORT}|{LONG}|{ARG})*'
# 

# declares an empty array
POSITIONAL_ARGS=()

# Handles arguemts of the form `--option argument` and `-o argument`
while [[ $# -gt 0 ]]; do
  case $1 in
    -a|--optA)
      optA="$2"
      shift # past opt
      shift # past arg
      ;;
    -b|--optB)
      optB="$2"
      shift # past opt
      shift # past arg
      ;;
    -c|--optC)
      optC=TRUE 
      shift # past opt
      # option has no arg
      ;;
    -*|--*)
      echo "Unknown option: $1"
      exit 1 # exit process with error code 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

echo "optA = ${optA}"
echo "optB = ${optB}"
echo "optC = ${optC}"
# echo "Number files in SEARCH PATH with EXTENSION:" $(ls -1 "${SEARCHPATH}"/*."${EXTENSION}" | wc -l)

NUM_ARGS="${#POSITIONAL_ARGS[@]}"
printf "Number of positional args: ${NUM_ARGS}\n"

for ((i = 0; i < ${NUM_ARGS}; i++))
do
  printf "pos_args[$i] = ${POSITIONAL_ARGS[$i]}\n"
done
