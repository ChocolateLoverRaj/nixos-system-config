{ pkgs, ... }:

let
  ectool = (pkgs.callPackage ./cros-ectool.nix { });
  ectool-rs = (pkgs.callPackage ./ectool-rs.nix { });
in
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nano # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git # Required by home manager
    # General utilities that are nice to have for all users
    curl
    wget
    lf
    neofetch
    fastfetch
    bat
    gnome-logs
    gparted
    usbutils
    kdiskmark
    unrar-wrapper
    mosh
    fclones
    tree
    busybox
    gptfdisk
    # To manage packages in home folder
    home-manager
    # For distrobox and toolbox
    podman
    # Important for Chromebooks
    ectool
    # ectool-rs
    # For new users to get started
    firefox
    # bottles
    kdePackages.dragon
    vlc
    google-chrome
  ];
}
