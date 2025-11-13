{
  description = "Python environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
  let
    supportedSystems = with flake-utils.lib.system; [ x86_64-linux ];
  in flake-utils.lib.eachSystem supportedSystems (system:
    let
      pkgs = import nixpkgs { inherit system; };
      pythonEnv = pkgs.python312.withPackages (ps: [ ps.pandas ps.flask ps.duckdb ]);
    in {
      devShells = {
        default = pkgs.mkShell { packages = [ pythonEnv ]; };
      };
    });
}
