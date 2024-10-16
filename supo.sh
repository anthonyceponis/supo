#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <course> <supo#>"
    exit 1
fi

# Get the filename from the argument
course="$1"
num="$2"

file_name="ac2615-$course-supo$num"

# Check if the Markdown file exists; if not, copy the template
if [ ! -f "$file_name.md" ]; then
    cp ~/supo_template.md "$file_name.md"
    echo "Generated template in $file_name.md."
    convert -size 595x842 xc:white "$file_name.pdf"
else
    echo "$file_name.md already exists."
fi


echo "Type q to quit."


gnome-terminal --tab -- bash -c "vim $file_name.md"

evince "$file_name.pdf" &
 
# Use 'entr' to watch for changes and convert to PDF
ls "$file_name.md" | entr -r bash -c "pandoc \"$file_name.md\" -o \"$file_name.pdf\" --pdf-engine=pdflatex -V geometry:margin=1in" 


