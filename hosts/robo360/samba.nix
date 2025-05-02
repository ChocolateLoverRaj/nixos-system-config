{ ... }:

{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "File Server";
        "security" = "user";
        # Needed for guest to work
        "guest account" = "nobody";
        "map to guest" = "Bad Password";
        # Only allow SMB on home network because it's not recommended to expose SMB to the internet
        "hosts allow" = "192.168. 127.0.0.1 localhost 100.118.30.62";
        # This stops Samba from creating annoying extended attributes for every file created / copied through Samba  
        "store dos attributes" = "no";
        # This makes it so that if the client writes and waits for physical disk write, Samba will actually wait until the physical disk is written to before saying it's done writing.
        "strict sync" = "yes";
      };
      "Parasave" = {
        "path" = "/mnt/para-z/para-save";
        "browseable" = "yes";
        "writeable" = "yes";
        # Allow access without username and password
        "guest ok" = "yes";
        # This makes it so that files created through SMB are accessible by all users
        "create mask" = "0777";
        "directory mask" = "0777";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall.allowPing = true;
}
