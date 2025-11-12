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
    # For running the MrChromebox firmware utility script
    dmidecode
  ];
  # For flashing firmware
  boot.kernelParams = [ "iomem=relaxed" ];
}
