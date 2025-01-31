# Version
VERSION="grain-v0.6.6"

# Get Hash For mac
echo "Mac"
nix-prefetch-url https://github.com/grain-lang/grain/releases/download/$VERSION/grain-mac-x64
# Get Hash For Linux
echo "Linux"
nix-prefetch-url https://github.com/grain-lang/grain/releases/download/$VERSION/grain-linux-x64