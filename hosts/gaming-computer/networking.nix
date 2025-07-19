{ pkgs, ... }:

let
  auth = ''
    basic_auth {
      rajas $2a$12$g4sHzlwKSwW7.6Q5bzACme6.dGqBHHt8fkloU43rsZZXRHicFfR8S
    }
  '';
in
{
  networking.hostName = "gaming-computer";
  networking.hostId = "AF78702B";
  services.caddy = {
    enable = true;
    virtualHosts = {
      ":1025".extraConfig = ''
        ${auth}
        reverse_proxy 127.0.0.1:11987
      '';
      ":1026".extraConfig = ''
        ${auth}
        reverse_proxy 127.0.0.1:8081
      '';
    };
  };
  environment.systemPackages = with pkgs; [ cloudflared ];
  programs.coolercontrol.enable = true;

  networking = {
    # nat = {
    #   enable = true;
    # };
    firewall = {
      enable = true;
      # checkReversePath = "loose";
      allowedTCPPortRanges = [
        {
          from = 4321;
          to = 4323;
        }
      ];
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };
  };
  # services.pixiecore = {
  #   enable = true;
  #   openFirewall = true;
  # };
}
