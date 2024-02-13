{ pkgs ? import ../. {} }:
with pkgs;

mkShell {
  buildInputs = [
    openssl
    pkg-config
    eza
    fd
    rust-bin.beta.latest.default
  ];

  shellHook = ''
    alias ls=eza
    alias find=fd
  '';

}
