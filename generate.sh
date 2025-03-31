#! /bin/bash

VERSION=${1:-"grain-v0.6.6"}
echo "Generating Flake for: $VERSION"

# Get Hash For mac
echo "Fetching hash for macOS $VERSION"
MAC_HASH=$(nix-prefetch-url https://github.com/grain-lang/grain/releases/download/$VERSION/grain-mac-x64)
echo "macOS hash: $MAC_HASH"
# Get Hash For Linux
echo "Fetching hash for Linux $VERSION"
LINUX_HASH=$(nix-prefetch-url https://github.com/grain-lang/grain/releases/download/$VERSION/grain-linux-x64)
echo "Linux hash: $LINUX_HASH"

# Get Hash For mac
echo "Fetching hash for macOS preview"
MAC_HASH_PREVIEW=$(nix-prefetch-url https://github.com/grain-lang/grain/releases/download/preview/grain-mac-x64)
echo "macOS hash: $MAC_HASH_PREVIEW"
# Get Hash For Linux
echo "Fetching hash for Linux preview"
LINUX_HASH_PREVIEW=$(nix-prefetch-url https://github.com/grain-lang/grain/releases/download/preview/grain-linux-x64)
echo "Linux hash: $LINUX_HASH_PREVIEW"

# Generate flake
cat > flake.nix << EOL
# Grain - $VERSION Nix
{
  inputs = {
    flakelight.url = "github:nix-community/flakelight";
  };
  outputs = { flakelight, ... }:
    flakelight ./. ({ lib, ... }: {
      systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" ];
      packages = { system, ... }: {
        default = { pkgs, stdenv, ... }: stdenv.mkDerivation {
          name = "grain";
          src =
            if (system == "aarch64-darwin" || system == "x86_64-darwin") then
              pkgs.fetchurl
                {
                  url = "https://github.com/grain-lang/grain/releases/download/$VERSION/grain-mac-x64";
                  sha256 = "$MAC_HASH";
                } else
              pkgs.fetchurl {
                # "x86_64-linux"
                url = "https://github.com/grain-lang/grain/releases/download/$VERSION/grain-linux-x64";
                sha256 = "$LINUX_HASH";
              };
          phases = [ "installPhase" ];
          installPhase = ''
            mkdir -p \$out/bin
            cp \$src \$out/bin/grain
            chmod +x \$out/bin/grain
          '';
        };
        preview = { pkgs, stdenv, ... }: stdenv.mkDerivation {
          name = "grain";
          src =
            if (system == "aarch64-darwin" || system == "x86_64-darwin") then
              pkgs.fetchurl
                {
                  url = "https://github.com/grain-lang/grain/releases/download/preview/grain-mac-x64";
                  sha256 = "$MAC_HASH_PREVIEW";
                } else
              pkgs.fetchurl {
                # "x86_64-linux"
                url = "https://github.com/grain-lang/grain/releases/download/preview/grain-linux-x64";
                sha256 = "$LINUX_HASH_PREVIEW";
              };
          phases = [ "installPhase" ];
          installPhase = ''
            mkdir -p \$out/bin
            cp \$src \$out/bin/grain
            chmod +x \$out/bin/grain
          '';
        };
      };
    });
}
EOL