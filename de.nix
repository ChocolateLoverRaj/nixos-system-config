{ pkgs, ... }:

{
  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
      };
    };
    desktopManager = {
      plasma6 = {
        enable = true;
      };
      cosmic = {
        enable = true;
      };
    };
  };

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
