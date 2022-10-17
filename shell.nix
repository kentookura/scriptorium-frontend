{ inputs }:
let
  easy-ps = import inputs.easy-purescript-nix { inherit pkgs; };
  pkgs = import inputs.nixpkgs {
    config.allowUnfree = true;
    system = "x86_64-linux";
  };
in
pkgs.mkShell {
  buildInputs = with pkgs;
    with easy-ps; [
      entr
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.vscode-css-languageserver-bin
      nodejs-16_x
      nixpkgs-fmt
      purs
      purs-tidy
      psa
      spago
      purescript-language-server
      esbuild
    ];
  shellHook = ''
    export DIRENV_LOG_FORMAT=
    export PATH=$PATH:/home/kento/scriptorium-frontend/node_modules/.bin
    alias watch="find src | entr -s 'echo bundling; npm run bundle'"
    alias serve="find src | entr -s 'echo bundling; npm run serve'"
  '';
}
