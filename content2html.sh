#!/bin/bash

# Convert a content file containing a snippet of HTML to  a complete HTML file using
# the specified template file.
CONTENT_FILE=$1
TEMPLATE_FILE=$2
OUTPUT_FILE=$3

USAGE="Usage: $0 <content-file> <template-file> <output-file> [--replace-xxx=text]"

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

# Replace the placeholder "{{content}}" in $OUTPUT_FILE with the contents of $CONTENT_FILE.
sed "/{{content}}/{
    r $CONTENT_FILE
    d
}" $TEMPLATE_FILE > $OUTPUT_FILE


# For any command line argument of the form --replace-xxx=text, replace
# the placeholder "{{xxx}}" in the template with the specified text.
for arg in "$@"; do
    if [[ $arg == --replace-* ]]; then
        key=${arg%%=*}
        value=${arg#*=}
        sed -i .bak "s/{{${key#--replace-}}}/$value/g" $OUTPUT_FILE
    fi
done
