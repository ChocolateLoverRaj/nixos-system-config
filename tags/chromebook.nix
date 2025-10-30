# Chromebook-specific tweaks
{ pkgs, ... }:
{
  imports = [
    ../modules/chromebook-audio.nix
    ../modules/cros-fp.nix
  ];
  environment.systemPackages = with pkgs; [
    # The Framework ectool works well enough for Chromebooks
    # The ChromeOS ectool is not packaged
    fw-ectool
    dmidecode
  ];
  boot.kernelParams = ["iomem=relaxed"];
}
