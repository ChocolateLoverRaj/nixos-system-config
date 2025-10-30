{ ... }:

{
  networking = {
    networkmanager.enable = true;
    firewall =
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
  };
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };
}
