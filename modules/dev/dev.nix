{ pkgs, lib, ... }: {

  home.packages = [
    pkgs.just
    pkgs.jq
    pkgs.yq-go
    pkgs.aws-workspaces
    pkgs.inotify-tools
    pkgs.tree
    pkgs.upx
    pkgs.file
    pkgs.patchelf
    pkgs.redis
    pkgs.redis-dump
  ];

  imports = [
    ./cpp.nix
    ./nix.nix
    ./python.nix
  ];

  home.sessionVariables = {
    NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
      pkgs.stdenv.cc.cc
    ];

    NIX_LD = "${pkgs.glibc}/lib/ld-linux-x86-64.so.2";
  };

}
