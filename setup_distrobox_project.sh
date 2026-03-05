#/bin/sh

# Script to create distrobox container and install development tools
# Usage: ./setup_distrobox_project.sh <container_name>

set -e  # Exit on any error

# Check if container name is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <container_name>"
    echo "Example: $0 my-dev-box"
    exit 1
fi

CONTAINER_NAME="$1"

echo "🚀 Creating distrobox container: $CONTAINER_NAME"
distrobox create --name "$CONTAINER_NAME" --image fedora:latest

echo "📦 Installing packages in container: $CONTAINER_NAME"

echo "📦 Installing neovim and lazygit in container..."
distrobox enter --root "$CONTAINER_NAME" -- bash -c "
    echo '🔄 Updating system packages...'
    dnf update -y
    
    echo '📝 Installing neovim...'
    dnf install -y neovim
    
    echo '🔧 Installing dependencies for lazygit...'
    dnf install -y dnf-plugins-core
    dnf copr enable atim/lazygit -y
    
    echo '🌿 Installing lazygit...'
    dnf install -y lazygit
    
    echo '✅ Installation completed!'
    echo '📋 Installed packages:'
    echo '  - neovim: $(nvim --version | head -1)'
    echo '  - lazygit: $(lazygit --version)'
"

echo ""
echo "🎉 Setup completed!"
echo "💡 To enter the container, run:"
echo "   distrobox enter $CONTAINER_NAME"
echo ""
echo "🔧 Available commands in the container:"
echo "   - nvim (or vim)"
echo "   - lazygit"
