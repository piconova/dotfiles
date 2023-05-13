{ pkgs, theme, ... }: {
  programs.kitty = {
    enable = true;

    keybindings = {
      "ctrl+c" = "copy_and_clear_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
    };

    settings = {
      shell = "nu";
      font_family = "JetBrains Mono Nerd Font";
      cursor_shape = "beam";
      copy_on_select = "clipboard";
      window_padding_width = "6";
      confirm_os_window_close = "0";
      touch_scroll_multiplier = "4.0";

      active_border_color = "#${theme.base03}";
      active_tab_background = "#${theme.grey0}";
      active_tab_foreground = "#${theme.grey6}";
      inactive_border_color = "#${theme.base01}";
      inactive_tab_background = "#${theme.base01}";
      inactive_tab_foreground = "#${theme.base04}";
      cursor = "#${theme.grey6}";
      background = "#${theme.grey0}";
      foreground = "#${theme.grey6}";
      selection_background = "#${theme.base05}";
      selection_foreground = "#${theme.base00}";
      tab_bar_background = "#${theme.base01}";
      url_color = "#${theme.base04}";

      color0 = "#${theme.base00}";
      color1 = "#${theme.base0B}";
      color2 = "#${theme.base0E}";
      color3 = "#${theme.base0D}";
      color4 = "#${theme.base09}";
      color5 = "#${theme.base0F}";
      color6 = "#${theme.base08}";
      color7 = "#${theme.base05}";
      color8 = "#${theme.base03}";
      color9 = "#${theme.base0C}";
      color10 = "#${theme.base01}";
      color11 = "#${theme.base02}";
      color12 = "#${theme.base04}";
      color13 = "#${theme.base06}";
      color14 = "#${theme.base0A}";
      color15 = "#${theme.base07}";
    };
  };
}
