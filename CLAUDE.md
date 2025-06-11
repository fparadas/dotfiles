# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains dotfiles managed using Nix, specifically with the nix-darwin and home-manager frameworks. It's designed to configure a macOS system with various tools, applications, and settings in a declarative way.

## Architecture

The repository follows a standard Nix flake structure:

- `flake.nix`: The entry point that defines inputs (dependencies) and outputs (configurations)
- `config.nix`: System-wide configuration for nix-darwin
- `home.nix`: User-specific configuration using home-manager
- `config/*.nix`: Individual configuration modules for specific tools/applications

## Key Components

1. **Nix Darwin**: Manages macOS system configuration
2. **Home Manager**: Manages user-specific configuration
3. **Git**: Configured in `config/git.nix`
4. **ZSH**: Configured in `config/zsh.nix`

## Common Commands

### Building and Applying Configuration

```bash
# Build and switch to the configuration
darwin-rebuild switch --flake ~/dotfiles

# Check configuration without applying
darwin-rebuild check --flake ~/dotfiles

# Build without applying
darwin-rebuild build --flake ~/dotfiles
```

### Working with Nix Flakes

```bash
# Update flake inputs
nix flake update

# Lock specific input
nix flake lock --update-input nixpkgs
```

### Formatting Nix Files

```bash
# Format Nix files
nixfmt-rfc-style *.nix config/*.nix
```

## Development Workflow

1. Make changes to the relevant .nix files
2. Test changes with `darwin-rebuild check --flake ~/dotfiles`
3. Apply changes with `darwin-rebuild switch --flake ~/dotfiles`
4. Commit changes to Git

## Nix Resources

- [Nix Manual](https://nixos.org/manual/nix/stable/)
- [Nix Darwin Documentation](https://github.com/LnL7/nix-darwin)
- [Home Manager Documentation](https://nix-community.github.io/home-manager/)