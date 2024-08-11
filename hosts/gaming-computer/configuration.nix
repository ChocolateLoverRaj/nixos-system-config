# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../virt-manager.nix
      ../../secure-boot.nix
      ../../users.nix
      ../../zram.nix
      ./tv-gaming.nix
      ../../sound.nix
      ../../printing.nix
      ../../bluetooth.nix
      ../../podman.nix
      ./networking.nix
      ../../locale.nix
      ../../time-zone.nix
      ../../packages.nix
      ../../external-camera.nix
      ../../adb.nix
      ../../screen-sharing.nix
      ../../nix-serve.nix
      ../../kernel.nix
      ../../ssh-server.nix
      ../../ld.nix
      ../../docker.nix
      ../../mosh.nix
      ./manage-tv.nix
      ./heroic.nix
    ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow some unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vevor-cups"
    "steam"
    "steam-original"
    "steam-run"
    "steam-jupiter-original"
    "steamdeck-hw-theme"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
