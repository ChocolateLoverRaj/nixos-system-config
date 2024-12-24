{ pkgs, ... }:

{
  services.immich = {
    enable = true;
    environment.IMMICH_MACHINE_LEARNING_URL = "http://localhost:3003";
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs;
      [
        intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      ];
  };
  users.users.immich.extraGroups = [ "video" "render" ];
}
