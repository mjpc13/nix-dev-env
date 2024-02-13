{
  description = "General Nix Development Environments";

  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      flake-utils.url = "github:numtide/flake-utils";
      nix-ros-overlay= {
          url = "github:lopsided98/nix-ros-overlay";
      };
      rust-overlay.url = "github:oxalica/rust-overlay";
    };

  outputs = { nixpkgs, flake-utils,  ...}@inputs:
    with nixpkgs.lib;
    with flake-utils.lib;
    eachSystem allSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = with inputs; [ 
          nix-ros-overlay.overlays.default
          rust-overlay.overlays.default
        ];
      };
      in {
        legacyPackages = pkgs.rosPackages;

        devShells = {
          rust = import ./env/rust.nix { inherit pkgs; };

          ros-noetic = import ./env/ros/noetic.nix { inherit pkgs; };
          ros-melodic = import ./env/ros/noetic.nix { inherit pkgs; };
          ros-humble = import ./env/ros/humble.nix { inherit pkgs; };
          ros-rolling = import ./env/ros/rolling.nix { inherit pkgs; };
        };
      });

    nixConfig = {
      extra-substituters = [ "https://ros.cachix.org" ];
      extra-trusted-public-keys = [ "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo=" ];
    };
}
