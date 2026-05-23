{ config, pkgs, ... }:
let
  wg-key-pub-home = builtins.readFile ../secrets/wireguard/home_pub;
in
{
  age.secrets.wg-server-priv.file = ../secrets/wireguard/server_priv.age;
  age.secrets.wg-home-psk.file = ../secrets/wireguard/home_psk.age;

  networking.wireguard.enable = true;

  # enable NAT
  networking.nat = {
    enable = true;
    enableIPv6 = false;
    externalInterface = "eno1";
    internalInterfaces = [ "wg0" ];
  };

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.6.0.1/24" ];
    listenPort = 51820;

    privateKeyFile = config.age.secrets.wg-server-priv.path;


    # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
    # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
    postSetup = ''
      ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.6.0.0/24 -o eno1 -j MASQUERADE
    '';

    # This undoes the above command
    postShutdown = ''
      ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.6.0.0/24 -o eno1 -j MASQUERADE
    '';

    peers = [
      {
        name = "Home";
        publicKey = wg-key-pub-home;
        presharedKeyFile = config.age.secrets.wg-home-psk.path;
        allowedIPs = [ "10.6.0.2/32" ];
      }
    ];
  };

  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  # Enable forwarding
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
}
