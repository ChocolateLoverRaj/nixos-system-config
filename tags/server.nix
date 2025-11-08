{ pkgs, ... }:

{
  imports = [
    ../modules/docker.nix
    # TODO: Only apply this if a machine is a server *and* a Chromebook
    ../modules/maintain-charge.nix
    ../modules/samba.nix
  ];

  services.cloudflare-dyndns = {
    enable = true;
    domains = [
      # "immich.whats4meal.com"
      "wg.whats4meal.com"
      "iperf3.whats4meal.com"
      "sftp.whats4meal.com"
    ];
    apiTokenFile = "/root/cloudflare-api-token";
  };
  services.ddclient = {
    protocol = "duckdns";
    passwordFile = "/root/duckdns-token";
    domains = [ "clraj.duckdns.org" ];
  };

  services.scrutiny = {
    enable = true;
    openFirewall = true;
  };

  services.udisks2.enable = true;

  services.cloudflared = {
    enable = true;
    tunnels = {
      "9f98a32b-8fef-4941-9174-79fdd7ce49c7.json" = {
        credentialsFile = "/root/.cloudflared/9f98a32b-8fef-4941-9174-79fdd7ce49c7.json";
        ingress = {
          "robo360.whats4meal.com" = "ssh://localhost:22";
          "nextcloud.whats4meal.com" = "http://localhost:4000";
          "immich.whats4meal.com" = "http://localhost:2283";
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
  networking.firewall =
    let
      allowedPorts = [
        80
        443
      ];
    in
    {
      allowedTCPPorts = allowedPorts;
      allowedUDPPorts = allowedPorts;
    };

  boot.zfs.extraPools = [ "para-z" ];
  services.tlp = {
    enable = true;
    settings = {
      USB_AUTOSUSPEND = 0;
    };
  };
}
