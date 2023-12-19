{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      python-pkgs = ps: with ps; [
        numpy
        requests
        pytorch
        natasha
      ];
      my-python = pkgs.python3.withPackages python-pkgs;
    in
    {
      devShell.${system} = pkgs.mkShell {
        packages = [ my-python ];
      };
    };
}
