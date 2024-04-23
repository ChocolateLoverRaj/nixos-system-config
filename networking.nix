{ ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  # For web development without any port restrictions
  networking.firewall.enable = false;
}
