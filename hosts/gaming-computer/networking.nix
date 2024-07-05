{ lib, pkgs, ... }:

let
  auth = ''
    basic_auth {
      rajas $2a$12$9HNY1js/crUU6IbbXDm6Jegf/OrnaG1Y6YC0rF34lDt6vM4gTdRfi
    }
  '';
in
{
  networking.hostName = "gaming-computer";
  networking.networkmanager.enable = true;
  services.caddy = {
    enable = true;
    virtualHosts = {
      ":1025".extraConfig = ''
        ${auth}
        reverse_proxy 127.0.0.1:11987
      '';
    };
  };
  services.cloudflared = {
    enable = true;
    user = "root";
    tunnels = {
      "7b43f4c7-08fb-4a62-8849-e2c07d39d058.json" = {
        credentialsFile = "/root/.cloudflared/7b43f4c7-08fb-4a62-8849-e2c07d39d058.json";
        ingress = {
          "code.whats4meal.com" = "http://localhost:8080";
          "ssh.whats4meal.com" = "ssh://localhost:22";
          "gaming-computer.whats4meal.com" = "http://localhost:1025";
        };
        default = "http_status:404";
      };
    };
  };
  environment.systemPackages = with pkgs; [ cloudflared ];
  programs.coolercontrol.enable = true;
}
