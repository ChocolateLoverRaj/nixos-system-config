# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../chromebook-audio.nix
    ../../keyd.nix
    ../../virt-manager.nix
    ../../flatpak.nix
    ../../unsecure-boot.nix
    ../../users.nix
    ../../zram.nix
    ../../steam.nix
    # ../../kde-plasma.nix
    ../../gnome.nix
    ../../sound.nix
    ../../printing.nix
    ../../podman.nix
    ../../networking.nix
    ../../locale.nix
    ../../time-zone.nix
    ../../packages.nix
    # ../../external-camera.nix
    ../../waydroid.nix
    ../../adb.nix
    ../../screen-sharing.nix
    # ../../auto-stop-charging.nix
    # ../../stop-charging-before-suspend.nix
    ../../nix-serve.nix
    # ../../kernel.nix
    ./access-remote-machines.nix
    ../../fonts.nix
    ../../docker.nix
    ../../unfree-packages.nix
    ../../ssh-server.nix
    ../../graphics.nix
    ../../cros-fp.nix
    # ./debugging.nix
    ../../tailscale.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  networking.hostName = "jinlon";
}
