#!/bin/bash

# Set the directory path to the current directory
directory="$PWD"

# Specify the directories to exclude
exclude_dirs=(
    "node_modules" "vendor" "packages" "lib" "dist" "build" "target" "bin" "obj"
    "tmp" "temp" "cache" ".cache" "__pycache__"
    "logs" "output" "out"
    ".vscode" ".idea" ".settings" ".project" ".classpath"
    ".git" ".svn" ".hg"
    "docs" "doc" "examples" "samples"
)

# Specify the files to exclude
exclude_files=(
    ".DS_Store" "Thumbs.db" "desktop.ini"
    "*~" "*.bak" "*.tmp" "*.temp" "*.swp"
    "*.pyc" "*.class" "*.exe" "*.dll" "*.so" "*.o"
    "package-lock.json" "yarn.lock" "composer.lock" "Gemfile.lock"
)

# Specify the file extensions to exclude
exclude_extensions=(
    ".ico" ".png" ".jpg" ".jpeg" ".gif" ".bmp" ".svg"
    ".pdf" ".doc" ".docx" ".xls" ".xlsx" ".ppt" ".pptx"
    ".zip" ".tar" ".gz" ".rar" ".7z"
    ".mp3" ".wav" ".mp4" ".avi" ".mov"
)

# Find all files in the directory and its subdirectories, excluding specified directories and files
find "$directory" -type f | while IFS= read -r file; do
    should_exclude=false
    
    for exclude_dir in "${exclude_dirs[@]}"; do
        if [[ "$file" == *"/$exclude_dir/"* ]]; then
            should_exclude=true
            break
        fi
    done
    
    if [ "$should_exclude" = false ]; then
        for exclude_file in "${exclude_files[@]}"; do
            if [[ "$(basename "$file")" == "$exclude_file" ]]; then
                should_exclude=true
                break
            fi
        done
    fi
    
    if [ "$should_exclude" = false ]; then
        extension="${file##*.}"
        for exclude_extension in "${exclude_extensions[@]}"; do
            if [[ "${extension,,}" == "${exclude_extension#.}" ]]; then
                should_exclude=true
                break
            fi
        done
    fi
    
    if [ "$should_exclude" = false ]; then
        # Print the full file path
        echo "File: $file"
        echo ""
        
        # Print the code content of the file
        if file -b --mime-encoding "$file" | grep -q binary; then
            echo "Skipping binary file."
            echo ""
            echo "------------------------"
            echo ""
        else
            cat "$file"
            echo ""
            echo "------------------------"
            echo ""
        fi
    fi
done


