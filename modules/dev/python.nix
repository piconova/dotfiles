{ pkgs, ... }: {
  home.packages = [
    pkgs.python3
    pkgs.python310Packages.pip
    pkgs.python310Packages.pandas
    pkgs.python310Packages.python-lsp-server
  ];

  home.sessionVariables = {
    PANDAS_PATH = "${pkgs.python310Packages.pandas}/lib/python3.10/site-packages/";
  };
}
