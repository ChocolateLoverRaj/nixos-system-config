# Unfortunately some proprietary packages have to be used
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
      "munbyn-itpp941-cups"
      "geekbench"
      "nvidia-x11"
      "nvidia-settings"
    ];
}
