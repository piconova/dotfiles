{ pkgs, host, user, ... }: {
  imports = [
    ./hardware.nix

    # declarative network management
    ../../secrets/networks.nix
  ];

  # ===============================================
  #                   Nix Config
  # ===============================================

  nix = {
    package = pkgs.nixVersions.stable;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    settings = {
      auto-optimise-store = true;
      keep-outputs = true;
      keep-derivations = true;

      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];

      experimental-features = [ "nix-command" "flakes" ];
      extra-sandbox-paths = [ "/bin/sh=${pkgs.bash}/bin/sh" ];
    };
  };

  # ===============================================
  #                    General
  # ===============================================

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  # ===============================================
  #                   Bootloader
  # ===============================================

  boot.loader = {
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      device = "nodev";
      configurationLimit = 4;
    };

    efi.canTouchEfiVariables = true;
  };

  # ===============================================
  #                   User
  # ===============================================
  users = {
    users.${user.name} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "network" "networkmanager" "audio" "mlocate" "docker" ];
      initialPassword = "123456"; # make sure to change password using passwd after first boot
    };

    groups = {
      network = { };
      mlocate = { };
      docker = { };
    };
  };

  # ===============================================
  #                   Services
  # ===============================================

  programs.nix-ld.enable = true;

  services.locate = {
    enable = true;
    interval = "hourly";
    locate = pkgs.mlocate;
    localuser = null;
  };

  # For some reason hyprland doesn't work without following
  programs.mtr.enable = true;
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        command = "${pkgs.greetd.gtkgreet}/bin/gtkgreet --time --cmd Hyprland";
        user = user.name;
      };
    };
  };

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };

  powerManagement.powertop.enable = true;

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  # required for adb to work without root
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  # ===============================================
  #                   Graphics
  # ===============================================

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };


  # ===============================================
  #                   Networking
  # ===============================================

  networking = {
    hostName = host.name;

    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
  };

  # ===============================================
  #                     Audio
  # ===============================================

  sound.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    settings.General.Enable = "Source,Sink,Media,Socket";
  };

  # ===============================================
  #                 Virtualization
  # ===============================================

  # virtualisation.libvirtd.enable = true;
  # environment.systemPackages = [ pkgs.virt-manager ];
  # users.users.${username}.extraGroups = [ "libvirtd" ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # users.users.${user.name}.extraGroups = [  ];


  # ===============================================
  #                   Security
  # ===============================================

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.swaylock = { };
  };

  # security tweaks borrowed from @hlissner
  boot.kernel.sysctl = {
    # The Magic SysRq key is a key combo that allows users connected to the
    # system console of a Linux kernel to perform some low-level commands.
    # Disable it, since we don't need it, and is a potential security concern.
    "kernel.sysrq" = 0;

    ## TCP hardening
    # Prevent bogus ICMP errors from filling up logs.
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

    # Reverse path filtering causes the kernel to do source validation of
    # packets received from all interfaces. This can mitigate IP spoofing.
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;

    # Do not accept IP source route packets (we're not a router)
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;

    # Don't send ICMP redirects (again, we're not a router)
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;

    # Refuse ICMP redirects (MITM mitigations)
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;

    # Protects against SYN flood attacks
    "net.ipv4.tcp_syncookies" = 1;

    # Incomplete protection again TIME-WAIT assassination
    "net.ipv4.tcp_rfc1337" = 1;

    ## TCP optimization
    # TCP Fast Open is a TCP extension that reduces network latency by packing
    # data in the sender’s initial TCP SYN. 
    # Setting 3 = enable TCP Fast Open for both incoming and outgoing connections:
    "net.ipv4.tcp_fastopen" = 3;

    # Bufferbloat mitigations + slight improvement in throughput & latency
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };

  boot.kernelModules = [ "tcp_bbr" ];

  system.stateVersion = "22.05"; # don't change this !!  
}
