{ pkgs, ... }:

let ectool = (pkgs.callPackage ../../cros-ectool.nix { });
in {
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
    mosh
    btop
    gptfdisk
    parted
    # To manage packages in home folder
    home-manager
    # For distrobox and toolbox
    # podman
    # Important for Chromebooks
    ectool
    powertop
  ];
}
