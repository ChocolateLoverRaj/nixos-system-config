{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    rajas = {
      isNormalUser = true;
      description = "Rajas";
      extraGroups = [
        "networkmanager"
        "wheel"
        "dialout"
        "tty"
        "adbusers"
        "input"
      ];
    };

    rujuta = {
      isNormalUser = true;
      description = "Rujuta";
      extraGroups = [
        "networkmanager"
        "wheel"
        "dialout"
        "tty"
        "adbusers"
        "input"
      ];
    };
  };
}
