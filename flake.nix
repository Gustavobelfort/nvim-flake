{
  description = "Gustavo Belfort's Neovim, configured with Nixvim";

  inputs = {
    # Nixvim's main branch tracks nixos-unstable; pairing it with anything else
    # is unsupported and breaks on option renames.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ flake-parts, nixvim, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./pre-commit-hooks.nix ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      # The raw module, so a consumer can extend it (extra servers, a different
      # colorscheme) with makeNixvimWithModule instead of forking the repo.
      flake.nixvimModules.default = ./config;

      perSystem =
        {
          pkgs,
          system,
          config,
          ...
        }:
        let
          module = ./config;
          nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule { inherit pkgs module; };
        in
        {
          packages = {
            default = nvim;
            inherit nvim;
          };

          # `nix flake check` starts the built Neovim headless and fails on any
          # error or warning raised while loading the config.
          checks.default = nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule {
            inherit pkgs module;
            name = "nvim-config";
          };

          formatter = pkgs.nixfmt-tree;

          devShells.default = pkgs.mkShell {
            shellHook = config.pre-commit.installationScript;
          };
        };
    };
}
