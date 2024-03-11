#!/bin/bash

# test if there is one parameter
if [ $# -ne 1 ]; then
    echo "Usage: $0 <smtp account>"
    exit 1
  else
    # set account to $1
    account=$1
fi

#function to  convert the first character of each word in uppercase
capitalize() {
    echo "$1" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i, 1, 1)) tolower(substr($i, 2));}1'
}

#function to convert '.' to ',' in a string
replace_dot() {
    echo "$1" | tr '.' ','
}

# function to remove the first line and the last line from stdin
remove_first_last_line() {
    sed '1d;$d'
}

# function to get the suffixe of a file path from stdin or parameter
get_suffixe() {
    echo "$1" | rev | cut -d '.' -f 1 | rev
}

boundary=$(uuidgen)

while IFS=',' read -r codemms firstname name class ranking student_nb average recipient file_path filename from cc genre isdone
  do
    export recipient=$recipient
    export cc=$(echo "$cc" | tr '[:upper:]' '[:lower:]')
    export code_mms=$codemms
    export file_path=$file_path
    export filename=$(echo "$filename" | tr ' ' '-')
    # export filename="$filename"
    export from=$from
    export firstname=$(capitalize "$firstname")
    export name=$name
    export class=$class
    export ranking=$(capitalize "$ranking")
    export student_nb=$student_nb
    export average=$(replace_dot "$average")
    export boundary=$boundary
    export mime_type=$(file -b --mime-type "$file_path")
    # export subject="test email"
    export genre=$(echo $genre | tr '[:upper:]' '[:lower:]')
    export isdone=$(echo $isdone | tr '[:upper:]' '[:lower:]')

    # test if isdone = 'no'
    if [ $isdone="no" ]; then
      export file_path=resources/DSC_0024.jpg
      export recipient=blaise.zarka@gmail.com
      export cc="mangone.thiam@mymedinaschools.com"
      export filename=$(echo $filename.$( get_suffixe $(basename $file_path)))

      j2 --format=env message.txt.jinja2 > message.txt
      base64 "$file_path" >> message.txt
      echo "" >> message.txt
      echo "--$boundary--" >> message.txt

      #wait for 30s
      # sleep 30

      #send the email
      cat message.txt | msmtp -t -C config.ini -a $account
      echo "mail sent to $recipient cc $cc with attachement $file_path and account $account" | tee -a output.log
    fi
    break
  done < <(tail -n +2 resources/data.csv)


# uuencode -m $filepath $(basename $filepath) >> message.txt
# echo "" >> message.txt
# echo "--$boundary--" >> message.txt