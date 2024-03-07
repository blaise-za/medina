#!/bin/bash

while IFS=',' read -r code_mms firstname name class ranking student_nb average recipient file_path filename from cc; do
  # boundary=$(uuidgen)
  echo "$code_mms, $firstname, $name, $class, $ranking, $student_nb, $average, $recipient, $file_path, $filename, $from, $cc, $boundary"
  break
  # jinja2 \
  #   -D recipient="$recipient" \
  #   -D subject="test email" \
  #   -D boundary=$boundary \
  #   message.txt.jinja2 > message.txt
done < resources/data.csv

    # -D firstname=$firstname \
    # -D name=$name \
    # -D class=$class \
    # -D ranking=$ranking \
    # -D student_nb=$student_nb \
    # -D average=$average \
    # -D code_mms=$code_mms \
    # -D file_path=$file_path \
    # -D filename=$filename \
    # -D from=$from \
    # -D cc=$cc \


# recipient=blaise@me.com
# filepath=consular-service-request-form-completed.pdf

# jinja2 \
#   -D recipient=$recipient \
#   -D subject="test email" \
#   -D boundary=$boundary \
#   message.txt.jinja2 > message.txt
  
# uuencode -m $filepath $(basename $filepath) >> message.txt
# echo "" >> message.txt
# echo "--$boundary--" >> message.txt