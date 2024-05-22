{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.pkgs.linuxPackages_latest;
}
