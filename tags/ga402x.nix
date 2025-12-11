{ pkgs, ... }:

{
  imports = [
    ./asus.nix
  ];
  environment = {
    systemPackages = with pkgs; [
      keyd
    ];
  };
  services.keyd = {
    enable = true;
    keyboards.internal = {
      ids = [
        "0b05:19b6:d167885d"
      ];
      settings = {
        main = {
          capslock = "leftmeta";
          meta = "leftalt";

          # Do something like fn-lock for some keys that I like
          f1 = "mute";
          mute = "f1";

          f2 = "kbdillumdown";
          kbdillumdown = "f2";

          f3 = "kbdillumup";
          kbdillumup = "f3";

          f6 = "sysrq";
          "rightshift+leftmeta+s" = "f6";

          f7 = "brightnessdown";
          brightnessdown = "f7";

          f8 = "brightnessup";
          brightnessup = "f8";

          # Make the M4 key do play/pause
          prog1 = "playpause";
        };
        alt = {
          backspace = "delete";
          capslock = "capslock";
        };
      };
    };
  };
  # This might help, idk
  # boot.kernelPackages = pkgs.linuxPackages_latest;
}
