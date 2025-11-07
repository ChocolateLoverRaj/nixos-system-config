{ ... }:

{
  services.openssh = {
    enable = true;
    openFirewall = true;
  };
  services.fail2ban.enable = true;
}
