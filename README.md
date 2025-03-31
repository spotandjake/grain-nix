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
grain.packages.${system}.default # Latest version
grain.packages.${system}.preview # Latest preview
```

### Upgrading
In order to use a different version this flake can be generated using `bash generate.sh <version>` if no version is given it will use `v0.6.6` make sure the version precisely matches the github release i.e `v0.6.6` is `grain-v0.6.6`, by default every output includes the preview release