#!/bin/bash
find . -type f -name '*.mp4' | while read FILE ; do
    newfile="$(echo ${FILE} |sed -e 's/\ //g' -e "s/'/-/g")" ;
    mv "${FILE}" "${newfile}" ;
done
