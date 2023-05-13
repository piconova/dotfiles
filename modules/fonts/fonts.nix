{ pkgs, ... }:
let
  srcs = [
    # Put paths to custom font here
  ];
  files = builtins.concatStringsSep " " srcs;
  customFonts = pkgs.stdenv.mkDerivation {
    name = "CustomFonts";
    inherit srcs;

    phases = [ "installPhase" ];
    installPhase = ''
      local out=$out/share/fonts/opentype/
      for file in ${files}; do
        strippedFile=$(stripHash $file)
        cp $file $strippedFile
        install -m444 -Dt $out $strippedFile
      done
    '';
  };
in
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # customFonts
    noto-fonts
    font-awesome
    # (google-fonts.override {
    #   fonts = [
    #     "Poppins"
    #   ];
    # })
    (nerdfonts.override {
      fonts = [
        # "CascadiaCode"
        "JetBrainsMono"
      ];
    })
  ];
}
