{
  inputs = {
    dream2nix.url = github:nix-community/dream2nix;
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    nixpkgs.follows = "dream2nix/nixpkgs";
  };

  outputs = { self, dream2nix, nixpkgs }:
    let
      system = "x86_64-linux";
    in
    {
      packages.${system}.default = dream2nix.lib.evalModules {
        packageSets.nixpkgs = dream2nix.inputs.nixpkgs.legacyPackages.${system};
        modules = [
          ./default.nix
          {
            paths = {
              projectRoot = ./.;
              package = ./.;
              projectRootFile = "flake.nix";
            };
          }
        ];
      };
    };
}
