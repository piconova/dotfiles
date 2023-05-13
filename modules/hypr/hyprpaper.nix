{ pkgs, lib, displays, ... }: with lib; {

  programs.hyprpaper = {
    enable = true;
    ipc = false;
    wallpapers = lib.concatMapAttrs
      (name: display: {
        ${display.interface} = ../../assets/wallpapers/light-house-teal.jpg;
      })
      displays;
  };
}
