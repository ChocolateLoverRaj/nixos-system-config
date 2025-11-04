# Contains common config for all of my NixOS machines
{ pkgs, lib, ... }:
{
  imports = [
    ../modules/users.nix
    ../modules/zram.nix
    ../modules/printing.nix
    ../modules/networking.nix
    ../modules/locale.nix
    ../modules/time-zone.nix
    ../modules/ssh-server.nix
    ../modules/ld.nix
    ../modules/unfree-packages.nix
    ../modules/zfs.nix
    ../modules/fonts.nix
    ../modules/gc.nix
    ../modules/ram-tmp.nix
    ../modules/windows-keyboard.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Common packages to have on every system
  environment.systemPackages = with pkgs; [
    # The terminal editor that I use
    nano
    # Another nice terminal editor
    msedit
    # Used by NixOS, and how I manage config
    git
    # Useful for downloading stuff
    curl
    wget
    # To manage packages in home folder
    home-manager
    # Miscellaneous commands
    lf
    neofetch
    fastfetch
    bat
    usbutils
    tree
    dua
    fclones
    tldr
    eza
    # This loops super duper cool
    btop
    # To check SMART status of disks
    smartmontools
  ];

  programs.screen = {
    enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = lib.mkDefault 1;
  };

  boot.supportedFilesystems = [ "ntfs" ];
}
