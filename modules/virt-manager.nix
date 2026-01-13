{ pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager = {
    enable = true;
  };
}
