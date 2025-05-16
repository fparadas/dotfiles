{ config, pkgs, lib, ... }:

{
  imports = [
    ./config/zsh.nix
    ./config/git.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "fparadas";
  home.homeDirectory = "/Users/fparadas";

  # GPG Configuration
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry_mac;
    extraConfig = ''
      allow-loopback-pinentry
      default-cache-ttl 600
      max-cache-ttl 7200
    '';
  };

  home.sessionVariables = {
    GPG_TTY = "$(tty)";
    GPG_AGENT_INFO = "";
    SSH_AUTH_SOCK = "$(gpgconf --list-dirs agent-ssh-socket)";
  };

  # Add GPG configuration to shell
  programs.zsh.initExtra = ''
    # GPG and SSH agent configuration
    export GPG_TTY=$(tty)
    gpg-connect-agent /bye >/dev/null 2>&1 || gpgconf --launch gpg-agent
  '';

  home.packages = with pkgs; [
    pinentry_mac
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.zsh.enable = true;
}
