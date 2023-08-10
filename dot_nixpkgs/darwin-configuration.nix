{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
      pkgs.htop
      pkgs.git-annex
      pkgs.git
      pkgs.emacs    # Emacs 27.2
      pkgs.ripgrep
      # optional dependencies
      pkgs.coreutils # basic GNU utilities
      pkgs.fd
      pkgs.clang
      pkgs.sqlite
      pkgs.graphviz
      # pkgs.sqitch
      pkgs.exercism
      # pkgs.tmux
      # pkgs.podman
      pkgs.gdal
      pkgs.terraform
      # pkgs.telnet
      pkgs.inetutils
      pkgs.flyctl
      pkgs.mosh
      pkgs.axel
      pkgs.helix
      pkgs.alacritty
      # pkgs.lapack
      # pkgs.liblas
      # pkgs.balenaetcher
      pkgs.watch
      pkgs.tree
      pkgs.asdf
      pkgs.chezmoi
];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
