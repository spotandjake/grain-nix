# Put this in a flake.nix for a minimal example of a devShell
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