#!/usr/bin/bash

say() { 
    TIMESTAMP=`date`
    echo "[$TIMESTAMP]: $1"
}

file_modified() {
    say "File $2 was modified."
    say "Attempting to make latex file."
    latexmk -interaction=nonstopmode $1$2
    if [ $? -eq 0 ]; then
        say "Compilation succeeded."
    else
        say "Failed to compile file."
    fi
}

inotifywait -q -m -e modify $1 | while read DIRECTORY EVENT FILE; do
    case $EVENT in
        MODIFY*)
            if [ $2 == $FILE ]; then
                file_modified "$DIRECTORY" "$FILE"
            fi
            ;;
    esac
done
