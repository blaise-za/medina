#!/bin/bash
boundary=$(uuidgen)

while IFS=',' read -r codemms firstname name class ranking student_nb average recipient file_path filename from cc
  do
    export recipient=$recipient
    export cc=$cc
    export code_mms=$codemms
    export file_path=$file_path
    export filename=$filename
    export from=$from
    export firstname=$firstname
    export name=$name
    export class=$class
    export ranking=$ranking
    export student_nb=$student_nb
    export average=$average
    export boundary=$boundary
    export subject="test email"
  
    j2 --format=env message.txt.jinja2 > message.txt
    # uuencode -m $filepath $(basename $filepath) >> message.txt
    # echo "" >> message.txt
    # echo "--$boundary--" >> message.txt

  done < <(tail -n +2 resources/data.csv)

    
# uuencode -m $filepath $(basename $filepath) >> message.txt
# echo "" >> message.txt
# echo "--$boundary--" >> message.txt