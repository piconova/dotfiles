# list all recipes
list:
  @just --list --unsorted

# apply system configuration
system:
  time sudo nixos-rebuild switch --flake path:.#

# apply home configuratioon
home: 
  time nix run path:.#homeManagerConfigurations.$(hostname).activationPackage --verbose

update:
  nix flake update

clean:
  nix-store --gc

# generate and push ssh keys
setup-ssh-keys:
  ssh-keygen -t ed25519 -b 512 -C $(hostname) -f ~/.ssh/github
  gh ssh-key add -t $(hostname) ~/.ssh/github.pub

# generate and push gpg keys
setup-gpg-keys:
  gpg2 --batch --quick-generate-key "Yogesh (Github) <133488020+piconova@users.noreply.github.com>" "ed25519/cert,sign+cv25519/encr" default
  gh gpg-key add <(gpg2 --armor --export '<133488020+piconova@users.noreply.github.com>')

# start waybar in autoreload mode
waybar-dev:
  #!/usr/bin/env bash

  CONFIG_FILES="$HOME/.config/waybar/config $HOME/.config/waybar/style.css"

  while true; do
      pkill waybar
      # env GTK_DEBUG=interactive waybar &
      waybar -s ~/.config/waybar/style.css -c ~/.config/waybar/config &
      inotifywait -e create,modify,delete $CONFIG_FILES
  done

# generate extensions.g.nix
vscode-extensions: 
  bash modules/vscode/generate_extensions.sh > modules/vscode/extensions.g.nix
