# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./chromebook-audio.nix
      ./keyd.nix
      ./virt-manager.nix
      ./flatpak.nix
      ./bootloader.nix
      ./users.nix
      ./zram.nix
      ./steam.nix
      ./de.nix
      ./sound.nix
      ./printing.nix
      ./bluetooth.nix
      ./podman.nix
      ./networking.nix
      ./locale.nix
      ./time-zone.nix
      ./packages.nix
      ./external-camera.nix
      ./ipu6.nix
      ./ld.nix
      ./waydroid.nix
      ./adb.nix
      ./screen-sharing.nix
    ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
