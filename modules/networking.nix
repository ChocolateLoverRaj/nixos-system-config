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
          # # TFTP Server
          # 69
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

  services.netbird = {
    clients.wt0 = {
      # Port used to listen to wireguard connections
      port = 51821;

      # Set this to true if you want the GUI client
      ui.enable = false;

      # This opens ports required for direct connection without a relay
      openFirewall = true;

      # This opens necessary firewall ports in the Netbird client's network interface
      openInternalFirewall = true;
    };
  };

  # environment.etc = {
  #   "NetworkManager/dnsmasq-shared.d/tftp.conf".text = ''
  #     log-dhcp
  #     pxe-service=0,"Raspberry Pi Boot"
  #   '';
  # };
}
