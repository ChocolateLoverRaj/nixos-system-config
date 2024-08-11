{ pkgs, ... }:

{
  fileSystems."/mnt/gaming-computer" = {
    device = "rajas@gaming-computer:/";
    fsType = "fuse.sshfs";
    options = [
      "identityfile=/root/.ssh/id_ed25519"
      "idmap=user"
      "x-systemd.automount" #< mount the filesystem automatically on first access
      "allow_other" #< don't restrict access to only the user which `mount`s it (because that's probably systemd who mounts it, not you)
      "user" #< allow manual `mount`ing, as ordinary user.
      "_netdev"
    ];
  };
  fileSystems."/mnt/raspberry-pi" = {
    device = "rajas@raspberry-pi:/";
    fsType = "fuse.sshfs";
    options = [
      "identityfile=/root/.ssh/id_ed25519"
      "idmap=user"
      "x-systemd.automount" #< mount the filesystem automatically on first access
      "allow_other" #< don't restrict access to only the user which `mount`s it (because that's probably systemd who mounts it, not you)
      "user" #< allow manual `mount`ing, as ordinary user.
      "_netdev"
    ];
  };
  boot.supportedFilesystems."fuse.sshfs" = true;
  nix = {
    buildMachines = [
      {
        hostName = "ssh.whats4meal.com";
        system = "x86_64-linux";
        maxJobs = 100;
        speedFactor = 4;
        protocol = "ssh-ng";
      }
    ];
    distributedBuilds = true;
  };
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
  environment.systemPackages = with pkgs; [ cloudflared ];
}
