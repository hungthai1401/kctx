#!/bin/bash

# Installation script for kubeconfig-switcher

set -euo pipefail

SCRIPT_NAME="kubeconfig-switcher.sh"
INSTALL_DIR="/usr/local/bin"
BINARY_NAME="kubeconfig-switcher"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_info() {
    echo -e "${YELLOW}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Check if running as root for system-wide installation
if [[ "${1:-}" == "--system" ]] && [[ $EUID -ne 0 ]]; then
    print_error "System-wide installation requires root privileges"
    print_info "Use: sudo ./install.sh --system"
    exit 1
fi

# Determine installation directory
if [[ "${1:-}" == "--system" ]]; then
    INSTALL_DIR="/usr/local/bin"
else
    INSTALL_DIR="$HOME/.local/bin"
    # Create ~/.local/bin if it doesn't exist
    mkdir -p "$INSTALL_DIR"
fi

# Check if script exists
if [[ ! -f "$SCRIPT_NAME" ]]; then
    print_error "Script not found: $SCRIPT_NAME"
    print_info "Make sure you're running this from the same directory as $SCRIPT_NAME"
    exit 1
fi

# Install the script
print_info "Installing $SCRIPT_NAME to $INSTALL_DIR/$BINARY_NAME..."
cp "$SCRIPT_NAME" "$INSTALL_DIR/$BINARY_NAME"
chmod +x "$INSTALL_DIR/$BINARY_NAME"

print_success "Installation complete!"
print_info "You can now use: $BINARY_NAME"

# Check if installation directory is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    print_warning "Installation directory is not in your PATH"
    print_info "Add the following to your ~/.bashrc or ~/.zshrc:"
    echo "  export PATH=\"\$PATH:$INSTALL_DIR\""
    print_info "Then restart your terminal or run: source ~/.bashrc"
fi

# Create configs directory
print_info "Creating configs directory..."
mkdir -p "$HOME/.kube/configs"
print_success "Created: $HOME/.kube/configs"

print_info "Installation finished! Place your kubeconfig files in ~/.kube/configs/"