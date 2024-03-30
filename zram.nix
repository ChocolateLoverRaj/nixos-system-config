{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zram-generator
  ];
  services.zram-generator = {
    enable = true;
    settings = {
      zram0 = {
        zram-size = "ram * 4";
        compression-algorithm = "zstd";
      };
    };
  };
}
