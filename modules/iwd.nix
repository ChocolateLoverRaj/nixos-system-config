{ lib, ... }:

{
  # Enable IWD because I think it has better performance than  wpa_supplicant
  # This has issues with NetworkManager so I turned off NetworkManager, which means no GUI in KDE :(
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        Country = "US";
      };
      Settings = {
        AutoConnect = true;
      };
    };
  };
  # Needed to connect to eduroam
  boot.kernelModules = [ "pkcs8_key_parser" ];
  networking.networkmanager.enable = lib.mkForce false;
  # networking.networkmanager.wifi.backend = "iwd";
  # networking.networkmanager.ensureProfiles.profiles = {
  #   eduroam = {
  #     connection = {
  #       id = "eduroam nixos 2";
  #       type = "wifi";
  #       # interface-name = "wlan0"; # # replace with your interface-name as displayed by "ip a"
  #     };
  #     wifi = {
  #       mode = "infrastructure";
  #       ssid = "eduroam";
  #       # cloned-mac-address = "19:10:35:89:06:2c";
  #     };
  #     wifi-security = {
  #       key-mgmt = "wpa-eap"; # # adapt according to your universities setup
  #     };
  #     "802-1x" = {
  #       # # not all or even some additional values may be needed here according to your institution
  #       eap = "tls"; # # adapt according to your universities setup
  #       identity = "rajas3@uw.edu";
  #       client-cert = "/etc/ssl/certs/eduroam/cert.pem";
  #       private-key = "/etc/ssl/certs/eduroam/private.key";
  #       private-key-password = ""; # # warning, this should only be done for testing purposes, as it makes the password world-readable. You should replace this with some form of secrets-management using sops-nix or agenix.
  #       ca-cert = "/etc/ssl/certs/eduroam/ca_cert.cer";
  #     };
  #     ipv4 = {
  #       method = "auto";
  #     };
  #     ipv6 = {
  #       method = "auto";
  #     };
  #   };
  # };
}
