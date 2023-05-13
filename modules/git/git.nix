{ pkgs, ... }:
let
  user = import ../../secrets/git.nix;
in
{
  home.packages = [
    pkgs.git-crypt
    pkgs.git-filter-repo
    pkgs.pinentry-curses
  ];

  programs.git = {
    enable = true;

    ignores = [
      "*~"
      "*.swp"
      "*.swa"
    ];

    aliases = {
      co = "checkout";
      l = "log --oneline";
      ll = "log --oneline --graph --decorate";
    };

    # view steps here: https://codex.so/gpg-verification-github
    signing = {
      signByDefault = true;
      key = "<${user.email}>";
    };

    iniContent = {
      user = {
        name = user.name;
        username = user.username;
        email = user.email;
      };
      init = {
        defaultBranch = "main";
      };
      github = {
        user = user.username;
        email = user.email;
      };
    };

    extraConfig = {
      pull.ff = "true";

      # NOTE: Required so that `go get` can fetch private repos
      # NOTE: cargo breaks if this is present in the config
      # So you have choose between rust or go (Or find a solution for this)
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
    };
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "tty";
  };

  home.sessionVariables = {
    GH_TOKEN = user.token;
  };
}
