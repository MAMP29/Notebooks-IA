{
  description = "Informe de IA";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pythonEnv = pkgs.python313.withPackages (ps: with ps; [
          jupyterlab
          pandas
          scikit-learn
          matplotlib
          seaborn
          numpy
        ]);
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
           pythonEnv
           pkgs.zsh
           pkgs.oh-my-posh
          ];

          shellHook = ''
            echo "Entorno listo"

            if [ -n "$ZSH_VERSION" ]; then
              echo "Zsh detectado"
            else
              echo "Forzando Zsh..."
              exec zsh
            fi
          '';
        };
      });

}
