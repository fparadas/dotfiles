# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains dotfiles for macOS configured using Nix with nix-darwin and home-manager. It manages system configuration, packages, applications, and user settings declaratively for user `fparadas` on an ARM64 MacBook Pro (hostname: `Felipes-MacBook-Pro`).

## Architecture

### Core Structure

- **[flake.nix](flake.nix)**: Entry point defining inputs (nixpkgs, nix-darwin, home-manager) and the darwinConfiguration output
- **[config.nix](config.nix)**: System-wide nix-darwin configuration including:
  - System packages (development tools, AI tools, containers, databases)
  - Homebrew casks (Arc browser, Rectangle, Raycast, Ghostty)
  - macOS system defaults (Finder, Dock, login screen, Touch ID for sudo)
- **[home.nix](home.nix)**: User-specific home-manager configuration including:
  - GPG and SSH agent configuration
  - Direnv with nix-direnv integration
  - Imports of modular configurations
- **[config/](config/)**: Modular configuration files:
  - **[git.nix](config/git.nix)**: Git configuration with aliases, ignores, and merge drivers
  - **[zsh.nix](config/zsh.nix)**: ZSH with Oh My Zsh, Starship prompt, dircolors, asdf-vm integration
  - **[claude.nix](config/claude.nix)**: MCP (Model Context Protocol) server configuration for Claude Code

### Configuration Flow

The flake outputs `darwinConfigurations."Felipes-MacBook-Pro"` which:
1. Loads [config.nix](config.nix) for system-level settings
2. Integrates home-manager for user `fparadas`
3. Imports [home.nix](home.nix) which further imports modular configs from [config/](config/)

## Common Commands

### Building and Applying Configuration

```bash
# Build and switch (requires sudo for system changes)
sudo darwin-rebuild switch --flake ~/dotfiles

# Alternative without sudo (if no system-level changes needed)
darwin-rebuild switch --flake ~/dotfiles

# Check configuration without applying
darwin-rebuild check --flake ~/dotfiles

# Build without applying
darwin-rebuild build --flake ~/dotfiles

# Build specific host explicitly
darwin-rebuild switch --flake ~/dotfiles#Felipes-MacBook-Pro
```

### Managing Dependencies

```bash
# Update all flake inputs
nix flake update

# Update specific input (e.g., nixpkgs)
nix flake lock --update-input nixpkgs

# Show current flake metadata
nix flake metadata
```

### Formatting

```bash
# Format all Nix files
nixfmt-rfc-style *.nix config/*.nix
```

## Key Configuration Details

### System Packages

The configuration includes:
- **Development**: git, gh, gnupg, graphite-cli, jq, tree, asdf-vm
- **Containers**: podman, podman-tui, podman-compose, dive
- **AI Tools**: claude-code, gemini-cli, ollama
- **Languages**: Node.js 24, Python 3, Erlang/Elixir (BEAM), PostgreSQL 16
- **Editors**: vim, helix, code-cursor
- **Cloud CLIs**: flyctl, awscli, azure-cli
- **Shell**: zsh with plugins (autosuggestions, syntax-highlighting, nix-shell)

### macOS System Defaults

- Touch ID authentication for sudo
- Dark mode enabled
- Finder: show all extensions, all files, path bar
- Dock: autohide, no recents, persistent apps (Ghostty, Arc)
- Screenshots saved to clipboard

### Git Configuration

Custom aliases defined in [config/git.nix](config/git.nix):
- `git lol`: Graphical commit log
- `git publish`: Push current branch and set upstream
- `git unpublish`: Delete remote branch
- `git fzf`: Interactive branch switching with fzf preview

### Shell Configuration

- **ZSH** with Oh My Zsh and history plugin
- **Starship** prompt with custom symbols and format
- **asdf-vm** integration for version management
- **direnv** with nix-direnv for automatic environment loading

### Claude Code MCP Configuration

The [config/claude.nix](config/claude.nix) file configures MCP (Model Context Protocol) servers for Claude Code:

- **hexdocs-mcp**: Provides semantic search of HexDocs documentation for Elixir projects
  - Command: `npx -y hexdocs-mcp@0.5.0`
  - Automatically downloads binaries for fetching and searching documentation
  - Requires: Elixir and Mix installed (available via `beamMinimal28Packages.elixir` in [config.nix](config.nix))

The configuration is managed as `~/.claude/mcp-servers.json` and can be used with:

```bash
# Run Claude Code with the MCP configuration
claude --mcp-config ~/.claude/mcp-servers.json

# Or manually merge into ~/.claude.json under "mcpServers" key
```

## Platform Information

- **Architecture**: aarch64-darwin (Apple Silicon)
- **System State Version**: 5
- **Home Manager State Version**: 24.05
- **Allow Unfree**: Enabled