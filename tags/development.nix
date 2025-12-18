# Used for machines that you want to do development on.
{ ... }:

{
  imports = [
    # For running virtual machines
    ../modules/virt-manager.nix
    # For doing custom Android ROM stuff
    ../modules/adb.nix
    # For developing for STM32 and RP2040 microcontrollers
    ../modules/probe-rs.nix
    # For developing DIY USB devices, such as with RP2040
    ../modules/diy-usb-device.nix
    # For using toolbox / distrobox
    ../modules/podman.nix
    # For programming
    ../modules/docker.nix
  ];
}
