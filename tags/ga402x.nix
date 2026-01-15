{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./asus.nix
    # gmaing is fun with iwd, and not fun without iwd
    ../modules/iwd.nix
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
        "0b05:19b6:7a8b633b"
        "0b05:19b6:ef0c5324"
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

          # Remap f4 to f2 to rename things easier
          f4 = "f2";
          prog3 = "f4";

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
        meta = {
          f1 = "f1";
          f2 = "f2";
          f3 = "f3";
          f4 = "f4";
          f5 = "f5";
          f6 = "f6";
          f7 = "f7";
          f8 = "f8";
          f9 = "f9";
          f10 = "f10";
          f11 = "f11";
          f12 = "f12";
        };
      };
    };
  };

  # hardware.cpu.amd.ryzen-smu.enable = true;
  hardware.graphics.enable = true;
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    powerManagement = {
      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      enable = true;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      finegrained = true;
    };
    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = true;
    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      amdgpuBusId = "PCI:65:0:0";
      nvidiaBusId = "PCI:1:0:0";
      # I think this makes using a monitor through the HDMI port which is connected to the dGPU better
      reverseSync.enable = true;
    };
  };
}
