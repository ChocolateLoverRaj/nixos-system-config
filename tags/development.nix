# Used for machines that you want to do development on.
{ ... }:

{
  imports = [
    # For running virtual machines
    ../modules/virt-manager.nix
    # For doing custom Android ROM stuff
    ../modules/adb.nix
    # For developing DIY USB devices, such as with RP2040
    ../modules/diy-usb-devices.nix
    # For using toolbox / distrobox
    ../modules/podman.nix
    # For programming
    ../modules/docker.nix
  ];
}
