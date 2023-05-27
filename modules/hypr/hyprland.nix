{ pkgs, inputs, lib, displays, sysArgs, theme, ... }: {

  home.packages = [
    pkgs.dunst
    pkgs.brightnessctl
    pkgs.pamixer
    pkgs.grimblast
    pkgs.hyprpicker
    pkgs.wl-clipboard
    pkgs.flameshot
    pkgs.xdg-desktop-portal-hyprland
  ];

  wayland.windowManager.hyprland =
    let
      monitorConfig = lib.strings.concatStrings (
        builtins.attrValues (
          builtins.mapAttrs
            (name: display: ''
              $monitor-${name} = ${display.interface}
              monitor = $monitor-${name}, ${builtins.toString display.resolution.width}x${builtins.toString display.resolution.height}@${builtins.toString display.refreshRate}, ${builtins.toString display.offset.x}x${builtins.toString display.offset.y}, ${builtins.toString display.scale}
            '')
            displays
        )
      );

      brightnessScript = pkgs.writeShellScriptBin "brightness.sh" ''
        dunstify="${pkgs.dunst}/bin/dunstify"
        brightnessctl="${pkgs.brightnessctl}/bin/brightnessctl"

        msgId="69"
        $brightnessctl set $@ -q
        current=$($brightnessctl get)
        max=$($brightnessctl max)
        percent=$(( ($current * 100) / $max ))

        $dunstify -a "changeBrightness" -i ${../../assets/icons/brightness.png} -u low -r "$msgId" "Brightness: $percent%"
      '';

      volumeScript = pkgs.writeShellScriptBin "brightness.sh" ''
        dunstify="${pkgs.dunst}/bin/dunstify"
        pamixer="${pkgs.pamixer}/bin/pamixer"

        msgId="69"
        $pamixer $@ > /dev/null
        mute=$($pamixer --get-mute)
        volume=$($pamixer --get-volume)
        if [[ $volume = "0" ]] || [[ $mute = true ]]; then
            $dunstify -a "changeVolume" -i ${../../assets/icons/muted.png} -u low -r "$msgId" "Volume: muted" 
        else
            $dunstify -a "changeVolume" -i ${../../assets/icons/volume.png} -u low -r "$msgId" "Volume: $volume%"
        fi
      '';

      extraConfig = ''
        exec-once = ${pkgs.hyprpaper}/bin/hyprpaper
        exec-once = ${pkgs.waybar-hyprland}/bin/waybar
        # exec-once = xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2

        general {
          gaps_in = 3
          gaps_out = 6
          border_size = 4
          col.active_border = rgb(${theme.accent2})
          col.inactive_border = rgba(${theme.grey0}00)
          layout = master
        }

        input {
          kb_layout = us
          follow_mouse = 1

          repeat_delay = 200
          repeat_rate = 50
          sensitivity = 0.7

          touchpad {
            natural_scroll = 1
          }
        }

        decoration {
          rounding = 10
          blur = false
          shadow_offset = 2 3
          shadow_render_power = 3
          shadow_range = 4
          shadow_ignore_window = true
          col.shadow = 0x66080808
        }

        animations {
          enabled = 1
          animation = windows, 1, 4, default
          animation = windowsOut, 1, 4, default
          animation = border, 1, 4, default
          animation = fade, 1, 4, default
          animation = workspaces, 1, 4, default
        }

        gestures {
          workspace_swipe = 1
          workspace_swipe_fingers = 4
          workspace_swipe_distance = 500
          workspace_swipe_min_speed_to_force = 10
        }

        dwindle {
          preserve_split = true
          force_split = 2
          split_width_multiplier = 2.0
          default_split_ratio = 1.2
        }

        master {
          new_is_master = false
          allow_small_split = true
          mfact = 0.7
        }

        # Persistent workspaces
        wsbind = 1, $monitor-center
        wsbind = 2, $monitor-center
        wsbind = 3, $monitor-center
        wsbind = 4, $monitor-center
        wsbind = 5, $monitor-center
        wsbind = 6, $monitor-center
        wsbind = 7, $monitor-center
        wsbind = 8, $monitor-center
        wsbind = 9, $monitor-center

        # Brightness and Volume keys
        binde = ,XF86MonBrightnessUp, exec, ${brightnessScript} 5%+
        binde = ,XF86MonBrightnessDown, exec, ${brightnessScript} 5%-
        binde = ,XF86AudioMute, exec, ${volumeScript} --toggle-mute
        binde = ,XF86AudioRaiseVolume, exec, ${volumeScript} -i 5
        binde = ,XF86AudioLowerVolume, exec, ${volumeScript} -d 5

        # Application binding
        bind = SUPER, return, exec, ${pkgs.kitty}/bin/kitty
        bind = SUPER, b, exec, ${pkgs.firefox}/bin/firefox
        bind = SUPER, space, exec, ${pkgs.rofi}/bin/rofi -show drun
        bind = SUPER + SHIFT, s, exec, ${pkgs.grimblast}/bin/grimblast copy area
        bind = SUPER + SHIFT, p, exec, ${pkgs.hyprpicker}/bin/hypicker --autocopy

        # bind = SUPER,L,exec,swaylock --screenshots --effect-scale 0.3
        # bindl = ,switch:Lid Switch,exec,swaylock --image ~/Pictures/Wallpapers/default --effect-scale 0.1

        # Window management
        bind = SUPER, t, layoutmsg, togglesplit
        bind = SUPER, q, killactive
        bind = SUPER, m, layoutmsg, swapwithmaster master
        bindm = SUPER, mouse:272, movewindow
        bindm = SUPER + ALT, mouse:272, resizewindow

        # Resize window
        binde = SUPER + CTRL, left, resizeactive, -20 0
        binde = SUPER + CTRL, right, resizeactive, 20 0
        binde = SUPER + CTRL, up, resizeactive, 0 -20
        binde = SUPER + CTRL, down, resizeactive, 0 20

        # Toggle fullscreen
        bind = SUPER, f, fullscreen, 0
        # bind = SUPER, m, fullscreen, 1

        # Toggle floating
        bind = SUPER + SHIFT, f, togglefloating, active

        # Cycle workspace
        bind = SUPER, left, workspace, e-1
        bind = SUPER, right, workspace, e+1

        # Cycle windows
        bind = SUPER, j, layoutmsg, cyclenext
        bind = SUPER, k, layoutmsg, cycleprev
        bind = SUPER + SHIFT, j, layoutmsg, swapnext
        bind = SUPER + SHIFT, k, layoutmsg, swapprev

        # Switch to workspace
        bind = SUPER, 1, workspace, 1
        bind = SUPER, 2, workspace, 2
        bind = SUPER, 3, workspace, 3
        bind = SUPER, 4, workspace, 4
        bind = SUPER, 5, workspace, 5
        bind = SUPER, 6, workspace, 6
        bind = SUPER, 7, workspace, 7
        bind = SUPER, 8, workspace, 8
        bind = SUPER, 9, workspace, 9

        # Move to workspace
        bind = SUPER + SHIFT, 1, movetoworkspace, 1
        bind = SUPER + SHIFT, 2, movetoworkspace, 2
        bind = SUPER + SHIFT, 3, movetoworkspace, 3
        bind = SUPER + SHIFT, 4, movetoworkspace, 4
        bind = SUPER + SHIFT, 5, movetoworkspace, 5
        bind = SUPER + SHIFT, 6, movetoworkspace, 6
        bind = SUPER + SHIFT, 7, movetoworkspace, 7
        bind = SUPER + SHIFT, 8, movetoworkspace, 8
        bind = SUPER + SHIFT, 9, movetoworkspace, 9
      '';
    in
    {
      enable = true;
      systemdIntegration = true;
      extraConfig = monitorConfig + extraConfig;
    };
}
