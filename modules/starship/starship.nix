{ pkgs, lib, ... }:
let
  toStarshipFormat = list: lib.strings.concatMapStrings (item: "$" + item) list;
in
{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = true;

      format = toStarshipFormat [
        "hostname"
        "username"
        "localip"
        "kubernetes"
        "directory"
        "git_branch"
        "git_commit"
        "git_state"
        "git_metrics"
        "git_status"
        "docker_context"
        "package"
        "c"
        "cmake"
        "dart"
        "deno"
        "golang"
        "haskell"
        "helm"
        "java"
        "kotlin"
        "lua"
        "nodejs"
        "python"
        "rust"
        "nix_shell"
        "conda"
        # "memory_usage"
        "env_var"
        "sudo"
        "cmd_duration"
        "line_break"
        "jobs"
        "time"
        "status"
        "container"
        "shell"
        "character"
      ];

      username = {
        show_always = true;
      };

      hostname = {
        disabled = false;
        ssh_only = false;
        format = "[\\[$hostname\\]]($style) ";
        style = "bold green";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[⤫](bold red)";
        vicmd_symbol = "[❮](bold green)";
      };

      git_commit = {
        tag_symbol = " tag ";
      };

      git_status = {
        disabled = true;
        # ahead = ">";
        # behind = "<";
        # diverged = "<>";
        # renamed = "r";
        # deleted = "x";
      };

      # todo: remove unused
      aws.symbol = "aws ";
      bun.symbol = "bun ";
      c.symbol = "C ";
      # cobol.symbol = "cobol ";
      conda.symbol = "conda ";
      # crystal.symbol = "cr ";
      cmake.symbol = "cmake ";
      # daml.symbol = "daml ";
      dart.symbol = "dart ";
      deno.symbol = "deno ";
      # dotnet.symbol = ".NET ";
      directory.read_only = " ro";
      docker_context = {
        symbol = "docker ";
        format = "via [$symbol]($style)";
      };
      # elixir.symbol = "exs ";
      # elm.symbol = "elm ";
      git_branch.symbol = "git ";
      golang.symbol = "go ";
      # hg_branch.symbol = "hg ";
      java.symbol = "java ";
      julia.symbol = "jl ";
      kotlin.symbol = "kt ";
      lua.symbol = "lua ";
      nodejs.symbol = "nodejs ";
      # memory_usage.symbol = "memory ";
      nim.symbol = "nim ";
      nix_shell.symbol = "nix ";
      # ocaml.symbol = "ml ";
      package = {
        disabled = true;
      };
      # perl.symbol = "pl ";
      # php.symbol = "php ";
      # pulumi.symbol = "pulumi ";
      # purescript.symbol = "purs ";
      python.symbol = "py ";
      # raku.symbol = "raku ";
      # ruby.symbol = "rb ";
      rust.symbol = "rs ";
      # scala.symbol = "scala ";
      # spack.symbol = "spack ";
      sudo.symbol = "sudo ";
      # swift.symbol = "swift ";
      # terraform.symbol = "terraform ";
      zig.symbol = "zig ";
    };
  };
}
