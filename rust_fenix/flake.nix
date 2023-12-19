{
  inputs = {
    fenix = {
      url = github:nix-community/fenix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  };

  outputs = { self, fenix, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; overlays = [ fenix.overlays.default ]; };
      toolchain = fenix.packages.${system}.latest;
      # toolchain = fenix.packages.${system}.default;
    in
    {
      devShell.${system} = pkgs.mkShell rec {
        buildInputs = with pkgs; [
          (toolchain.withComponents [
            "cargo"
            "rust-src"
            "rustc"
            "rustfmt"
          ])
          rust-analyzer-nightly
          openssl
          pkg-config
        ];
      };
    };
}
