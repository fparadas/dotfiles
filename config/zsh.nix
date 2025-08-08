{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    history = {
      size = 100000;
      save = 2000000;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "history"
      ];
    };

    plugins = [
      {
        name = "nix-shell";
        file = "nix-shell.plugin.zsh";
        src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
      }
    ];
 
    initContent = ''

      # asdf
      . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
      autoload -Uz bashcompinit && bashcompinit
      . "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"
      
      # Detect which `ls` flavor is in use
      if ls --color > /dev/null 2>&1; then # GNU `ls`
              colorflag="--color"
              export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
      else # macOS `ls`
              colorflag="-G"
              export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
      fi

      # Always use color output for `ls`
      alias ls="command ls ''${colorflag}"

      # More colors!!!111
      export TERM='xterm-256color';

      export PATH="$PATH:/opt/homebrew/bin";
      export PATH="$PATH:$HOME/google-cloud-sdk/bin";
      export PATH="$HOME/.local/bin:$PATH";
    '';

    shellAliases = {

      # Reload the shell (i.e. invoke as a login shell)
      reload = "exec $SHELL -l";

      # Copy to clipboard
      pb = "pbcopy";
    };


  };
  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;
    format = "$shlvl$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
    shlvl = {
      disabled = false;
      symbol = "ﰬ";
      style = "bright-red bold";
    };
    shell = {
      disabled = false;
      format = "$indicator";
      fish_indicator = "";
      bash_indicator = "[BASH](bright-white) ";
      zsh_indicator = "[ZSH](bright-white) ";
    };
    username = {
      style_user = "bright-white bold";
      style_root = "bright-red bold";
    };
    hostname = {
      style = "bright-green bold";
      ssh_only = true;
    };
    nix_shell = {
      symbol = "";
      format = "[$symbol$name]($style) ";
      style = "bright-purple bold";
    };
    git_branch = {
      only_attached = true;
      format = "[$symbol$branch]($style) ";
      symbol = "שׂ";
      style = "bright-yellow bold";
    };
    git_commit = {
      only_detached = true;
      format = "[ﰖ$hash]($style) ";
      style = "bright-yellow bold";
    };
    git_state = {
      style = "bright-purple bold";
    };
    git_status = {
      style = "bright-green bold";
    };
    directory = {
      read_only = " ";
      truncation_length = 0;
    };
    cmd_duration = {
      format = "[$duration]($style) ";
      style = "bright-blue";
    };
    jobs = {
      style = "bright-green bold";
    };
    character = {
      success_symbol = "[\\$](bright-green bold)";
      error_symbol = "[\\$](bright-red bold)";
    };
  };
  programs.dircolors.enable = true;
  programs.dircolors.extraConfig = ''
    TERM alacritty
  '';
  programs.dircolors.settings = {
    ".iso" = "01;31"; # .iso files bold red like .zip and other archives
    ".gpg" = "01;33"; # .gpg files bold yellow
    # Images to non-bold magenta instead of bold magenta like videos
    ".bmp"   = "00;35";
    ".gif"   = "00;35";
    ".jpeg"  = "00;35";
    ".jpg"   = "00;35";
    ".mjpeg" = "00;35";
    ".mjpg"  = "00;35";
    ".mng"   = "00;35";
    ".pbm"   = "00;35";
    ".pcx"   = "00;35";
    ".pgm"   = "00;35";
    ".png"   = "00;35";
    ".ppm"   = "00;35";
    ".svg"   = "00;35";
    ".svgz"  = "00;35";
    ".tga"   = "00;35";
    ".tif"   = "00;35";
    ".tiff"  = "00;35";
    ".webp"  = "00;35";
    ".xbm"   = "00;35";
    ".xpm"   = "00;35";
  };
}
