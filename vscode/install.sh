#!/bin/bash

# Settings and keybindings are managed by VS Code Settings Sync — not symlinked here.
# vscode/settings.json and vscode/keybindings.json in this repo serve as a reference
# snapshot only. To apply them manually, copy them into place; do not symlink.

# Install extensions — VS Code Insiders is primary
if command -v code-insiders &>/dev/null; then
    code-insiders --install-extension anthropic.claude-code --force
    code-insiders --install-extension astral-sh.ty --force
    code-insiders --install-extension charliermarsh.ruff --force
    code-insiders --install-extension davidanson.vscode-markdownlint --force
    code-insiders --install-extension docker.docker --force
    code-insiders --install-extension eamodio.gitlens --force
    code-insiders --install-extension formulahendry.azure-storage-explorer --force
    code-insiders --install-extension github.codespaces --force
    code-insiders --install-extension github.copilot --force
    code-insiders --install-extension github.copilot-chat --force
    code-insiders --install-extension github.github-vscode-theme --force
    code-insiders --install-extension github.remotehub --force
    code-insiders --install-extension github.vscode-github-actions --force
    code-insiders --install-extension github.vscode-pull-request-github --force
    code-insiders --install-extension google.geminicodeassist --force
    code-insiders --install-extension james-yu.latex-workshop --force
    code-insiders --install-extension mechatroner.rainbow-csv --force
    code-insiders --install-extension ms-azure-devops.azure-pipelines --force
    code-insiders --install-extension ms-azuretools.azure-dev --force
    code-insiders --install-extension ms-azuretools.vscode-azure-github-copilot --force
    # ms-azuretools.vscode-azure-mcp-server removed — incompatible with VS Code 1.98.x
    code-insiders --install-extension ms-azuretools.vscode-azureappservice --force
    code-insiders --install-extension ms-azuretools.vscode-azurecontainerapps --force
    code-insiders --install-extension ms-azuretools.vscode-azurefunctions --force
    code-insiders --install-extension ms-azuretools.vscode-azureresourcegroups --force
    code-insiders --install-extension ms-azuretools.vscode-azurestaticwebapps --force
    code-insiders --install-extension ms-azuretools.vscode-azurestorage --force
    code-insiders --install-extension ms-azuretools.vscode-azurevirtualmachines --force
    code-insiders --install-extension ms-azuretools.vscode-containers --force
    code-insiders --install-extension ms-azuretools.vscode-cosmosdb --force
    code-insiders --install-extension ms-azuretools.vscode-docker --force
    code-insiders --install-extension ms-dotnettools.vscode-dotnet-runtime --force
    code-insiders --install-extension ms-edgedevtools.vscode-edge-devtools --force
    code-insiders --install-extension ms-mssql.data-workspace-vscode --force
    code-insiders --install-extension ms-mssql.mssql --force
    code-insiders --install-extension ms-mssql.sql-bindings-vscode --force
    code-insiders --install-extension ms-mssql.sql-database-projects-vscode --force
    # ms-ossdata.vscode-postgresql removed — no longer in marketplace
    code-insiders --install-extension ms-python.anaconda-extension-pack --force
    code-insiders --install-extension ms-python.debugpy --force
    code-insiders --install-extension ms-python.flake8 --force
    code-insiders --install-extension ms-python.python --force
    code-insiders --install-extension ms-python.vscode-pylance --force
    code-insiders --install-extension ms-python.vscode-python-envs --force
    code-insiders --install-extension ms-toolsai.datawrangler --force
    code-insiders --install-extension ms-toolsai.jupyter --force
    code-insiders --install-extension ms-toolsai.jupyter-keymap --force
    code-insiders --install-extension ms-toolsai.jupyter-renderers --force
    code-insiders --install-extension ms-toolsai.vscode-ai --force
    code-insiders --install-extension ms-toolsai.vscode-ai-remote --force
    code-insiders --install-extension ms-toolsai.vscode-jupyter-cell-tags --force
    code-insiders --install-extension ms-toolsai.vscode-jupyter-slideshow --force
    code-insiders --install-extension ms-vscode-remote.remote-containers --force
    code-insiders --install-extension ms-vscode-remote.remote-ssh --force
    code-insiders --install-extension ms-vscode-remote.remote-ssh-edit --force
    code-insiders --install-extension ms-vscode-remote.vscode-remote-extensionpack --force
    code-insiders --install-extension ms-vscode.azure-account --force
    code-insiders --install-extension ms-vscode.azure-repos --force
    code-insiders --install-extension ms-vscode.azurecli --force
    code-insiders --install-extension ms-vscode.cpptools --force
    code-insiders --install-extension ms-vscode.makefile-tools --force
    code-insiders --install-extension ms-vscode.remote-explorer --force
    code-insiders --install-extension ms-vscode.remote-repositories --force
    code-insiders --install-extension ms-vscode.remote-server --force
    code-insiders --install-extension ms-vscode.vscode-copilot-data-analysis --force
    code-insiders --install-extension ms-vscode.vscode-node-azure-pack --force
    code-insiders --install-extension ms-vscode.vscode-speech --force
    code-insiders --install-extension ms-vscode.vscode-websearchforcopilot --force
    code-insiders --install-extension ms-windows-ai-studio.windows-ai-studio --force
    code-insiders --install-extension openai.chatgpt --force
    code-insiders --install-extension redhat.vscode-yaml --force
    code-insiders --install-extension reditorsupport.r --force
    code-insiders --install-extension reditorsupport.r-syntax --force
    code-insiders --install-extension snowflake.snowflake-vsc --force
    code-insiders --install-extension teamsdevapp.vscode-ai-foundry --force
    code-insiders --install-extension tushortz.python-extended-snippets --force
    code-insiders --install-extension vscode-icons-team.vscode-icons --force
    code-insiders --install-extension whitphx.vscode-stlite --force
