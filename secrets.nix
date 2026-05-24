let
  readFileOrNull = path: 
    if builtins.pathExists path
    then builtins.readFile path
    else null;

  desktop_may = readFileOrNull ./secrets/ssh/desktop_may_pub;
  desktop_host = readFileOrNull ./secrets/ssh/desktop_host_pub;
  
  laptop_may = readFileOrNull ./secrets/ssh/laptop_may_pub;
  laptop_host = readFileOrNull ./secrets/ssh/laptop_host_pub;
  
  pub_keys = builtins.filter builtins.isString [ 
    desktop_may desktop_host 
    laptop_may laptop_host 
  ];
  
  _ = if builtins.length pub_keys == 0 then abort "pub_keys must have at least one key" else null;
in {
  "secrets/wireguard/server_priv.age".publicKeys = pub_keys;
  "secrets/wireguard/home_psk.age".publicKeys = pub_keys; 
}
