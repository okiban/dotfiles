#!/bin/bash

# Thanks you Claude for making it way longer but at least it has comments and it looks sexy

# Configuration: Define source directories and their corresponding destinations
# Format: "source_dir:destination_dir"
declare -a CONFIG_MAPPINGS=(
    ".config:$HOME/.config"
    "zsh_config:$HOME"
)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to create symlinks for a source directory
create_symlinks() {
    local src_dir=$1
    local dest_dir=$2
    
    # Check if source directory exists
    if [[ ! -d "$src_dir" ]]; then
        print_status "$RED" "❌ Source directory '$src_dir' does not exist, skipping..."
        return 1
    fi
    
    # Create destination directory if it doesn't exist
    if [[ ! -d "$dest_dir" ]]; then
        mkdir -p "$dest_dir"
        print_status "$BLUE" "📁 Created destination directory: $dest_dir"
    fi
    
    print_status "$BLUE" "🔗 Processing: $src_dir → $dest_dir"
    
    local linked_count=0
    local skipped_count=0
    
    # Iterate through items in source directory
    # Enable nullglob to handle empty directories gracefully
    shopt -s nullglob dotglob
    
    for item in "$src_dir"/*; do
        # Skip if no files match (shouldn't happen with nullglob)
        [[ ! -e "$item" ]] && continue
        
        local item_name="$(basename "$item")"
        local dest_path="$dest_dir/$item_name"
        
        # Skip if destination already exists
        if [[ -e "$dest_path" || -L "$dest_path" ]]; then
            if [[ -L "$dest_path" ]]; then
                local current_target="$(readlink "$dest_path")"
                if [[ "$current_target" == "$item" ]]; then
                    print_status "$YELLOW" "  ⚡ $item_name (already correctly linked)"
                else
                    print_status "$YELLOW" "  ⚠️  $item_name (linked to different target: $current_target)"
                fi
            else
                print_status "$YELLOW" "  ⚠️  $item_name (exists but not a symlink)"
            fi
            ((skipped_count++))
        else
            # Create the symlink
            if ln -s "$item" "$dest_path"; then
                print_status "$GREEN" "  ✅ $item_name"
                ((linked_count++))
            else
                print_status "$RED" "  ❌ Failed to link $item_name"
            fi
        fi
    done
    
    # Restore shell options
    shopt -u nullglob dotglob
    
    print_status "$BLUE" "  📊 Summary: $linked_count linked, $skipped_count skipped"
    return 0
}

# Main execution
main() {
    local script_dir="$(cd "$(dirname "$0")" && pwd)"
    
    print_status "$BLUE" "🚀 Smart Symbolic Links Script"
    print_status "$BLUE" "📂 Working from: $script_dir"
    echo
    
    local total_processed=0
    local total_success=0
    
    # Process each configured mapping
    for mapping in "${CONFIG_MAPPINGS[@]}"; do
        # Split mapping into source and destination
        local src_dir="${mapping%%:*}"
        local dest_dir="${mapping##*:}"
        
        # Make source path absolute
        local full_src_path="$script_dir/$src_dir"
        
        # Expand variables in destination path
        dest_dir=$(eval echo "$dest_dir")
        
        ((total_processed++))
        if create_symlinks "$full_src_path" "$dest_dir"; then
            ((total_success++))
        fi
        echo
    done
    
    # Final summary
    print_status "$BLUE" "🎯 Final Summary:"
    print_status "$BLUE" "   Processed: $total_processed directories"
    print_status "$GREEN" "   Successful: $total_success directories"
    
    if [[ $total_success -eq $total_processed ]]; then
        print_status "$GREEN" "✨ All operations completed successfully!"
    else
        print_status "$YELLOW" "⚠️  Some operations had issues. Check the output above."
    fi
}

# Run main function
main "$@"
