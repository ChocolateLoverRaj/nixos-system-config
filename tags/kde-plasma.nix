{ pkgs, ... }:

{
  imports = [
    ./desktop-environment.nix
  ];
  services = {
    desktopManager = {
      plasma6 = {
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
    # Enable changing the monitor's display brightness through the OS!
    ddccontrol.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      # Needed for KDE Plasma to fully function
      clinfo
      mesa-demos
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
      # KDE Flatpak GUI
      kdePackages.discover
      libreoffice-qt
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
  hardware.bluetooth.enable = true;
}