fi

# Also install extensions for regular VS Code if present
if command -v code &>/dev/null; then
    code --install-extension anthropic.claude-code --force
    code --install-extension astral-sh.ty --force
    code --install-extension charliermarsh.ruff --force
    code --install-extension davidanson.vscode-markdownlint --force
    code --install-extension docker.docker --force
    code --install-extension eamodio.gitlens --force
    code --install-extension formulahendry.azure-storage-explorer --force
    code --install-extension github.codespaces --force
    code --install-extension github.copilot --force
    code --install-extension github.copilot-chat --force
    code --install-extension github.github-vscode-theme --force
    code --install-extension github.remotehub --force
    code --install-extension github.vscode-github-actions --force
    code --install-extension github.vscode-pull-request-github --force
    code --install-extension google.geminicodeassist --force
    code --install-extension james-yu.latex-workshop --force
    code --install-extension mechatroner.rainbow-csv --force
    code --install-extension ms-azure-devops.azure-pipelines --force
    code --install-extension ms-azuretools.azure-dev --force
    code --install-extension ms-azuretools.vscode-azure-github-copilot --force
    # ms-azuretools.vscode-azure-mcp-server removed — incompatible with VS Code 1.98.x
    code --install-extension ms-azuretools.vscode-azureappservice --force
    code --install-extension ms-azuretools.vscode-azurecontainerapps --force
    code --install-extension ms-azuretools.vscode-azurefunctions --force
    code --install-extension ms-azuretools.vscode-azureresourcegroups --force
    code --install-extension ms-azuretools.vscode-azurestaticwebapps --force
    code --install-extension ms-azuretools.vscode-azurestorage --force
    code --install-extension ms-azuretools.vscode-azurevirtualmachines --force
    code --install-extension ms-azuretools.vscode-containers --force
    code --install-extension ms-azuretools.vscode-cosmosdb --force
    code --install-extension ms-azuretools.vscode-docker --force
    code --install-extension ms-dotnettools.vscode-dotnet-runtime --force
    code --install-extension ms-edgedevtools.vscode-edge-devtools --force
    code --install-extension ms-mssql.data-workspace-vscode --force
    code --install-extension ms-mssql.mssql --force
    code --install-extension ms-mssql.sql-bindings-vscode --force
    code --install-extension ms-mssql.sql-database-projects-vscode --force
    # ms-ossdata.vscode-postgresql removed — no longer in marketplace
    code --install-extension ms-python.anaconda-extension-pack --force
    code --install-extension ms-python.debugpy --force
    code --install-extension ms-python.flake8 --force
    code --install-extension ms-python.python --force
    code --install-extension ms-python.vscode-pylance --force
    code --install-extension ms-python.vscode-python-envs --force
    code --install-extension ms-toolsai.datawrangler --force
    code --install-extension ms-toolsai.jupyter --force
    code --install-extension ms-toolsai.jupyter-keymap --force
    code --install-extension ms-toolsai.jupyter-renderers --force
    code --install-extension ms-toolsai.vscode-ai --force
    code --install-extension ms-toolsai.vscode-ai-remote --force
    code --install-extension ms-toolsai.vscode-jupyter-cell-tags --force
    code --install-extension ms-toolsai.vscode-jupyter-slideshow --force
    code --install-extension ms-vscode-remote.remote-containers --force
    code --install-extension ms-vscode-remote.remote-ssh --force
    code --install-extension ms-vscode-remote.remote-ssh-edit --force
    code --install-extension ms-vscode-remote.vscode-remote-extensionpack --force
    code --install-extension ms-vscode.azure-account --force
    code --install-extension ms-vscode.azure-repos --force
    code --install-extension ms-vscode.azurecli --force
    code --install-extension ms-vscode.cpptools --force
    code --install-extension ms-vscode.makefile-tools --force
    code --install-extension ms-vscode.remote-explorer --force
    code --install-extension ms-vscode.remote-repositories --force
    code --install-extension ms-vscode.remote-server --force
    code --install-extension ms-vscode.vscode-copilot-data-analysis --force
    code --install-extension ms-vscode.vscode-node-azure-pack --force
    code --install-extension ms-vscode.vscode-speech --force
    code --install-extension ms-vscode.vscode-websearchforcopilot --force
    code --install-extension ms-windows-ai-studio.windows-ai-studio --force
    code --install-extension openai.chatgpt --force
    code --install-extension redhat.vscode-yaml --force
    code --install-extension reditorsupport.r --force
    code --install-extension reditorsupport.r-syntax --force
    code --install-extension snowflake.snowflake-vsc --force
    code --install-extension teamsdevapp.vscode-ai-foundry --force
    code --install-extension tushortz.python-extended-snippets --force
    code --install-extension vscode-icons-team.vscode-icons --force
    code --install-extension whitphx.vscode-stlite --force
fi
