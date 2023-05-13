{ pkgs, ... }: {
  home.packages = [
    pkgs.bitwarden-cli
  ];

  home.sessionVariables = {
    BW_SESSION = import ../../secrets/bitwarden.nix;
  };
}
