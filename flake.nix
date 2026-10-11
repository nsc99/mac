{
  description = "mac";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = inputs@{ nix-darwin, ... }:
  let
    mkDarwin = { hostname, user }: nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs user; };
      modules = [
        ./hosts/${hostname}
        ./modules/darwin
      ];
    };
  in
  {
    darwinConfigurations."mac" = mkDarwin {
      hostname = "mac";
      user = "nsc99";
    };
  };
}
