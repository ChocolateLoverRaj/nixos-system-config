{ ... }:

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
  boot.supportedFilesystems."fuse.sshfs" = true;
}
