{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pythonPackages = pkgs.python310Packages;
      in {
        packages = rec {
          default = pyre-extensions;

          pyre-extensions = pythonPackages.buildPythonPackage rec {
            pname = "pyre-extensions";
            version = "0.0.30";

            src = pythonPackages.fetchPypi {
              inherit pname version;
              sha256 = "sha256-unkjxIbgia+zehBiOo9K6C1zz/QkJtcRxIrwcOW8MbI=";
            };

            buildInputs = [
              pythonPackages.typing-inspect
            ];
          };
        };
      }
    );
}
