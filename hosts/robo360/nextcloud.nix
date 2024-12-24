{ pkgs, config, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "localhost";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    settings = {
      trusted_domains = [ "nextcloud.whats4meal.com" ];
      overwriteprotocol = "https";
    };
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) richdocuments;
    };
  };

  services.nginx.virtualHosts."localhost".listen = [{ addr = "127.0.0.1"; port = 4000; }];
}
