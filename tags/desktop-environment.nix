# Common apps and stuff that only machines with a desktop environment (not servers) would need
{ pkgs, ... }:
{
  imports = [
    ../modules/sound.nix
    ../modules/flatpak.nix
  ];

  # Useful apps to have on all systems with a desktop environment
  environment.systemPackages = with pkgs; [
    # Useful for investigating issues
    gnome-logs
    # Useful for managing partitions
    gparted
    # Useful when gparted doesn't work
    kdePackages.isoimagewriter
    # Useful for benchmarking disks
    kdiskmark
    # Most reliable video player
    vlc
    # Good browser
    firefox
    tor-browser
  ];
}
