{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jovian.url = "github:ChocolateLoverRaj/Jovian-NixOS";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-fp.url = "github:ChocolateLoverRaj/rust-fp";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };
  outputs = { self, nixpkgs, nixos-cosmic, jovian, lanzaboote, rust-fp, nixos-hardware, ... }@inputs: {
    nixosConfigurations = {
      "jinlon" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/jinlon/configuration.nix
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          nixos-cosmic.nixosModules.default
          # rust-fp.nixosModules.default
        ];
      };
      "gaming-computer" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # jovian.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
          ./hosts/gaming-computer/configuration.nix
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          nixos-cosmic.nixosModules.default
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
    };
  };
}
