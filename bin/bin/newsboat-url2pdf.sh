#!/bin/bash

# Ensure a URL is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <URL>"
    exit 1
fi

~/bin/newsboat-url2html.sh $1 | ~/bin/newsboat-html2pdf.sh
