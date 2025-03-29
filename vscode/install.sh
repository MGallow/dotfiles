#!/bin/bash

# Make sure we have the VS Code directories
mkdir -p "$HOME/Library/Application Support/Code/User"
mkdir -p "$HOME/Library/Application Support/Code - Insiders/User"

# Symlink settings and keybindings for regular VS Code
ln -sf "$DOTFILES/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
ln -sf "$DOTFILES/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"

# Symlink settings and keybindings for VS Code Insiders
ln -sf "$DOTFILES/vscode/settings.json" "$HOME/Library/Application Support/Code - Insiders/User/settings.json"
ln -sf "$DOTFILES/vscode/keybindings.json" "$HOME/Library/Application Support/Code - Insiders/User/keybindings.json"

# Install extensions
code --install-extension davidanson.vscode-markdownlint
code --install-extension eamodio.gitlens
code --install-extension formulahendry.azure-storage-explorer
code --install-extension github.codespaces
code --install-extension github.copilot
code --install-extension github.copilot-chat
code --install-extension github.github-vscode-theme
code --install-extension github.remotehub
code --install-extension github.vscode-github-actions
code --install-extension github.vscode-pull-request-github
code --install-extension james-yu.latex-workshop
code --install-extension mechatroner.rainbow-csv
code --install-extension ms-azure-devops.azure-pipelines
code --install-extension ms-azuretools.azure-dev
code --install-extension ms-azuretools.vscode-azure-github-copilot
code --install-extension ms-azuretools.vscode-azureappservice
code --install-extension ms-azuretools.vscode-azurecontainerapps
code --install-extension ms-azuretools.vscode-azurefunctions
code --install-extension ms-azuretools.vscode-azureresourcegroups
code --install-extension ms-azuretools.vscode-azurestaticwebapps
code --install-extension ms-azuretools.vscode-azurestorage
code --install-extension ms-azuretools.vscode-azurevirtualmachines
code --install-extension ms-azuretools.vscode-cosmosdb
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-dotnettools.vscode-dotnet-runtime
code --install-extension ms-mssql.data-workspace-vscode
code --install-extension ms-mssql.mssql
code --install-extension ms-mssql.sql-database-projects-vscode
code --install-extension ms-ossdata.vscode-postgresql
code --install-extension ms-python.debugpy
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-python.vscode-python-envs
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-toolsai.jupyter-renderers
code --install-extension ms-toolsai.vscode-ai
code --install-extension ms-toolsai.vscode-ai-remote
code --install-extension ms-toolsai.vscode-jupyter-cell-tags
code --install-extension ms-toolsai.vscode-jupyter-slideshow
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension ms-vscode-remote.remote-ssh-edit
code --install-extension ms-vscode-remote.vscode-remote-extensionpack
code --install-extension ms-vscode.azure-account
code --install-extension ms-vscode.azure-repos
code --install-extension ms-vscode.azurecli
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.makefile-tools
code --install-extension ms-vscode.remote-explorer
code --install-extension ms-vscode.remote-repositories
code --install-extension ms-vscode.remote-server
code --install-extension ms-vscode.vscode-node-azure-pack
code --install-extension ms-vscode.vscode-speech
code --install-extension ms-vscode.vscode-websearchforcopilot
code --install-extension redhat.vscode-yaml
code --install-extension reditorsupport.r
code --install-extension snowflake.snowflake-vsc
code --install-extension tushortz.python-extended-snippets
code --install-extension vscode-icons-team.vscode-icons
code --install-extension whitphx.vscode-stlite

# Do the same for VS Code Insiders if it exists
if command -v code-insiders &> /dev/null; then
    code-insiders --install-extension davidanson.vscode-markdownlint
    code-insiders --install-extension eamodio.gitlens
    code-insiders --install-extension formulahendry.azure-storage-explorer
    code-insiders --install-extension github.codespaces
    code-insiders --install-extension github.copilot
    code-insiders --install-extension github.copilot-chat
    code-insiders --install-extension github.github-vscode-theme
    code-insiders --install-extension github.remotehub
    code-insiders --install-extension github.vscode-github-actions
    code-insiders --install-extension github.vscode-pull-request-github
    code-insiders --install-extension james-yu.latex-workshop
    code-insiders --install-extension mechatroner.rainbow-csv
    code-insiders --install-extension ms-azure-devops.azure-pipelines
    code-insiders --install-extension ms-azuretools.azure-dev
    code-insiders --install-extension ms-azuretools.vscode-azure-github-copilot
    code-insiders --install-extension ms-azuretools.vscode-azureappservice
    code-insiders --install-extension ms-azuretools.vscode-azurecontainerapps
    code-insiders --install-extension ms-azuretools.vscode-azurefunctions
    code-insiders --install-extension ms-azuretools.vscode-azureresourcegroups
    code-insiders --install-extension ms-azuretools.vscode-azurestaticwebapps
    code-insiders --install-extension ms-azuretools.vscode-azurestorage
    code-insiders --install-extension ms-azuretools.vscode-azurevirtualmachines
    code-insiders --install-extension ms-azuretools.vscode-cosmosdb
    code-insiders --install-extension ms-azuretools.vscode-docker
    code-insiders --install-extension ms-dotnettools.vscode-dotnet-runtime
    code-insiders --install-extension ms-mssql.data-workspace-vscode
    code-insiders --install-extension ms-mssql.mssql
    code-insiders --install-extension ms-mssql.sql-database-projects-vscode
    code-insiders --install-extension ms-ossdata.vscode-postgresql
    code-insiders --install-extension ms-python.debugpy
    code-insiders --install-extension ms-python.python
    code-insiders --install-extension ms-python.vscode-pylance
    code-insiders --install-extension ms-python.vscode-python-envs
    code-insiders --install-extension ms-toolsai.jupyter
    code-insiders --install-extension ms-toolsai.jupyter-keymap
    code-insiders --install-extension ms-toolsai.jupyter-renderers
    code-insiders --install-extension ms-toolsai.vscode-ai
    code-insiders --install-extension ms-toolsai.vscode-ai-remote
    code-insiders --install-extension ms-toolsai.vscode-jupyter-cell-tags
    code-insiders --install-extension ms-toolsai.vscode-jupyter-slideshow
    code-insiders --install-extension ms-vscode-remote.remote-containers
    code-insiders --install-extension ms-vscode-remote.remote-ssh
    code-insiders --install-extension ms-vscode-remote.remote-ssh-edit
    code-insiders --install-extension ms-vscode-remote.vscode-remote-extensionpack
    code-insiders --install-extension ms-vscode.azure-account
    code-insiders --install-extension ms-vscode.azure-repos
    code-insiders --install-extension ms-vscode.azurecli
    code-insiders --install-extension ms-vscode.cpptools
    code-insiders --install-extension ms-vscode.makefile-tools
    code-insiders --install-extension ms-vscode.remote-explorer
    code-insiders --install-extension ms-vscode.remote-repositories
    code-insiders --install-extension ms-vscode.remote-server
    code-insiders --install-extension ms-vscode.vscode-node-azure-pack
    code-insiders --install-extension ms-vscode.vscode-speech
    code-insiders --install-extension ms-vscode.vscode-websearchforcopilot
    code-insiders --install-extension redhat.vscode-yaml
    code-insiders --install-extension reditorsupport.r
    code-insiders --install-extension snowflake.snowflake-vsc
    code-insiders --install-extension tushortz.python-extended-snippets
    code-insiders --install-extension vscode-icons-team.vscode-icons
    code-insiders --install-extension whitphx.vscode-stlite
fi
