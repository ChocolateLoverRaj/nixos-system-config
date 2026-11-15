{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libusb1
      # For zed-spade extension
      ncurses
    ];
  };
}
