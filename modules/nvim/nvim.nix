{ pkgs, tools, ...}: {
  home.packages = [
    pkgs.neovim
  ];

  home.activation.nvim = tools.createSymlink {
    source = "modules/nvim/config";
    target = ".config/nvim";
  };

}
