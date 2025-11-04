{ ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
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
          "diy_usb_device"
          "podman"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJZPbMdG1jP0ciTUXDxDhhyPDNKulsQ2zr6dt3EUeg/k Rajas Paranjpe (ChocolateLoverRaj)"
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

      ajit = {
        isNormalUser = true;
        description = "Ajit";
        extraGroups = [
          "networkmanager"
          "dialout"
          "tty"
          "adbusers"
          "input"
        ];
      };

      jui = {
        isNormalUser = true;
        description = "Jui";
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

    groups = {
      diy_usb_device = { };
    };
  };
}
