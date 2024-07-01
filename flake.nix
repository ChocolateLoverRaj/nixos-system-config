{
  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
  };
  outputs = { self, nixpkgs, nixos-cosmic, jovian, ... }@inputs: {
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
        ];
      };
      "gaming-computer" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          jovian.nixosModules.default
          ./hosts/gaming-computer/configuration.nix
        ];
      };
    };
  };
}
