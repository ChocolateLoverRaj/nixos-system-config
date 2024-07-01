{ pkgs, ... }:

{
  services = {
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
  };

  users.users.gamer = {
    isNormalUser = true;
    description = "Gamer";
    extraGroups = [
      "networkmanager"
      "input"
    ];
  };

  jovian = {
    steam = {
      enable = true;
      autoStart = true;
      desktopSession = "plasma";
      user = "gamer";
    };
    steamos = {
      useSteamOSConfig = false;
    };
  };
}
