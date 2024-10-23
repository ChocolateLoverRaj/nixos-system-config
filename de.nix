{ pkgs, ... }:

{
  services = {
    desktopManager = {
      plasma6 = {
        enable = true;
      };
      cosmic = {
        enable = true;
      };
    };
    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
      };
    };
    # xserver = {
    #   enable = true;
    #   displayManager = {
    #     gdm = {
    #       enable = true;
    #     };
    #   };
    #   desktopManager = {
    #     gnome = {
    #       enable = true;
    #     };
    #   };
    # };
  };
  # Automatic screen rotation - https://nixos.wiki/wiki/GNOME
  hardware.sensor.iio.enable = true;

  # Needed to have both GNOME and KDE
  programs.ssh.askPassword = "${pkgs.plasma5Packages.ksshaskpass}/bin/ksshaskpass";

  environment = {
    systemPackages = with pkgs; [
      # Needed for KDE Plasma to fully function
      clinfo
      glxinfo
      vulkan-tools
      wayland-utils
      pciutils
      aha
      smartmontools
      # For logging in to Google. Doesn't work as of now (https://github.com/NixOS/nixpkgs/issues/263299)
      kdePackages.kaccounts-integration
      kdePackages.kaccounts-providers
      kdePackages.kio-gdrive
      kdePackages.signond
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
  programs = {
    kdeconnect = {
      enable = true;
    };
  };
}
