{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };
  outputs =
    {
      nixpkgs,
      lanzaboote,
      nixos-hardware,
      ...
    }:
    {
      nixosConfigurations = {
        "jinlon" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/jinlon/configuration.nix
          ];
        };
        "gaming-computer" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            lanzaboote.nixosModules.lanzaboote
            ./hosts/gaming-computer/configuration.nix
          ];
        };
        "raspberry-pi" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./hosts/raspberry-pi/configuration.nix
            nixos-hardware.nixosModules.raspberry-pi-3
          ];
        };
        "robo360" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/robo360/configuration.nix
          ];
        };
        "installer" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (
              { pkgs, modulesPath, ... }:
              {
                imports = [
                  (modulesPath + "/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix")
                  ./tags/common.nix
                  ./tags/chromebook.nix
                  ./tags/asus.nix
                ];
                environment.etc.nixos-system-config.source = ./.;
              }
            )
          ];
        };
      };
    };
}
