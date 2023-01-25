{ pkgs ? import <nixpkgs> {} }:

with pkgs.lib;

let
  gnumake43 = pkgs.gnumake.overrideAttrs (final: prev: rec {
    version = "4.3";
    src = pkgs.fetchurl {
      url = "mirror://gnu/make/make-${version}.tar.gz";
      sha256 = "sha256-4F/d5HxffKRctpfpc4lP9PXXnhO3UO1X17Ztje/Hjhk=";
    };
  });

in pkgs.mkShell {
  buildInputs = with pkgs; [
    svls      # SystemVerilog Language Server
    verilator # (System)Verilog Simulator/Compiler

    autoconf automake
    sbt
    scala

    # ChipYard Dependencies
    gnumake43
    coreutils moreutils binutils
    bison
    flex
    gmp mpfr libmpc zlib
    vim git jdk17
    texinfo gengetopt
    expat libusb ncurses cmake
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
    unset OBJCOPY
  '';
}
