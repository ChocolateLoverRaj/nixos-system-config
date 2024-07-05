{ lib, ... }:

let
  allowedPorts = [ 80 443 ];
  allowedPortRanges = [
    {
      from = 1025;
      to = 2024;
    }
  ];
in
{
  networking.hostName = "gaming-computer";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = allowedPorts;
    allowedUDPPorts = allowedPorts;
    allowedTCPPortRanges = allowedPortRanges;
    allowedUDPPortRanges = allowedPortRanges;
  };
  services.caddy = {
    enable = true;
    virtualHosts = {
      "c.whats4meal.com".extraConfig = ''
        reverse_proxy 127.0.0.1:8080
      '';
      "g.whats4meal.com".extraConfig = ''
        reverse_proxy 127.0.0.1:11987
      '';
      "chocolateloverraj.ddns.net".extraConfig = ''
        file_server
      '';
      "chocolateloverraj.ddns.net:1025".extraConfig = ''
        reverse_proxy 127.0.0.1:8080
      '';
      "chocolateloverraj.ddns.net:1026".extraConfig = ''
        reverse_proxy 127.0.0.1:11987
      '';
    };
  };
}
