# For Chromebooks with a fingerprint reader
{ ... }:

{
  imports = [
    ../modules/chromebook-audio.nix
    ../modules/cros-fp.nix
  ];
}
