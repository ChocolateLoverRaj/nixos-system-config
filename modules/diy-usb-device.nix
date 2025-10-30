{ pkgs, ... }:

{
  services.udev.packages = with pkgs; [
    (writeTextFile {
      name = "probe-rs-udev-rules";
      text = builtins.readFile "${(fetchFromGitHub {
          owner = "probe-rs";
          repo = "webpage";
          rev = "c8dbcf00cef641117578aa3eccd26541b0e259f6";
          hash = "sha256-hZv+rZ+aY4sxfBgS2xxdLnfNQh9W1SvYGIBjGUIcPbg=";
        })}/src/static/files/69-probe-rs.rules";
      destination = "/etc/udev/rules.d/69-probe-rs.rules";
    })
    (writeTextFile {
      name = "All USB Devices udev Rules";
      text = ''
        SUBSYSTEM=="usb", ATTRS{idVendor}=="0xc0de", ATTRS{idProduct}=="0xcafe, MODE="0660", GROUP="diy_usb_device""
      '';
      destination = "/etc/udev/rules.d/70-all-usb.rules";
    })
  ];
}
