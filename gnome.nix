{ pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
        };
      };
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
  };
  # Automatic screen rotation - https://nixos.wiki/wiki/GNOME
  hardware.sensor.iio.enable = true;

  environment = {
    systemPackages = with pkgs; [
      gnome-software
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  # https://wiki.nixos.org/wiki/KDE_Connect#GSConnect_(for_GNOME)
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
}
