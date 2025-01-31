# Grain Nix
In order to use this package you can set up your `flake.nix` like so, this is using flakelight for a devshell:
```nix
{
  inputs = {
    flakelight.url = "github:nix-community/flakelight";
    grain.url = "github:spotandjake/grain-nix";
  };
  outputs = { flakelight, grain, ... }:
    flakelight ./. ({ lib, ... }: {
      systems = lib.systems.flakeExposed;
      devShell = {
        packages = pkgs: [
          grain.packages.${pkgs.system}.default
        ];
      };
    });
}
``` 

### Breakdown
```nix
# Flake Imports
grain.url = "github:spotandjake/grain-nix";
# Package use
grain.packages.${system}.default
```