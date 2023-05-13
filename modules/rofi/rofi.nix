{ pkgs, config, theme, tools, ... }@args:
let
  themeRasi = ''
    * {
      base0: #${theme.base00};
      base1: #${theme.base01};
      base2: #${theme.base02};
      base3: #${theme.base03};
      base4: #${theme.base04};
      base5: #${theme.base05};
      base6: #${theme.base06};
      base7: #${theme.base07};
      base8: #${theme.base08};
      base9: #${theme.base09};
      base10: #${theme.base0A};
      base11: #${theme.base0B};
      base12: #${theme.base0C};
      base13: #${theme.base0D};
      base14: #${theme.base0E};
      base15: #${theme.base0F};

      spacing: 2;
      background-color: var(base0);

      background: var(base0);
      foreground: var(base4);

      normal-background: var(background);
      normal-foreground: var(foreground);
      alternate-normal-background: var(background);
      alternate-normal-foreground: var(foreground);
      selected-normal-background: var(base8);
      selected-normal-foreground: var(background);

      active-background: var(background);
      active-foreground: var(base10);
      alternate-active-background: var(background);
      alternate-active-foreground: var(base10);
      selected-active-background: var(base10);
      selected-active-foreground: var(background);

      urgent-background: var(background);
      urgent-foreground: var(base11);
      alternate-urgent-background: var(background);
      alternate-urgent-foreground: var(base11);
      selected-urgent-background: var(base11);
      selected-urgent-foreground: var(background);
    }

    element {
      padding: 6px 6px 6px 14px;
      spacing: 5px;
      border:  0;
      border-radius: 20;
      cursor:  pointer;
    }

    element normal.normal {
      background-color: var(normal-background);
      text-color: var(normal-foreground);
    }

    element normal.urgent {
      background-color: var(urgent-background);
      text-color: var(urgent-foreground);
    }

    element normal.active {
      background-color: var(active-background);
      text-color: var(active-foreground);
    }

    element selected.normal {
      background-color: var(selected-normal-background);
      text-color: var(selected-normal-foreground);
    }

    element selected.urgent {
      background-color: var(selected-urgent-background);
      text-color: var(selected-urgent-foreground);
    }

    element selected.active {
      background-color: var(selected-active-background);
      text-color: var(selected-active-foreground);
    }

    element alternate.normal {
      background-color: var(alternate-normal-background);
      text-color: var(alternate-normal-foreground);
    }

    element alternate.urgent {
      background-color: var(alternate-urgent-background);
      text-color: var(alternate-urgent-foreground);
    }

    element alternate.active {
      background-color: var(alternate-active-background);
      text-color: var(alternate-active-foreground);
    }

    element-text {
      background-color: rgba(0, 0, 0, 0%);
      text-color: inherit;
      highlight: inherit;
      cursor: inherit;
    }

    element-icon {
      background-color: rgba(0, 0, 0, 0%);
      size: 1.0000em;
      text-color: inherit;
      cursor: inherit;
    }

    window {
      padding: 10;
      width: 20%;
      border: 0;
      background-color: var(background);
      border-radius: 10;
      border: 3px;
      border-color: var(selected-normal-background);
    }

    mainbox {
      padding: 0;
    }

    message {
      margin: 0px 0px;
    }

    textbox {
      text-color: var(foreground);
      blink: false;
      placeholder-color: var(base4);
    }

    listview {
      border: 0;
      margin: 5px 0px;
      scrollbar: false;
      spacing: 2px;
      fixed-height: 0;
    }

    scrollbar {
      padding: 0;
      handle-width: 14px;
      border: 0;
      handle-color: var(base3);
    }

    button {
      spacing: 0;
      text-color: var(normal-foreground);
      cursor: pointer;
    }

    button selected {
      background-color: var(selected-normal-background);
      text-color: var(selected-normal-foreground);
    }

    inputbar {
      padding: 6px 14px;
      margin: 5px 0px;
      spacing: 0;
      text-color: var(normal-foreground);
      background-color: var(base3);
      children: [ entry ];
      border-radius: 30;
    }

    entry {
      spacing: 0;
      cursor: text;
      text-color: var(normal-foreground);
      background-color: var(base3);
    }
  '';

  configRasi = ''
    ${themeRasi}

    configuration {
      line-margin: 10;
      font: "Nato Sans Regular 11";
      terminal: "kitty";
      display-ssh: "";
      display-run: "";
      display-drun: "";
      display-window: "";
      display-combi: "";
      show-icons: false;
      hover-select: true;
      me-select-entry: "";
      me-accept-entry: [ MousePrimary ];
    }
  '';
in
{

  home.packages = [
    pkgs.rofi-wayland
  ];

  xdg.configFile = {
    "rofi/config.rasi".text = configRasi;

    "rofi/bluetooth.rasi".text = ''
      ${configRasi}

      configuration {
        font: "Noto Sans Mono Semi-bold 11";
      }

      listview {
        lines: 8;
      }
    '';

    "rofi/powermenu.rasi".text = ''
      ${configRasi}

      configuration {
        font: "Noto Sans Mono Semi-bold 11";
      }

      listview {
        lines: 3;
      }
    '';

    "rofi/wlan.rasi".text = ''
      ${configRasi}

      configuration {
        font: "Noto Sans Mono Semi-bold 11";
        lines: 10;
      }
    '';
  };
}

