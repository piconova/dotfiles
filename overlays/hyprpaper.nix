{ pkgs, config, lib, ... }: with lib;
let
  cfg = config.programs.hyprpaper;
in
{
  options.programs.hyprpaper = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        enable hyprpaper
      '';
    };

    ipc = mkOption {
      type = types.bool;
      default = true;
      description = ''
        turn this off if you want to save a little battery life
      '';
    };

    wallpapers = mkOption {
      type = types.attrsOf types.path;
      description = ''
        Wallpaper to apply to displays.
        This is a map where key is display and value is wallpaper
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.hyprpaper
    ];

    xdg.configFile."hypr/hyprpaper.conf" =
      let
        ipc = if cfg.ipc then "yes" else "no";
        wallpapers = lists.unique (attrsets.attrValues cfg.wallpapers);

        preloads = concatMapStrings (wallpaper: "preload = ${wallpaper}\n") wallpapers;
        displays = concatStrings (mapAttrsToList (display: wallpaper: "wallpaper = ${display},${wallpaper}\n") cfg.wallpapers);
      in
      {
        text = ''
          ipc = ${ipc}
        '' + preloads + displays;

        onChange = ''
          pkill hyprpaper || echo "hyprpaper not running"
          nohup hyprpaper &
        '';
      };
  };
}
