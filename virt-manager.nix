{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    # Enable TPM, needed for Windows 11
    qemu = {
      package = pkgs.qemu_kvm;
      ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ];
      };
      swtpm.enable = true;
    };
  };
  programs.virt-manager.enable = true;
  # This is just to make it more connenient and not have to enter a password
  users.users."rajas".extraGroups = [ "libvirtd" ];
}
