{ pkgs, ... }:

{
  services.udev.packages = with pkgs; [
    (writeTextFile {
      name = "All USB Devices udev Rules";
      text = ''
        # SUBSYSTEM=="usb", ATTRS{idVendor}=="0xc0de", ATTRS{idProduct}=="0xcafe", MODE="0660", GROUP="diy_usb_device"
      '';
      destination = "/etc/udev/rules.d/70-all-usb.rules";
    })
  ];
}
