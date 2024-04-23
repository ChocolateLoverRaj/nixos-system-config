{ pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      libinput = {
        # Enable touchpad support (enabled default in most desktopManager).
        enable = true;
        touchpad = {
          naturalScrolling = true;
          tapping = true;
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
    };
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
    # This may be needed for Chromebook fingerprint login, idk
    fprintd.enable = true;
  };

  # Custom text once Chromebook fingerprint login is done
  # Example: https://github.com/NixOS/nixpkgs/issues/239770#issuecomment-1608589113
  # security.pam.services.kde-fingerprint.text = ''
  #   # Chromebook fingerprint PAM module will go here
  # '';
  environment = {
    systemPackages = with pkgs; [
      # Needed for KDE Plasma to fully function
      clinfo
      glxinfo
      vulkan-tools
      wayland-utils
      pciutils
      aha
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
