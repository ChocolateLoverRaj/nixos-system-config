{ pkgs, ... }:

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
    kdePackages.ksystemlog
    gnome.gnome-logs
    gparted
    kdePackages.partitionmanager
    usbutils
    kdePackages.isoimagewriter
    kdePackages.kclock
    # To manage packages in home folder
    home-manager
    # For distrobox and toolbox
    podman
    # Important for Chromebooks
    (pkgs.callPackage ./cros-ectool.nix { })
    # For new users to get started
    firefox
    google-chrome
    bottles
    kdePackages.dragon
    vlc
    niv
  ];
}
