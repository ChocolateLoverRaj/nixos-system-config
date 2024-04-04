{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rajas = {
    isNormalUser = true;
    description = "Rajas";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "tty"
    ];
  };
}
