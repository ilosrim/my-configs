#!/bin/bash

# Specify the directory where your JavaScript files are located
SOURCE_DIR="/path/to/your/js/files"

# Loop through each .js file in the directory
for js_file in "$SOURCE_DIR"/*.js; do
    # Check if the file exists
    if [ -f "$js_file" ]; then
        # Create a new .ts filename by replacing the .js extension with .ts
        ts_file="${js_file%.js}.ts"
        # Convert the file from JavaScript to TypeScript
        mv "$js_file" "$ts_file"
        echo "Converted $js_file to $ts_file"
    fi
done

echo "Conversion complete!"
