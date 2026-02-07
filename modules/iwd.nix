{ lib, pkgs, ... }:

{
  # Enable IWD because I think it has better performance than  wpa_supplicant
  # This has issues with NetworkManager so I turned off NetworkManager, which means no GUI in KDE :(
  networking = {
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          Country = "US";
          RoamThreshold = -75;
          RoamThreshold5G = -80;
          RoamRetryInterval = 20;
          ControlPortOverNL80211 = false;
          EnableNetworkConfiguration = true;
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };
    useDHCP = false;
    networkmanager.enable = lib.mkForce false;
  };
  environment.systemPackages = with pkgs; [ iwgtk ];
  # Needed to connect to eduroam
  boot.kernelModules = [ "pkcs8_key_parser" ];
}
