{ ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  # This is just to make it more connenient and not have to enter a password
  users.users."rajas".extraGroups = [ "libvirtd" ];
}
