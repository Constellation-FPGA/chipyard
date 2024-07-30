{
  description = "Development shell for Chipyard";

  # Nixpkgs version to use
  inputs.nixpkgs.url = "nixpkgs/nixos-23.05";

  outputs = { self, nixpkgs }:
    let
      # System types to support.
      # I have only ever tested this on x86_64-linux, so we limit to that.
      supportedSystems = [ "x86_64-linux" ]; # "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
      {
        # This flake does not provide any packages
        packages = {};

        # This flake does not provide any packages, so it cannot have apps
        # either.
        # apps is meant to play with the "nix run" command.
        apps = {};

        # What we really want
        devShells = forAllSystems (system:
          let pkgs = nixpkgsFor.${system};
              gnumake43 = pkgs.gnumake.overrideAttrs (final: prev: rec {
                version = "4.3";
                src = pkgs.fetchurl {
                  url = "mirror://gnu/make/make-${version}.tar.gz";
                  sha256 = "sha256-4F/d5HxffKRctpfpc4lP9PXXnhO3UO1X17Ztje/Hjhk=";
                };
              });

              riscvNativeBuildInputs = with pkgs; [
                # ChipYard Dependencies
                gnumake43
                coreutils moreutils binutils
                flock
                bison
                flex
                autoconf automake
                gmp mpfr libmpc zlib
                vim git jdk17
                texinfo gengetopt
                expat libusb ncurses cmake
              ];

          in {
            default = pkgs.mkShell {
              nativeBuildInputs = riscvNativeBuildInputs;
              buildInputs = with pkgs; [
                svls      # SystemVerilog Language Server
                verilator # (System)Verilog Simulator/Compiler

                sbt
                scala

                perl perlPackages.ExtUtilsMakeMaker
                # Deps for poky
                python3 patch diffstat texinfo subversion chrpath git wget
                # Deps for qemu
                gtk3 pkg-config
                # Deps for firemarshall
                python3 python3Packages.pip
                rsync libguestfs texinfo expat ctags
                # Install dtc
                dtc

                # keep this line if you use bash
                bashInteractive
              ];

              # Ensure locales are present
              LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";

              hardeningDisable = [ "all" ];

              shellHook = ''
                # Unset $OBJCOPY for compiling glibc-based RISC-V toolchain
                unset OBJCOPY
                unset OBJDUMP
              '';
            };
          });
      };
}
