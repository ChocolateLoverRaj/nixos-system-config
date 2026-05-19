{ ... }:

{
  # Example for /etc/nixos/configuration.nix
  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
  };
}
