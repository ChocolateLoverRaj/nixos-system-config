{ lib, pkgs, ... }:

{
  networking.hostName = "gaming-computer";
  networking.networkmanager.enable = true;
  services.cloudflared = {
    enable = true;
    user = "root";
    tunnels = {
      "7b43f4c7-08fb-4a62-8849-e2c07d39d058.json" = {
        credentialsFile = "/root/.cloudflared/7b43f4c7-08fb-4a62-8849-e2c07d39d058.json";
        ingress = {
          "code.whats4meal.com" = "http://localhost:8080";
          "ssh.whats4meal.com" = "ssh://localhost:22";
        };
        default = "http_status:404";
      };
    };
  };
  environment.systemPackages = with pkgs; [ cloudflared ];
}
