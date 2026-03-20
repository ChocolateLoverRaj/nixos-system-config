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
          # DHCP Server
          67
          # DNS Server
          53
          # OS Development
          8982
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
  # Required to fix tailscale causing DNS failures
  services.resolved.enable = true;
  # Improve Wi-Fi
  hardware.wirelessRegulatoryDatabase = true;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="US"
  '';
}
