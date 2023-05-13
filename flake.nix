{
  description = "dotfiles based on nixos";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
      # url = "github:yogeshkumar98103/nixpkgs/nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      # url = "github:yogeshkumar98103/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/2df0d034bc4a18fafb3524401eeeceaa6b23e753";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    androidNixpkgs = {
      url = "github:tadfisher/android-nixpkgs/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      # todo(yogesh): investigate why this didn't work
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      pkgsFor = system: import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        android_sdk.accept_license = true;

        overlays = [
          inputs.nur.overlay
          inputs.hyprland.overlays.default
          inputs.hyprland-contrib.overlays.default
        ];
      };

      buildHosts = { hosts, ... }: nixpkgs.lib.concatMapAttrs (_: { system, home, ... }: (system // home)) hosts;

      buildSystem = { host, user, ... }: {
        nixosConfigurations.${host.name} = nixpkgs.lib.nixosSystem {
          system = host.template.system;

          specialArgs = {
            inherit inputs host user;
            pkgs = pkgsFor host.template.system;
          };

          modules = [
            ./hosts/${host.template.name}/system.nix
          ];
        };
      };

      buildHome = { host, user, ... }: {
        homeManagerConfigurations.${host.name} = home-manager.lib.homeManagerConfiguration rec {
          pkgs = pkgsFor host.template.system;

          extraSpecialArgs = {
            inherit inputs host user pkgs;
          };

          modules = [
            inputs.hyprland.homeManagerModules.default
            ./overlays/hyprpaper.nix
            ./hosts/${host.template.name}/home.nix
          ];
        };
      };
    in
    buildHosts rec {
      templates = {
        dualBootWindows = {
          name = "zenith";
          system = "x86_64-linux";
        };
      };

      hosts = {
        zenith = rec {
          host = {
            name = "zenith";
            template = templates.dualBootWindows;
          };

          user = {
            name = "yogesh";
          };

          system = buildSystem { inherit host user; };
          home = buildHome { inherit host user; };
        };
      };
    };
}
