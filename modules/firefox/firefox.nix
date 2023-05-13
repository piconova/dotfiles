{ pkgs, tools, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;

    profiles = {
      safe = {
        id = 0;
        name = "Safe";
        settings = import ./settings.nix;
        userChrome = builtins.readFile ./userChrome.css;
        bookmarks = [
          {
            name = "Nix";
            toolbar = true;
            bookmarks = [
              {
                name = "Nix Search";
                url = "https://search.nixos.org/packages";
              }
              {
                name = "dotfiles";
                url = "https://github.com/piconova/dotfiles";
              }
              {
                name = "ChatGPT";
                url = "https://chat.openai.com/chat";
              }
            ];
          }
        ];

        # todo: revisit these
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin # Ad blocker
          clearurls # block tracking urls
          bitwarden # password manager
          refined-github # adds some niche features to github 
          (buildFirefoxXpiAddon {
            pname = "adaptive-tab-bar-color";
            version = "1.6.16";
            addonId = "ATBC@EasonWong";
            url = "https://addons.mozilla.org/firefox/downloads/file/4030388/adaptive_tab_bar_color-1.6.16.xpi";
            sha256 = "sha256-ypCG4mFiPHyu85RwdPiv8CxcoNAn9Ouw+Fy9CdUWWuQ=";
            meta = { };
          })
        ];

      };

      unsafe = {
        id = 1;
        name = "Unsafe";
      };
    };
  };
}
