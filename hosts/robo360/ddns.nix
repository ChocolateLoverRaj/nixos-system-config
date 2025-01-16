{ ... }:

{
  services.cloudflare-dyndns = {
    enable = true;
    domains = [ "immich.whats4meal.com" "wg.whats4meal.com" "iperf3.whats4meal.com" "sftp.whats4meal.com" ];
    apiTokenFile = "/etc/cloudflare-dyndns-api-token.env";
  };
}
