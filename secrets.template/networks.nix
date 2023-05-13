{}: {

  # Enterprise WiFi
  environment.etc = {
    "NetworkManager/system-connections/<Name>.nmconnection" = {
      mode = "0600";
      text = ''
        [connection]
        id=<Name>
        uuid=<UUID>
        type=wifi

        [wifi]
        mode=infrastructure
        ssid=<SSID>

        [wifi-security]
        key-mgmt=wpa-eap

        [802-1x]
        eap=peap;
        identity=<Username>
        password=<Password>
        phase2-auth=mschapv2

        [ipv4]
        method=auto

        [ipv6]
        addr-gen-mode=default
        method=auto

        [proxy]
      '';
    };
  };
}