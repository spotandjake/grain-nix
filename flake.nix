# Grain - grain-v0.6.2 Nix
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
                  url = "https://github.com/grain-lang/grain/releases/download/grain-v0.6.2/grain-mac-x64";
                  sha256 = "1xfkyh9ir8wawbgwwiq6xhl8xll5b9diwsx8xln4mi4r5kmkhfg9";
                } else
              pkgs.fetchurl {
                # "x86_64-linux"
                url = "https://github.com/grain-lang/grain/releases/download/grain-v0.6.2/grain-linux-x64";
                sha256 = "15i5dq5vpr7vy6mwr9rkw54h4sjrfcwckk6bndqxhyws0cy86l8y";
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
                  sha256 = "0l376gwv4mxfl1jlkiw3bjm03xdws9sg8zfbbpsyqblxnpq3pmgp";
                } else
              pkgs.fetchurl {
                # "x86_64-linux"
                url = "https://github.com/grain-lang/grain/releases/download/preview/grain-linux-x64";
                sha256 = "1pfsah5xc9fv85zk5ic2j7ml6v78p000q3r6ppkk2m1zsf8qhrc2";
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
