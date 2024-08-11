{ pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nano # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git # Required by home manager and nixos-rebuild
    curl
    wget
    lf
    neofetch
    fastfetch
    bat
    usbutils
    # To manage packages in home folder
    home-manager
  ];
}
