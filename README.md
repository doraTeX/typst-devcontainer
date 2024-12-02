# Typst Dev Container on macOS 

For more details, see [my blog post](https://qiita.com/doraTeX/items/e38a4a367822a968b440) (in Japanese).

## Preliminaries

### Software Requirements
* macOS
* Visual Studio Code (VS Code) + `Dev Containers` extension
* Docker Desktop for Mac

### Granting Permissions

* Add `/System/Library/Fonts` and `/Library/Fonts` to `File Sharing` list in Docker Desktop (`Settings` → `Resources` → `File Sharing`)
* Grant "Full Disk Access" permissions to `/Applications/Visual Studio Code.app` and `/Applications/Docker.app` in macOS System Settings.

## Setup Instructions

### Clone This Repository and Open it with VScode
```sh
git clone https://github.com/doraTeX/typst-devcontainer
cd typst-devcontainer
code .
```

### Reopen in Container

1. Open command palette with `Command + Shift + P`.
2. Type `reopen` and select `Dev Containers: Reopen in Container`.
3. Wait for container build completion. After that, you can start using Typst. All fonts included in macOS will also be available inside the Docker container.
