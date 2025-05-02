#!/bin/bash

# Ensure a URL is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <URL>"
    exit 1
fi

# Generate filenames
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M")
TIMESTAMP_READABLE=$(date +"%Y-%m-%d %H:%M")
HTML="/tmp/${TIMESTAMP}-article.html"

URL=$1
JSON=$(readable -s ~/.newsboat/styles/readable-style.css --json "$URL")

# Extract article content using readable (HTML output)
ARTICLE_HTML=$(echo "$JSON" | jq -r '."html-content"')

# Extract metadata separately
TITLE=$(echo "$JSON" | jq -r '.title // "Untitled"')
BYLINE=$(echo "$JSON" | jq -r '.byline // "Unknown Author"')
EXCERPT=$(echo "$JSON" | jq -r '.excerpt // ""')

# Create enhanced HTML file with metadata included
cat <<EOF > "$HTML"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>$TITLE</title>
    <style>
        @page {
            size: A4;
            margin: 3cm;
        }
        body {
            font-family: "Georgia", "Times New Roman", serif;
            font-size: 10pt;
            line-height: 1.6;
            text-align: justify;
            max-width: 800px;
            margin: auto;
        }
        h1 {
            text-align: center;
            font-size: 1.8em;
            margin-bottom: 1.2em;
        }
        h2 {
            color: #555555;
            font-size: 1.4em;
        }
        .excerpt {
            color: #555555;
            font-size: 1.3em;
        }
        .byline {
            font-style: italic;
            color: #444444;
            font-size: 0.8em;
        }
        .meta {
            color: #777777;
            font-size: 0.6em;
        }
        hr {
            border: none;
            height: 1px;
            background-color: #aaaaaa;
            margin: 20px 0;
        }
        img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 10px auto;
        }
        figcaption {
            font-size: 0.6em;
            color: gray;
            margin-top: -10px;
        }
        figcaption small {
            margin-left: 1em;
        }
        footer {
            text-align: center;
            font-size: 0.9em;
            margin-top: 2em;
            color: gray;
        }
    </style>
</head>
<body>
    <h1>$TITLE</h1>
    <p class="excerpt">$EXCERPT</p>
    <p class="meta">Saved: $TIMESTAMP_READABLE</p>
    <p class="meta">URL: $URL</p>
    <p class="byline">By: $BYLINE</p>
    <hr>
    $ARTICLE_HTML
</body>
</html>
EOF

# Fix srcset: Extract the first image URL from srcset and replace it as the src
sed -i '' -E 's/<img([^>]+)srcset="([^"]+)"([^>]*)>/\
<img\1src="\2"\3>/g' "$HTML"
sed -i '' -E 's#\$%7BformatId%7D#906#g' "$HTML"

# Fix srcset: Extract the highest-resolution image from src attribute
sed -i '' -E 's#src="([^"]* [0-9]+w, )*([^ ]+ [0-9]+w)"#src="\2"#g' "$HTML"
# Remove the resolution descriptor (e.g., "2000w") to keep only the URL
sed -i '' -E 's#src="([^ ]+) [0-9]+w"#src="\1"#g' "$HTML"

cat "$HTML"

