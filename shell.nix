# Import sources from `sources.nix` and packages from `nixpkgs`
{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs { }
}:

# Bring all the packages from `pkgs` into scope
with pkgs;

let
  # Inherit the `optional` and `optionals` functions from the `lib` package
  inherit (lib) optional optionals;

  # Define a list of base packages that will be included in the shell
  basePackages = [
    beam.packages.erlangR25.elixir_1_14
    pkgs.niv                                      # Include the `niv` package from `pkgs`
    fswatch                                       # Include the `fswatch` package
    gcc                                           # Include the `gcc` package
    ack                                           # Include the `ack` package
  ];

  # Define all the inputs for the shell, including base packages and additional packages based on the operating system
  # On Linux, include `inotify-tools` for `mix test.watch` (hot reloading, etc)
  inputs = basePackages ++ lib.optionals stdenv.isLinux [ inotify-tools ]
    ++ lib.optionals stdenv.isDarwin
    (with darwin.apple_sdk.frameworks; [ CoreFoundation CoreServices ]);

  # Define a multi-line string that contains shell commands to set up various environment variables
  hooks = ''
    # this isolates mix to work only in local directory
    mkdir -p .nix-mix .nix-hex
    export MIX_HOME=$PWD/.nix-mix
    export HEX_HOME=$PWD/.nix-hex

    # make hex from Nixpkgs available
    # `mix local.hex` will install hex into MIX_HOME and should take precedence
    export MIX_PATH="${beam.packages.erlangR25.hex}/lib/erlang/lib/hex/ebin"
    export PATH=$MIX_HOME/bin:$HEX_HOME/bin:$PATH
    export LANG=C.UTF-8
    export LC_CTYPE=en_US.UTF-8
    export LC_ALL=en_US.UTF-8

    # keep your shell history in iex
    export ERL_AFLAGS="-kernel shell_history enabled"

    export PATH=bin:$PATH
    export MIX_ENV=dev
  '';

in
# Create a shell with the specified inputs and shell hooks
mkShell {
  buildInputs = inputs;
  shellHook = hooks;

  # Set the `LOCALE_ARCHIVE` environment variable based on the operating system
  # This is necessary to avoid locale issues when using `nix-shell --pure` on NixOS
  LOCALE_ARCHIVE = if pkgs.stdenv.isLinux then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
}