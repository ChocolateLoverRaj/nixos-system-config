# file: configuration.nix
{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # For debugging and troubleshooting Secure Boot.
    sbctl
    # This is needed to auto-unlock LUKS with TPM 2 - https://discourse.nixos.org/t/full-disk-encryption-tpm2/29454/2
    tpm2-tss
  ];

  boot = {
    loader = {
      # Lanzaboote currently replaces the systemd-boot module.
      # This setting is usually set to true in configuration.nix
      # generated at installation time. So we force it to false
      # for now.
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    # This is needed to auto-unlock LUKS with TPM 2 - https://discourse.nixos.org/t/full-disk-encryption-tpm2/29454/2
    initrd.systemd.enable = true;
  };
}
