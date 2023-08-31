{
  description = "General Nix Development Environments";

  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      flake-utils.url = "github:numtide/flake-utils";
      nix-ros-overlay= {
          url = "github:lopsided98/nix-ros-overlay";
        };
    };

  outputs = { nixpkgs, flake-utils,  ...}@inputs:
    with nixpkgs.lib;
    with flake-utils.lib;
    eachSystem allSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ inputs.nix-ros-overlay.overlays.default ];
      };
      in {
        legacyPackages = pkgs.rosPackages;

        devShells = {
          example-noetic = import ./ros/noetic.nix { inherit pkgs; };
          example-ros2-basic = import ./ros/ros2-basic.nix { inherit pkgs; };
        };
      });

    nixConfig = {
      extra-substituters = [ "https://ros.cachix.org" ];
      extra-trusted-public-keys = [ "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo=" ];
    };
}
