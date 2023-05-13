{ pkgs, config, tools, ... }: {
  programs.vscode = {
    enable = true;
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./extensions.g.nix) ++ [];
  };

  home.activation.vscode-settings = tools.createSymlink {
    source = "modules/vscode/settings.jsonc";
    target = ".config/Code/User/settings.json";
  };

  home.activation.vscode-keybindings = tools.createSymlink {
    source = "modules/vscode/keybindings.jsonc";
    target = ".config/Code/User/keybindings.json";
  };
}
