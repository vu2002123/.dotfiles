#!/bin/bash

# Check if rust is installed
if ! command -v rustc &> /dev/null; then
    echo "Rust is not installed. Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
fi

# Install ripgrep using cargo
echo "Installing ripgrep..."
cargo install ripgrep

# Check if ripgrep installation was successful
if command -v rg &> /dev/null; then
    echo "ripgrep has been successfully installed."
else
    echo "Failed to install ripgrep. Please check your setup."
    exit 1
fi

# Install tree-sitter-cli using cargo
echo "Installing tree-sitter-cli..."
cargo install tree-sitter-cli

# Check if tree-sitter installation was successful
if command -v tree-sitter &> /dev/null; then
    echo "tree-sitter-cli has been successfully installed."
else
    echo "Failed to install tree-sitter-cli. Please check your setup."
    exit 1
fi
