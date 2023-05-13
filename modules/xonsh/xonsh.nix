{ pkgs, config, tools, ... }: {
  home.packages = [
    pkgs.xonsh
  ];

  home.file.".config/xonsh/nix.xsh".text = ''
    if not ''${...}.get('__NIXOS_SET_ENVIRONMENT_DONE'):
        $PATH.add('${pkgs.bash}/bin')

        # Stash xonsh's ls alias, so that we don't get a collision
        # with Bash's ls alias from environment.shellAliases:
        _ls_alias = aliases.pop('ls', None)

        # Source the NixOS environment config.
        source-bash "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"

        # Restore xonsh's ls alias, overriding that from Bash (if any).
        if _ls_alias is not None:
            aliases['ls'] = _ls_alias
        del _ls_alias
  '';

  # home.file.xonsh-config = {
  #   source = ./rc.xsh;
  #   target = ".config/xonsh/rc.xsh";
  # };

  home.activation.xonsh-config = tools.createSymlink {
    source = "modules/xonsh/rc.xsh";
    target = ".config/xonsh/rc.xsh";
  };
}
