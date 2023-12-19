{ config, lib, dream2nix, ... }:
let
  pyproject = lib.importTOML (config.mkDerivation.src + /pyproject.toml);
in
{
  imports = [ dream2nix.modules.dream2nix.WIP-python-pyproject ];

  deps = { nixpkgs, ... }: { python = nixpkgs.python3; };

  mkDerivation.src = ./.;

  buildPythonPackage.catchConflicts = false;

  pip.pypiSnapshotDate = "2023-12-12";
}
