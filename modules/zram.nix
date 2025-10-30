{ lib, ... }:

{
  services.zram-generator = {
    enable = true;
    settings = {
      zram0 = {
        # I've seen zram get a 4:1 compression ratio, so it doesn't hurt to leave it on
        zram-size = lib.mkForce "ram * 4";
        compression-algorithm = "zstd";
      };
    };
  };
  # https://wiki.archlinux.org/title/Zram#Optimizing_swap_on_zram
  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };
}
