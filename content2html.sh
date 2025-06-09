#!/bin/bash

# Convert a content file containing a snippet of HTML to  a complete HTML file using
# the specified template file.
CONTENT_FILE=$1
TEMPLATE_FILE=$2

USAGE="Usage: $0 <content-file> <template-file>"

if ! [ -e "$CONTENT_FILE" ]; then
    echo "Content file not found!"
    echo "$USAGE"
    exit 1
fi
if ! [ -e "$TEMPLATE_FILE" ]; then
    echo "Template file not found!"
    echo "$USAGE"
    exit 1
fi

# Replace the placeholder "{{content}}" in the template with the content from
# the content file.
sed "/{{content}}/{
    r $CONTENT_FILE
    d
}" $TEMPLATE_FILE
