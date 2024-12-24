# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../unsecure-boot.nix
    ../../users.nix
    ../../zram.nix
    #../../networking.nix
    ../../locale.nix
    ../../time-zone.nix
    #../../auto-stop-charging.nix
    ../../nix-serve.nix
    # ../../docker.nix
    ../../ssh-server.nix
    ./packages.nix
    ./power.nix
    ./networking.nix
    ./nextcloud.nix
    ./photos.nix
    ./ddns.nix
    ./home-assistant.nix
    ./wireguard.nix
    ../../printing.nix
    ../../unfree-packages.nix
    ../../zfs.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
