#!/bin/bash

# Configuration
CONFIG_FILE=".terraform-docs.yml"
README_FILE="README.md"
TEMP_DIR=$(mktemp -d)

# Function to check if directory contains Terraform files
has_terraform_files() {
    local dir=$1
    [[ -n $(find "$dir" -maxdepth 1 -name "*.tf" -type f) ]]
}

# Function to get relative path from root
get_relative_path() {
    local dir=$1
    local root=$2
    echo "${dir#$root/}"
}

# Function to process a single module
process_module() {
    local dir=$1
    local root=$2
    local relative_path=$(get_relative_path "$dir" "$root")
    local output_file="$TEMP_DIR/${relative_path//\//_}.md"
    
    # Generate documentation for this module
    terraform-docs markdown table "$dir" > "$output_file"
    
    # Add module header to the documentation
    if [[ "$relative_path" == "" ]]; then
        relative_path="root"
    fi
    
    echo "# Module: \`$relative_path\`" > "$TEMP_DIR/${relative_path//\//_}_final.md"
    echo "" >> "$TEMP_DIR/${relative_path//\//_}_final.md"
    cat "$output_file" >> "$TEMP_DIR/${relative_path//\//_}_final.md"
    echo "" >> "$TEMP_DIR/${relative_path//\//_}_final.md"
    echo "---" >> "$TEMP_DIR/${relative_path//\//_}_final.md"
    echo "" >> "$TEMP_DIR/${relative_path//\//_}_final.md"
}

# Main function to process directories recursively
process_directory() {
    local dir=$1
    local root=$2
    
    # Skip .terraform directories
    if [[ "$dir" == *".terraform"* ]]; then
        return
    fi
    
    # Process current directory if it contains Terraform files
    if has_terraform_files "$dir"; then
        echo "Processing: $dir"
        process_module "$dir" "$root"
    fi
    
    # Process subdirectories
    for subdir in "$dir"/*/; do
        if [[ -d "$subdir" ]]; then
            process_directory "$subdir" "$root"
        fi
    done
}

# Check if terraform-docs is installed
if ! command -v terraform-docs &> /dev/null; then
    echo "Error: terraform-docs is not installed"
    echo "Please install it from: https://terraform-docs.io/user-guide/installation/"
    exit 1
fi

# Start processing from current directory
start_dir="${1:-.}"
start_dir=$(realpath "$start_dir")

# Create root README.md
cat > "$start_dir/$README_FILE" << EOL
# Terraform Documentation

This documentation is automatically generated for all Terraform modules in this repository.

## Table of Contents

EOL

# Process all directories
process_directory "$start_dir" "$start_dir"

# Generate table of contents and combine all documentation
for doc in "$TEMP_DIR"/*_final.md; do
    if [[ -f "$doc" ]]; then
        # Extract module name for table of contents
        module_name=$(head -n 1 "$doc" | sed 's/# Module: `//' | sed 's/`//')
        echo "- [\`$module_name\`](#module-${module_name//\//-})" >> "$start_dir/$README_FILE"
    fi
done

echo "" >> "$start_dir/$README_FILE"

# Append all documentation
for doc in "$TEMP_DIR"/*_final.md; do
    if [[ -f "$doc" ]]; then
        cat "$doc" >> "$start_dir/$README_FILE"
    fi
done

# Clean up
rm -rf "$TEMP_DIR"

echo "Documentation generated in $start_dir/$README_FILE"