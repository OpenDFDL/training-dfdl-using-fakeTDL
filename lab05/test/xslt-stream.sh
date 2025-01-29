#!/bin/bash
# Read NUL-separated XML documents from stdin and process each with xsltproc
# Handles the case of a last XML document not followed by a NUL
# The stdout is the result of each transformation, terminated by NUL.
# However, if there is no output from the transformation, no NUL is output.

# Ensure an XSLT stylesheet is provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 stylesheet.xsl" >&2
    exit 1
fi

STYLESHEET="$1"

while IFS= read -d '' -r xml || [[ -n "$xml" ]]
do
    # Capture the transformation output
    output=$(printf '%s' "$xml" | xsltproc "$STYLESHEET" -)

    # If there is output, print it and append a NUL separator
    if [[ -n "$output" ]]; then
        printf '%s\0' "$output"
    fi
done
