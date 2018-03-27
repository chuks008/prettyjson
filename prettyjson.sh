#!/bin/bash

function beautify_params() {

    for file in "$@";
    do
        [ -e "$file" ] || continue
        cp "$file" copy-"$file"
        cat copy-"$file" | python -m json.tool > "$file"
        rm  copy-"$file"
        echo "$file"
    done
}

function beautify_all() {
    for file in *.json;
    do
        [ -e "$file" ] || continue
        cp "$file" copy-"$file"
        cat copy-"$file" | python -m json.tool > "$file"
        rm  copy-"$file"
        echo "$file"
    done
}

if [ -z "$1" ]; then
    echo "No paramaters. Beautify all json files"
    beautify_all
else
    beautify_params "$@"
fi

