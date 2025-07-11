{
  description = "Modfest dev shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in

      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            packwiz
            (python3.withPackages (python-pkgs: [
              python-pkgs.tomli-w
              python-pkgs.requests
            ]))
          ];
        };
      }
    );
}
