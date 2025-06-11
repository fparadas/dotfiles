# Personal dotfiles

My personal system configuration using Nix, nix-darwin and home-manager.

## Setup on a new machine

### 1. Install Nix

```bash
curl -L https://nixos.org/nix/install | sh
```

### 2. Enable flakes

```bash
mkdir -p ~/.config/nix

cat <<EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF
```

### 3. Clone this repository

```bash
git clone https://github.com/fparadas/dotfiles.git ~/dotfiles
```

### 4. Build and apply configuration

```bash
darwin-rebuild switch --flake ~/dotfiles
```

## Managing the configuration

### Rebuilding after changes

```bash
darwin-rebuild switch --flake ~/dotfiles
```

### Update dependencies

```bash
nix flake update
```

### Update specific input

```bash
nix flake lock --update-input nixpkgs
```

## Key files

- `flake.nix`: Entry point for Nix configuration
- `config.nix`: System-wide settings and packages
- `home.nix`: User-specific home-manager configuration
- `config/*.nix`: Individual configuration modules
