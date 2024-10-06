## Set up
Clone this repo into `/etc/nixos`. You can change the permissions of `/etc/nixos` to your username to make it nicer to edit.
Apply configuration based on the host name. For example, with Jinlon:
```bash
sudo nixos-rebuild switch --flake .#jinlon
```
