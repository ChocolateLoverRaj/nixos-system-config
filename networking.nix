{ lib, ... }:

{
  networking.hostName = lib.mkDefault "nixos";
  networking.networkmanager.enable = true;
}
