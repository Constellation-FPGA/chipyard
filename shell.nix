{ pkgs ? import <nixpkgs> {} }:

with pkgs.lib;

pkgs.mkShell {
  buildInputs = with pkgs; [
    svls      # SystemVerilog Language Server
    verilator # (System)Verilog Simulator/Compiler

    autoconf automake
    sbt

    # ChipYard Dependencies
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

  hardeningDisable = [ "all" ];

  shellHook = ''
    unset OBJCOPY
  '';
}
