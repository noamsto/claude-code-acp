{
  description = "Claude Code ACP - TypeScript coding agent";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = {
          default = pkgs.buildNpmPackage {
            pname = "claude-code-acp";
            version = "0.4.0";
            src = ./.;
            npmDepsHash = "sha256-vsFUg5DVsJ6ytEYAIhbgTtYGpkomtvb8vRxsQafdudY=";

            meta = {
              description = "An ACP-compatible coding agent powered by the Claude Code SDK";
              license = pkgs.lib.licenses.asl20;
              platforms = pkgs.lib.platforms.all;
            };
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs_22
            typescript
            nodePackages.npm
          ];

          shellHook = ''
            echo "Claude Code ACP development environment"
            echo "Node.js: $(node --version)"
            echo "TypeScript: $(tsc --version)"
            echo "npm: $(npm --version)"
            echo ""
            echo "Available commands:"
            echo "  npm run dev     - Build and start"
            echo "  npm run build   - Compile TypeScript"
            echo "  npm run test    - Run tests"
            echo "  npm run lint    - Lint code"
          '';
        };
      }
    );
}
