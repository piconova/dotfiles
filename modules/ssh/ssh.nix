{ pkgs, ... }: {

  programs.ssh = {
    enable = true;
    matchBlocks = import ../../secrets/ssh.nix;
  };
}
