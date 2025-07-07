{ pkgs, ... }:
 {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ 
    
    # Git and Dev essentials
    git	  
    gh
    gnupg
    claude-code
    tree
    docker

    # asdf
    asdf-vm

    # Databases
    postgresql_16

    # Editors
    vim
    helix

    # Node
    nodejs-slim_20
    nodePackages.npm

    # Nix
    hydra-check
    nil
    nixfmt-rfc-style

    # Python
    pipenv
    python3
    python3Packages.pip

    # Erlang
    erlang_26
    rebar3

    # Elixir
    elixir
    elixir_ls

    # Gleam
    gleam
    
    # Fly.IO
    awscli
    azure-cli
    flyctl
    
    # Shell
    zsh
    zsh-autosuggestions
    zsh-nix-shell
    zsh-syntax-highlighting
    ];


  homebrew = {
    enable = true;
    casks = [
      # Browser
      "arc"
      "google-chrome"

      # Mac Essentials
      "rectangle"
      "raycast"


      # Dev Utils
      "ghostty"
      "visual-studio-code"
      "cursor"
    ];
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set the primary user for the system.
  system.primaryUser = "fparadas";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # OsX Settings
  security.pam.services.sudo_local.touchIdAuth = true;
  system.defaults = {
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
    };
    loginwindow.LoginwindowText = "Bom dia, Felipe!";
    screencapture.target = "clipboard";

    dock = {
      autohide = true;
      show-recents = false;
      mru-spaces = true;
      persistent-apps =[
        "/Applications/Ghostty.app"
        "/Applications/Arc.app"
      ];
      persistent-others = [
        "/Users/fparadas/Documents"
        "/Users/fparadas/Downloads"
      ];
      tilesize = 48;
    };
  };


  users.users.fparadas = {
    name = "fparadas";
    home = "/Users/fparadas";
  };


}

