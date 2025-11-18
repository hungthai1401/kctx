# Kubeconfig Switcher (kctx)

A bash script to quickly switch between multiple kubeconfig files stored in `~/.kube/configs` directory.

## Features

- List all available kubeconfig files
- Switch between configs with simple commands
- Interactive mode with fuzzy selection (requires fzf)
- Display currently active config
- Automatic backup of existing configs
- YAML validation (optional, requires yq)
- Connectivity testing with kubectl (optional)
- Works with both bash and zsh

## Installation

1. Download the script:
   ```bash
   curl -O https://raw.githubusercontent.com/your-repo/kubeconfig-switcher/main/kctx
   ```

2. Make it executable:
   ```bash
   chmod +x kctx
   ```

3. Move it to a directory in your PATH (optional):
   ```bash
   mv kctx /usr/local/bin/kctx
   ```

Or use the provided installation script:
   ```bash
   ./install.sh
   ```

## Setup

1. Create the configs directory:
   ```bash
   mkdir -p ~/.kube/configs
   ```

2. Place your kubeconfig files in `~/.kube/configs/` with `.yaml` or `.yml` extensions:
   ```
   ~/.kube/configs/
   ├── prod.yaml
   ├── staging.yaml
   ├── dev.yaml
   └── test.yml
   ```

## Usage

### Basic Commands

```bash
# Interactive mode (default)
./kctx

# Switch to a specific config
./kctx prod

# List all available configs
./kctx --list

# Show current active config
./kctx --current

# Show help
./kctx --help
```

### Interactive Mode with fzf

```bash
# Explicit interactive mode
./kctx --interactive

# Or just run without arguments
./kctx
```

The interactive mode uses fzf for fuzzy selection and shows the currently active config.

## How it Works

The script switches kubeconfig files by creating a symbolic link from `~/.kube/config` to the selected config file in `~/.kube/configs/`. This approach:

- Works with all kubectl-based tools
- Persists across shell sessions
- Allows easy switching without modifying environment variables
- Maintains a single source of truth for the active config

## Configuration

- **Configs directory**: `~/.kube/configs`
- **Default config location**: `~/.kube/config`
- **Supported file extensions**: `.yaml`, `.yml`

## Optional Dependencies

- **fzf**: For interactive fuzzy selection
- **yq**: For YAML validation of config files
- **kubectl**: For connectivity testing after switching

## Examples

### Setting up multiple environments

```bash
# Create configs directory
mkdir -p ~/.kube/configs

# Copy your kubeconfig files
cp production-kubeconfig.yaml ~/.kube/configs/prod.yaml
cp staging-kubeconfig.yaml ~/.kube/configs/staging.yaml
cp development-kubeconfig.yaml ~/.kube/configs/dev.yaml

# Switch to production
./kctx prod

# List all configs
./kctx --list
```

### Using with shell aliases

Add this to your `~/.bashrc` or `~/.zshrc`:

```bash
alias kswitch='./kctx'
```

Then you can use:
```bash
kswitch prod
kswitch --list
kswitch
```

## Error Handling

The script includes comprehensive error handling for:

- Missing configs directory (creates automatically)
- Invalid config files (YAML validation if yq is available)
- Non-existent config files
- Invalid command line arguments
- Missing optional dependencies

## Backups

When switching configs, if `~/.kube/config` exists and is not a symlink, the script automatically creates a backup with a timestamp:
```
~/.kube/config.backup.20231118_143022
```

## Troubleshooting

### "No kubeconfig files found"
- Make sure you have files in `~/.kube/configs/` with `.yaml` or `.yml` extensions
- Check that the files are readable and valid YAML

### "fzf not found"
- Install fzf: `brew install fzf` (macOS) or `apt install fzf` (Ubuntu)
- Or use non-interactive mode with explicit config names

### "kubectl not found"
- Install kubectl or skip the connectivity test
- The script will work without kubectl, just won't validate connectivity

## License

MIT License
