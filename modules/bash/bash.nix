{ pkgs, lib, tools, ... }: {

  programs.bash = {
    enable = true;

    shellAliases = {
      icat = "kitty +kitten icat";
      ssh = "kitty +kitten ssh";
      yaml = "yq -P e";
    };

    sessionVariables = {
      KUBECONFIG = "~/.config/kube/config.yaml";
      NIXOS_OZONE_WL = 1;
      VISUAL = "vim";
      EDITOR = "vim";
      MOZ_ENABLE_WAYLAND = 1;
    };

    profileExtra = ''
      if [[ "$(tty)" == "/dev/tty1" ]]; then
        exec Hyprland
      fi
    '';

    initExtra = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';

    bashrcExtra = ''
    '';
  };

  home.file.".config/user-dirs.dirs".text = ''
    XDG_DESKTOP_DIR="$HOME/desktop"
    XDG_DOCUMENTS_DIR="$HOME/documents"
    XDG_DOWNLOAD_DIR="$HOME/downloads"
    XDG_VIDEOS_DIR="$HOME/videos"
    XDG_MUSIC_DIR="$HOME/music"
    XDG_PICTURES_DIR="$HOME/pictures"
    XDG_SCREENSHOTS_DIR="$HOME/pictures/screenshots"
  '';
}
