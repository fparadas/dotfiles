{ pkgs, ... }:
 {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [ 
	  git	  

	  # Editors
	  vim
	  helix

	  # Node
	  nodejs-slim_20
	  nodePackages.npm

	  # Nix
	  hydra-check
    nil

	  # Python
	  pipenv
	  python3
	  python3Packages.pip

    # Elixir
    elixir
    elixir_ls

	  # Shell
	  zsh
	  zsh-autosuggestions
	  zsh-nix-shell
	  zsh-syntax-highlighting
        ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      nix.configureBuildUsers = true;
      nix.useDaemon = true;
      services.nix-daemon.enable = true;
      # OsX Settings
      security.pam.enableSudoTouchIdAuth = true;
      system.defaults = {
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        finder = {
          AppleShowAllExtensions = true;
          AppleShowAllFiles = true;
          FXPreferredViewStyle = "Nlsv";
        };
        loginwindow.LoginwindowText = "Bom dia, Felipe!";
        screencapture.location = "~/Pictures/screeenshots";

        dock = {
          autohide = true;
          mru-spaces = true;
          persistent-apps =[
            "/Applications/Alacritty.app"
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

      homebrew = {
        enable = true;
        casks = [
          # Browser
          "arc"


          # Dev Utils
          "alacritty"
          "docker"
          "insomnia"
          "visual-studio-code"
        ];
      };
    }

