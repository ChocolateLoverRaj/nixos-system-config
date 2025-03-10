{ lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "vevor-cups"
      "steam"
      "steam-original"
      "steam-run"
      "steam-jupiter-original"
      "steam-unwrapped"
      "steamdeck-hw-theme"
      "google-chrome"
      # "ipu6-camera-bins"
      # "ipu6-camera-bins-unstable"
      # "ivsc-firmware"
      # "ivsc-firmware-unstable"
    ];
}
