#!/bin/bash

# test if there is one parameter
if [ $# -ne 2 ]; then
    echo "Usage: $0 <smtp account> <base path for attachement files>" 
    exit 1
  else
    # set account to $1
    account=$1
    # set base path to $2
    base_path=$2
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

# function to delete white carhacters before the string
delete_white_characters() {
    echo "$1" | sed 's/^ *//'
}

# function to validate file in parameter exists, return 1 if yes, 0 if no
validate_file() {
    test -f "$1" && echo 1 || echo 0
}

# function to get the last colunm in a string with separator '/'
get_file() {
    echo "$1" | rev | cut -d '/' -f 1 | rev
}

boundary=$(uuidgen)
echo "code mms,state,comment" > out/output.csv

while IFS=',' read -r codemms firstname name class ranking student_nb average recipient file_path filename from cc genre is_done other
  do
    export recipient=$recipient
    export cc=$(echo "$cc" | tr '[:upper:]' '[:lower:]')
    export code_mms=$codemms
    export file_path=$( echo $base_path/$( delete_white_characters "$( basename "$file_path" )"))
    export filename=$( echo "$filename".$( get_suffixe "$( basename "$file_path" )") | tr ' ' '-' )
    export from=$from
    export firstname=$(capitalize "$firstname")
    export name=$name
    export class=$class
    export ranking=$(capitalize "$ranking")
    export student_nb=$student_nb
    export average=$(replace_dot "$average")
    export boundary=$boundary
    export mime_type=$(file -b --mime-type "$file_path")
    export genre=$(echo $genre | tr '[:upper:]' '[:lower:]')
    export is_done=$(echo $is_done | tr '[:upper:]' '[:lower:]')

    # test if attachement exists
    does_exist=`test -f "$file_path" && echo "1" || echo "0"`
    
    if [[ $is_done == 'no' && $does_exist == '1' ]]; then
      j2 --format=env message.txt.jinja2 > message.txt
      base64 "$file_path" >> message.txt
      echo "" >> message.txt
      echo "--$boundary--" >> message.txt

      #wait for 30s
      # sleep 2

      #send the email
      cat message.txt | msmtp -t -C config.ini -a $account
      echo "$code_mms,success,email sent to $recipient cc $cc with attachement $file_path and account $account" | tee -a out/output.csv
    elif [[ $is_done == 'no' && $does_exist -eq 0 ]]; then
      # echo "$file_path: no such file"
      echo "$code_mms,error,$(basename "$file_path") : no such file" | tee -a out/output.csv
    else
      echo "already done : email already sent to $recipient cc $cc with attachement $file_path"
    fi
  done < <(tail -n +2 resources/data.csv)


# uuencode -m $filepath $(basename $filepath) >> message.txt
# echo "" >> message.txt
# echo "--$boundary--" >> message.txt