{ ... }:

{
  # Configure keyd to make Windows keyboards more like Chromebook keyboards
  services.keyd = {
    enable = true;
    keyboards = {
      # Logitech USB Keyboard
      logitech = {
        ids = [
          "046d:404b:faa63729"
        ];
        settings = {
          main = {
            capslock = "leftmeta";
            meta = "leftalt";
          };
          alt = {
            backspace = "delete";
            capslock = "capslock";
          };
        };
      };
      # Lenovo Legion K510 Mini Pro Gaming Keyboard
      legionK510MiniPro = {
        ids = [
          "17ef:619a:fabf0917"
          "17ef:619a:e55db114"
          "17ef:619a:d770f149"
        ];
        settings = {
          main = {
            capslock = "leftmeta";
            meta = "leftalt";
            # Make certain keys do actions by default instead of F#
            f6 = "mute";
            mute = "f6";

            f7 = "volumedown";
            volumedown = "f7";

            f8 = "volumeup";
            volumeup = "f8";

            f9 = "playpause";
            playpause = "f9";

            f10 = "previoussong";
            previoussong = "f10";

            f11 = "nextsong";
            nextsong = "f11";

            # Remap the copilot key
            "leftshift+leftmeta+f23" = "rightcontrol";
          };
          alt = {
            backspace = "delete";
            capslock = "capslock";
          };
        };
      };
    };
  };
}
