# For computers with graphics capable of playing most games
# Not for average integrated graphics
{ pkgs, ... }:

{
  imports = [
    ./light-gaming.nix
  ];
  environment.systemPackages = with pkgs; [
    # Rocket League requires an Epic Games store
    heroic
  ];
}
