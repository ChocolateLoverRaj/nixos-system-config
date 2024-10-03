{ pkgs, lib, config, ... }:

{
  options.tv-gaming.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = {
    services = {
      desktopManager = {
        plasma6 = {
          enable = lib.mkDefault config.tv-gaming.enable;
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
        enable = config.tv-gaming.enable;
        autoStart = true;
        desktopSession = "plasma";
        user = "gamer";
      };
      steamos = {
        useSteamOSConfig = false;
        enableBluetoothConfig = true;
        enableMesaPatches = true;
        enableSysctlConfig = true;
      };
      decky-loader = {
        enable = config.tv-gaming.enable;
        extraPackages = with pkgs; [ udev ];
        enableFHSEnvironment = true;
      };
    };
  };
}
