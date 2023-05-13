{ pkgs, tools, ... }: {

  home.packages = [
    # pkgs.nushell
    pkgs.zoxide
    (pkgs.nushell.override { additionalFeatures = (p: p ++ [ "dataframe" "sqlite" ]); })
  ];

  # services.pueue = {
  #   enable = true;
  #   settings = {
  #     shared = { };
  #     client = { };
  #     daemon = {
  #       default_parallel_tasks = 100;
  #     };
  #   };
  # };

  home.file.nushell-config = {
    source = ./config/config.nu;
    target = ".config/nushell/config.nu";
  };

  home.file.nushell-env = {
    source = ./config/env.nu;
    target = ".config/nushell/env.nu";
  };

  home.file.nushell-starship = {
    source = ./config/starship.nu;
    target = ".config/nushell/starship.nu";
  };

  # home.file.nushell-zoxide = {
  #   source = ./config/zoxide.nu;
  #   target = ".config/nushell/zoxide.nu";
  # };

  home.activation.nushell-user-scripts = tools.createSymlink {
    source = "secrets/nushell";
    target = ".config/nushell/scripts";
  };
}
