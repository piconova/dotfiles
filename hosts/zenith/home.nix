{ pkgs, inputs, host, user, ... }: {

  home = {
    username = user.name;
    homeDirectory = "/home/${user.name}";
    stateVersion = "22.05";
  };

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  _module.args = rec {
    displays.center = {
      interface = "eDP-1";
      refreshRate = 60;
      scale = 1;
      resolution = { height = 1080; width = 1920; };
      offset = { x = 0; y = 0; };
    };

    theme = import ../../modules/themes/nord.nix;
    tools = {
      createSymlink = { source, target }: {
        after = [ "writeBoundary" ];
        before = [ ];
        data = "ln -nfs /home/${user.name}/.dotfiles/${source} /home/${user.name}/${target}";
      };
    };
  };

  imports = [
    ../../modules/fonts/fonts.nix
    ../../modules/direnv/direnv.nix
    ../../modules/git/git.nix
    ../../modules/hypr/hyprland.nix
    ../../modules/hypr/hyprpaper.nix
    ../../modules/dunst/dunst.nix
    ../../modules/ssh/ssh.nix
    ../../modules/keychain/keychain.nix
    ../../modules/kitty/kitty.nix
    ../../modules/rofi/rofi.nix
    ../../modules/waybar/waybar.nix
    ../../modules/bash/bash.nix
    ../../modules/nushell/nushell.nix
    ../../modules/starship/starship.nix
    ../../modules/firefox/firefox.nix
    ../../modules/vscode/vscode.nix
    ../../modules/dev/dev.nix
    ../../modules/utils/utils.nix
    ../../modules/bitwarden/bitwarden.nix
    ../../modules/xonsh/xonsh.nix
  ];
}
