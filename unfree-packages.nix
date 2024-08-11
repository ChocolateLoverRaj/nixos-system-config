{ lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vevor-cups"
    "steam"
    "steam-original"
    "steam-run"
    "steam-jupiter-original"
    "steamdeck-hw-theme"
    "google-chrome"
  ];
}
