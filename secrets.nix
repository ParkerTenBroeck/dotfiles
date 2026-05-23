let
  desktop_may = builtins.readFile ./secrets/ssh/desktop_may_pub;
  desktop_host = builtins.readFile ./secrets/ssh/desktop_host_pub;
  pub_keys = [ desktop_may desktop_host ];
in {
  "secrets/wireguard/server_priv.age".publicKeys = pub_keys;
  "secrets/wireguard/home_psk.age".publicKeys = pub_keys; 
}
