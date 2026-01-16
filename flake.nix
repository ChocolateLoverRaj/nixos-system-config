{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Use keyd <2.6.0, because 2.6.0 has an annoying bug
    nixpkgsKeyd.url = "github:NixOS/nixpkgs/0fca36f4cf8f67dd8e1d7e37fa379d55c5150ca5";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };
  outputs =
    {
      nixpkgs,
      nixpkgsKeyd,
      lanzaboote,
      nixos-hardware,
      nix-cachyos-kernel,
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
        "zephy" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            let
              system = "x86_64-linux";
              pkgs-keyd = import nixpkgsKeyd {
                inherit system;
              };
            in
            [
              {
                nixpkgs.overlays = [
                  # Overlay: Use `self` and `super` to express
                  # the inheritance relationship
                  (self: super: {
                    keyd = pkgs-keyd.keyd;
                  })
                ];
              }
              ./hosts/zephy/configuration.nix
              lanzaboote.nixosModules.lanzaboote
              {
                nixpkgs.overlays = [ nix-cachyos-kernel.overlays.pinned ];
              }
            ];
        };
      };
    };
}
