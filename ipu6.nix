{ pkgs, ... }:

{
  # Doesn't work yet but hopefully one day after an update it'll magically start working
  hardware.ipu6 = {
    enable = true;
    platform = "ipu6ep";
  };
}
