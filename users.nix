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
