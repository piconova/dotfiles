{ pkgs, lib, theme, displays, ... }:
let
  # todo: simplify these scripts / improve reproducibility
  bluetoothScript = ./scripts/rofi-bluetooth.sh;
  wifiScript = ./scripts/rofi-wifi-menu.sh;
  powerMenuScript = ./scripts/rofi-power-menu.sh;

  mkMainBar = name: display: {
    id = "mainBar-${name}";
    output = [ display.interface ];
    ipc = true;
    escape = true;
    exclusive = true;
    fixed-center = true;
    passthrough = false;
    position = "top";
    layer = "top";
    height = 40;
    margin-bottom = 4;
    margin-left = 6;
    margin-right = 6;
    margin-top = 6;
    modules-left = [ "wlr/workspaces" ];
    modules-center = [ "clock" ];
    modules-right = [
      "custom/bluetooth"
      "network"
      "cpu"
      "memory"
      "disk"
      "battery"
      "custom/power"
    ];
    "wlr/workspaces" = {
      disable_scroll = true;
      on-click = "activate";
      persistent_workspaces = {
        "1" = [ ];
        "2" = [ ];
        "3" = [ ];
        "4" = [ ];
        "5" = [ ];
        "6" = [ ];
        "7" = [ ];
        "8" = [ ];
        "9" = [ ];
      };
    };
    clock = {
      format = "{: %A %I:%M %p}";
      tooltip = false;
    };
    "custom/bluetooth" = {
      interval = 5;
      on-click = bluetoothScript;
      exec = "${bluetoothScript} --status";
      tooltip = false;
    };
    network = {
      interval = 10;
      on-click = wifiScript;
      format-disconnected = " Disconnected";
      format-wifi = "<span color='#${theme.accent1}'>{icon}</span>  {essid}";
      format-ethernet = "<span color='#${theme.accent1}'></span>  Ethernet";
      format-icons = [ "" ];
      tooltip-format-wifi = ''
        Interface:  {ifname}
        Signal:     {signalStrength}%
        IP:         {ipaddr}
        Gateway:    {gwaddr}
        Speed Down: {bandwidthDownBytes}
        Speed Up:   {bandwidthUpBytes}
      '';
      tooltip-format-ethernet = ''
        Interface:  {ifname}
        IP:         {ipaddr}
        Gateway:    {gwaddr}
        Speed Down: {bandwidthDownBytes}
        Speed Up:   {bandwidthUpBytes}
      '';
    };
    cpu = {
      interval = 10;
      max-length = 100;
      format = "<span font='14' rise = '-2000' color='#${theme.blue}'></span> {usage}%";
    };
    memory = {
      interval = 10;
      max-length = 100;
      format = "<span font='13' rise = '-1000' color='#${theme.orange}'></span> {percentage}%";
    };
    disk = {
      interval = 10;
      max-length = 100;
      format = "<span font='12' rise = '0' color='#${theme.yellow}'></span> {percentage_used}%";
      tooltip-format = "{used} used out of {total}";
    };
    battery = {
      interval = 10;
      max-length = 100;
      states = {
        warning = 15;
        critical = 5;
      };
      format = "<span font='18' rise = '-4000' color='#${theme.green}'>{icon}</span> {capacity}%";
      format-critical = "<span font='18' rise = '-4000'>{icon}</span> {capacity}%";
      format-warning = "<span font='18' rise = '-4000' color='#${theme.yellow}'>{icon}</span> {capacity}%";
      format-charging = "<span color='#${theme.green}'> </span><span font='18' rise = '-4000' color='#${theme.green}'>{icon}</span> {capacity}%";
      format-icons = [ "" "" "" "" "" ];
      tooltip-format = "Draining {power:.2f}W \n{timeTo}";
      tooltip-format-charging = "Charging {power:.2f}W \n{timeTo}";
    };
    "custom/power" = {
      format = "";
      on-click = "rofi -show power-menu -modi power-menu:${powerMenuScript} -theme ~/.config/rofi/powermenu.rasi";
      tooltip = false;
    };
  };
  style = ''
    @define-color background #${theme.grey0};
    @define-color foreground #${theme.grey6};
    @define-color surface #${theme.grey3};

    * {
      border: none;
      font-family: "Sans Serif", "FontAwesome6Free";
      font-size: 14px;
      font-weight: 800;
      margin: 0;
      padding: 0;
      min-height: 0;
    }

    button:hover {
      box-shadow: none;
      text-shadow: none;
      padding: 0px;
      margin: 0px;
    }

    window#waybar {
      background-color: @background;
      border-radius: 40px;
    }

    #workspaces {
      padding: 7px;
      padding-top: 7px;
      padding-bottom: 7px;
    }

    #workspaces button {
      padding: 0px 6px;
      margin-right: 6px;
      background-color: transparent;
      color: @foreground;
      font-weight: 800;
      border: none;
      border-radius: 0;
      outline: none;
      min-height: 0;
    }

    #workspaces button:hover {
      background: @surface;
      color: @foreground;
      transition-duration: 0s;
      border-radius: 40px;
      border-color: transparent;
    }

    #workspaces button.active {
      background: #${theme.accent1};
      color: @background;
      border-radius: 40px;
      border: none;
    }

    #workspaces button.urgent {
      background-color: #${theme.red};
    }

    #clock,
    #battery,
    #cpu,
    #memory,
    #disk,
    #temperature,
    #backlight,
    #network,
    #pulseaudio,
    #custom-media,
    #custom-bluetooth,
    #tray,
    #mode,
    #idle_inhibitor,
    #mpd {
      padding: 0 10px;
      color: @foreground;
    }

    #window,
    #workspaces {
      margin: 0 4px;
    }

    .modules-left > widget:first-child > #workspaces {
      margin-left: 0;
    }

    /* If workspaces is the rightmost module, omit right margin */
    .modules-right > widget:last-child > #workspaces {
      margin-right: 0;
    }

    #clock {
      font-size: 16px;
    }

    #custom-power {
      border-radius: 40px;
      transition-duration: 0s;
      background: #${theme.red};
      color: #${theme.grey5};
      margin: 6px;
      padding: 0px 8px;
    }

    #custom-power:hover {
      background: #${theme.grey5};
      color: #${theme.red};
    }

    #custom-bluetooth {
      color: @foreground;
    }

    #battery.charging span,
    #battery.plugged span {
      color: #${theme.green};
    }

    @keyframes blink {
      to {
        /* background-color: @foreground; */
        color: #${theme.red};
      }
    }

    #battery.critical:not(.charging) {
      /* background-color: #${theme.red}; */
      color: @foreground;
      animation-name: blink;
      animation-duration: 0.7s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }

    #network {
      margin: 6px 0px;
      padding: 0px 8px;
      border-radius: 6px;
      transition-duration: 150ms;
    }

    #network:hover {
      background: @surface;
      /* color: @background; */
    }

    /* #network.disconnected {}
    #pulseaudio {}
    #pulseaudio.muted {}
    #custom-media {
      min-width: 100px;
    }
    #custom-media.custom-spotify {}
    #custom-media.custom-vlc {}
    #temperature {}
    #temperature.critical {} */

    tooltip {
      transition-duration: 0.5s;
      background: @surface;
      padding: 30px;
      text-shadow: none;
      color: @foreground;
      border-radius: 10px;
    }

    tooltip * {
      padding: 5px;
      font-family: "JetBrains Mono";
    }
  '';
in
{
  programs.waybar = {
    enable = true;

    # package = pkgs.waybar.overrideAttrs (attrs: {
    #   mesonFlags = attrs.mesonFlags ++ [ "-Dexperimental=true" ];
    # });

    package = pkgs.waybar-hyprland;

    style = style;
    settings = lib.concatMapAttrs
      (name: display: {
        "mainBar-${name}" = mkMainBar name display;
      })
      displays;
  };
}
