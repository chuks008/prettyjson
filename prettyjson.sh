#!/bin/bash

params_msg="You are about to format the following .json files in this directory:"
all_msg="You are about to format all the .json files in this directory. Would you like to continue? Y/n"
proceed_msg="Would you like to continue? Y/n"

function beautify_json_params() {

  echo $params_msg
  for file in "$@";
  do
    echo "$file"
  done

  echo $proceed_msg
  read option

  while [[ $option != "Y" && $option != "y" && $option != "N" && $option != "n" ]]; do
    echo $params_msg
    for file in "$@";
    do
      echo "$file"
    done

    echo $proceed_msg
    read option
  done

  # input requested until its between Y/y or N/n

  if [[ $option == "Y" || $option == "y" ]]; then
    for file in "$@";
    do
        [ -e "$file" ] || continue
        cp "$file" copy-"$file"
        cat copy-"$file" | python -m json.tool > "$file"
        rm  copy-"$file"
        echo "$file"
    done
  elif [[ $option == "N" || $option == "n" ]]; then
    echo "prettyjson exited"
    exit 1
  fi
}

function beautify_json_all() {

  echo $all_msg
  read option

  while [[ $option != "Y" && $option != "y" && $option != "N" && $option != "n" ]]; do
    echo $all_msg
    read option
  done

  if [[ $option == "Y" || $option == "y" ]]; then
    for file in *.json;
    do
        [ -e "$file" ] || continue
        cp "$file" copy-"$file"
        cat copy-"$file" | python -m json.tool > "$file"
        rm  copy-"$file"
        echo "$file"
    done
  elif [[ $option == "N" || $option == "n" ]]; then
    echo "prettyjson exited"
    exit 1
  fi
}

if [ -z "$1" ]; then
    beautify_json_all
else
    beautify_json_params "$@"
fi
