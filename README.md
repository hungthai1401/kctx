# Kubeconfig Switcher (kctx)

A bash script to quickly switch between multiple kubeconfig files stored in `~/.kube/configs` directory.

## Features

- List all available kubeconfig files
- Switch between configs with simple commands
- Interactive mode with fuzzy selection (requires fzf)
- Display currently active config
- Support for nested directory organization
- Support for symlinked configs directory and config files
- Automatic backup of existing configs
- YAML validation (optional, requires yq)
- Connectivity testing with kubectl (optional)
- Works with both bash and zsh

## Installation

1. Download the script:
   ```bash
   curl -O https://raw.githubusercontent.com/hungthai1401/kctx/main/kctx
   ```

2. Make it executable:
   ```bash
   chmod +x kctx
   ```

3. Move it to a directory in your PATH (optional):
   ```bash
   sudo mv kctx /usr/local/bin/kctx
   ```

## Setup

1. Create the configs directory:
   ```bash
   mkdir -p ~/.kube/configs
   ```

2. Place your kubeconfig files in `~/.kube/configs/` with `.yaml` or `.yml` extensions. You can organize them in a flat structure or use nested directories:
   
   **Flat structure:**
   ```
   ~/.kube/configs/
   ├── prod.yaml
   ├── staging.yaml
   ├── dev.yaml
   └── test.yml
   ```
   
   **Nested structure (recommended for organization):**
   ```
   ~/.kube/configs/
   ├── prod/
   │   ├── main.yaml
   │   └── backup.yaml
   ├── staging/
   │   ├── cluster1.yaml
   │   └── cluster2.yaml
   ├── dev/
   │   ├── backend.yaml
   │   └── frontend.yaml
   └── local.yaml
   ```
   
   **With symlinks:**
   ```
   ~/.kube/configs/ -> /shared/kubeconfigs/  # Symlinked configs directory
   /shared/kubeconfigs/
   ├── prod/ -> /configs/production/         # Symlinked subdirectory
   ├── dev/
   │   ├── backend.yaml
   │   └── frontend.yaml -> ../shared-dev.yaml  # Symlinked file
   └── staging.yaml
   ```

## Usage

### Basic Commands

```bash
# Interactive mode (default)
kctx

# Switch to a specific config (flat structure)
kctx prod

# Switch to a nested config (full path)
kctx dev/backend

# List all available configs (shows nested paths)
kctx --list

# Show current active config
kctx --current

# Show help
kctx --help
```

### Interactive Mode with fzf

```bash
# Just run kctx (defaults to interactive mode)
kctx

# Or explicitly request interactive mode
kctx --interactive
```

The interactive mode uses fzf for fuzzy selection and shows the currently active config.

## How it Works

The script switches kubeconfig files by creating a symbolic link from `~/.kube/config` to the selected config file in `~/.kube/configs/`. This approach:

- Works with all kubectl-based tools
- Persists across shell sessions
- Allows easy switching without modifying environment variables
- Maintains a single source of truth for the active config

## Configuration

- **Configs directory**: `~/.kube/configs` (can be a symlink)
- **Default config location**: `~/.kube/config`
- **Supported file extensions**: `.yaml`, `.yml`
- **Nested directories**: Supported for organizing configs
- **Symlinks**: Full support for symlinked configs directory and config files

## Optional Dependencies

- **fzf**: For interactive fuzzy selection
- **yq**: For YAML validation of config files
- **kubectl**: For connectivity testing after switching


## Error Handling

The script includes comprehensive error handling for:

- Missing configs directory (creates automatically)
- Broken symlinks in configs directory and config files (with helpful error messages)
- Invalid config files (YAML validation if yq is available)
- Non-existent config files (including nested paths)
- Invalid command line arguments
- Missing optional dependencies

## Troubleshooting

### "No kubeconfig files found"
- Make sure you have files in `~/.kube/configs/` with `.yaml` or `.yml` extensions
- Check that the files are readable and valid YAML
- Verify the configs directory exists or the symlink is valid

### "Configs symlink points to non-existent directory"
- Check if your `~/.kube/configs` symlink points to a valid directory
- Update or recreate the symlink to point to the correct location

### "Config file not found"
- Use the full path for nested configs (e.g., `dev/cluster1` instead of just `cluster1`)
- Verify the file exists with the correct extension (.yaml or .yml)
- Check the file permissions

### "fzf not found"
- Install fzf: `brew install fzf` (macOS) or `apt install fzf` (Ubuntu)
- Or use non-interactive mode with explicit config names

### "kubectl not found"
- Install kubectl or skip the connectivity test
- The script will work without kubectl, just won't validate connectivity

## License

MIT License
