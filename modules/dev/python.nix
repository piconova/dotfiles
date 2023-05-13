{ pkgs, ... }: {
  home.packages = [
    pkgs.python3
    pkgs.python310Packages.pip
    pkgs.python310Packages.python-lsp-server
  ];
}
