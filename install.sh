#!/usr/bin/env bash
local_bin="$HOME/.local/bin"

# Function to print error message
error() {
    local errmsg="${1:-Unknown error}"
    echo -e "\033[1;31mError\033[0m: ${errmsg}\n" 1>&2
}

install_scripts() {
    # Check on project bin
    if [[ ! -d "bin" ]]; then
        error "Missing bin"
        return 1
    elif [[ -z "$(ls -A bin)" ]]; then
        error "Empty bin"
        return 1
    fi

    # Copy scripts to 'local_bin'
    for file in bin/*; do
        file_name=$(basename "$file")
        destination="$local_bin/$file_name"
        rm -rf "$destination"
        if ! cp "$file" "$destination"; then
            error "Failed to copy to bin: $file_name"
            return 1
        fi
    done
}

# Ensure 'local_bin' exists
mkdir -p "$local_bin"

install_scripts || exit 1
