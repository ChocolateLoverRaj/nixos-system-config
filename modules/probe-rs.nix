{ pkgs, ... }:

{
  services.udev.packages = with pkgs; [
    (writeTextFile {
      name = "probe-rs-udev-rules";
      text = builtins.readFile "${
        (fetchFromGitHub {
          owner = "probe-rs";
          repo = "webpage";
          rev = "7f669bcb78671a156957624acebfe4154ea1c5e8";
          hash = "sha256-Sb4bsCFLAB1lQ9a7QiX/qYDgoe9grrOk627BvYrHxOI=";
        })
      }/public/files/69-probe-rs.rules";
      destination = "/etc/udev/rules.d/69-probe-rs.rules";
    })
  ];
}
