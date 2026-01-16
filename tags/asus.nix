{ ... }:

{
  services = {
    # ROG Control Center lets you adjust:
    # - CPU power settings
    # - GPU thermal throttling temperature
    # - Keyboard RGB
    # - Fan curves
    asusd = {
      enable = true;
      # The graphical app
      enableUserService = true;
    };
    # Lets you switch between iGPU only, hybrid, and dGPU only graphics
    supergfxd.enable = true;
  };
}
