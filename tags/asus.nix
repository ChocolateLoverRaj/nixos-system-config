{ pkgs, ... }:
{
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
    supergfxd.enable = false;
  };
}
