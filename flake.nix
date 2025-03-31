# Grain - grain-v0.6.6 Nix
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
                  url = "https://github.com/grain-lang/grain/releases/download/grain-v0.6.6/grain-mac-x64";
                  sha256 = "1fjc58ddz3bkipv3xddyllvrwhr648paaj2vd19mz7a29fvxv7j3";
                } else
              pkgs.fetchurl {
                # "x86_64-linux"
                url = "https://github.com/grain-lang/grain/releases/download/grain-v0.6.6/grain-linux-x64";
                sha256 = "0cc683j8jjyyrx7jbcmafal2zyijkrpnvk265niwas9xlqrb0pm5";
              };
          phases = [ "installPhase" ];
          installPhase = ''
            mkdir -p $out/bin
            cp $src $out/bin/grain
            chmod +x $out/bin/grain
          '';
        };
        preview = { pkgs, stdenv, ... }: stdenv.mkDerivation {
          name = "grain";
          src =
            if (system == "aarch64-darwin" || system == "x86_64-darwin") then
              pkgs.fetchurl
                {
                  url = "https://github.com/grain-lang/grain/releases/download/preview/grain-mac-x64";
                  sha256 = "1gwcsi5r6nw782rw4kjbhwq73sphra8j75d2jfpjrhxki8xdr20i";
                } else
              pkgs.fetchurl {
                # "x86_64-linux"
                url = "https://github.com/grain-lang/grain/releases/download/preview/grain-linux-x64";
                sha256 = "1q3ijrr9pv246nqfvnjw6h8q8z321s7l8z2fc6fzyzx66c3s3mpp";
              };
          phases = [ "installPhase" ];
          installPhase = ''
            mkdir -p $out/bin
            cp $src $out/bin/grain
            chmod +x $out/bin/grain
          '';
        };
      };
    });
}
