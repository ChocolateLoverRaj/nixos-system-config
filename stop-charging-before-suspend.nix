# Stops charging before suspend. This is to prevent the battery from charging all the way to 100% while Jinlon is sleeping.
{ pkgs, ... }:

let
  ectool = (pkgs.callPackage ./cros-ectool.nix { });
in
{
  powerManagement.powerDownCommands = ''
    ${ectool}/bin/ectool chargecontrol idle
  '';
}
