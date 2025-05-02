#!/bin/bash
[ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"

TIMESTAMP=$(date +"%Y-%m-%d-%H-%M")
PDFFILE="$HOME/Documents/newsboat/${TIMESTAMP}-article.pdf"
HTML=$(cat $input)
HTMLFILE="/tmp/${TIMESTAMP}-article-pdf.html"
echo $HTML > "$HTMLFILE"

# Convert the cleaned HTML to PDF using WeasyPrint
weasyprint "$HTMLFILE" "$PDFFILE"

# Notify the user
echo "Saved: $PDFFILE"

# Optionally open the PDF
open "$PDFFILE"
