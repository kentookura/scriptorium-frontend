{
  description = "Purescript shell";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.05;

    flake-utils.url = github:numtide/flake-utils;

    easy-purescript-nix.url = github:justinwoo/easy-purescript-nix;
    easy-purescript-nix.flake = false;
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    easy-purescript-nix,
  } @ inputs: let
  in {
    devShells."x86_64-linux".default = import ./shell.nix {inherit inputs;};
  };
}
