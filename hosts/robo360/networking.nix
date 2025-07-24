{ lib, pkgs, ... }:

{
  networking.hostName = "robo360";
  networking.hostId = "8F3A6B92";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  services.cloudflared = {
    enable = true;
    tunnels = {
      "9f98a32b-8fef-4941-9174-79fdd7ce49c7.json" = {
        credentialsFile =
          "/root/.cloudflared/9f98a32b-8fef-4941-9174-79fdd7ce49c7.json";
        ingress = {
          "robo360.whats4meal.com" = "ssh://localhost:22";
          "nextcloud.whats4meal.com" = "http://localhost:4000";
          # "immich.whats4meal.com" = "http://localhost:2283";
          "photoprism.whats4meal.com" = "http://localhost:5000";
          "ente.whats4meal.com" = "http://localhost:8080";
          "cockpit.whats4meal.com" = "http://localhost:9090";
        };
        default = "http_status:404";
      };
    };
  };
  environment.systemPackages = with pkgs; [ cloudflared ];

  services.caddy = {
    enable = true;
    virtualHosts = {
      "immich.whats4meal.com".extraConfig = ''
        reverse_proxy localhost:2283
      '';
      "clraj.duckdns.org".extraConfig = ''
        reverse_proxy localhost:2283
      '';
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 80 443 ];
}
