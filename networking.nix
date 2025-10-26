{ lib, ... }:

{
  networking.hostName = lib.mkDefault "nixos";
  networking.networkmanager.enable = true;
  # networking.networkmanager.wifi.backend = "iwd";
  # networking.wireless.iwd.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 36569 ];
    allowedUDPPorts = [ 36569 ];
  };
}
