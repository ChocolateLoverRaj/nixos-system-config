{ ... }:

{
  fileSystems."/mnt/keys" = {
    device = "/dev/disk/by-uuid/2624-E2D0";
    fsType = "vfat";
    options = [ "nofail" ];
  };
}
