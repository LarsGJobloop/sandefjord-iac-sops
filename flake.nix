{
  description = "An backend project covering several advanced concepts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      withSystem = nixpkgs.lib.genAttrs [
        "x86_64-linux" # TODO! NOT Verified
        "x86_64-darwin" # TODO! NOT Verified
        "aarch64-linux" # TODO! NOT Verified
        "aarch64-darwin" # Verified
      ];
      withPkgs =
        callback:
        withSystem (
          system:
          callback (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true; # Terraform is unfree software
            }
          )
        );
    in
    {
      devShells = withPkgs (pkgs: {
        default = pkgs.mkShell {
          packages = [
            pkgs.terraform
            pkgs.sops
            pkgs.age
          ];
        };
      });

      formatter = withPkgs (pkgs: pkgs.nixfmt-rfc-style);
    };
}
