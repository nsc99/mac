{
  description = "mac";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      nix-darwin,
      git-hooks,
      ...
    }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};

      mkDarwin =
        { hostname, user }:
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs user; };
          modules = [
            ./hosts/${hostname}
            ./modules/darwin
          ];
        };

      pre-commit = git-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          nixfmt.enable = true;
          statix.enable = true;
          deadnix.enable = true;
        };
      };
    in
    {
      darwinConfigurations."mac" = mkDarwin {
        hostname = "mac";
        user = "nsc99";
      };

      formatter.${system} = pkgs.nixfmt;

      checks.${system}.pre-commit = pre-commit;

      # `nix develop` installs the git pre-commit hook.
      devShells.${system}.default = pkgs.mkShell {
        inherit (pre-commit) shellHook;
        packages = pre-commit.enabledPackages;
      };
    };
}
