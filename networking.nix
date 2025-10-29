{ lib, ... }:

{
  networking.hostName = lib.mkDefault "nixos";
  networking.networkmanager.enable = true;
  # networking.networkmanager.wifi.backend = "iwd";
  # networking.wireless.iwd.enable = true;
  networking.firewall =
    let
      allowedCommonPorts = [
        # Minecraft open to LAN
        36569
        # Minecraft Server
        25565
        # Minecraft mod - simple voice chat
        24454
      ];
    in
    {
      enable = true;
      allowedTCPPorts = allowedCommonPorts;
      allowedUDPPorts = allowedCommonPorts;
    };
}
