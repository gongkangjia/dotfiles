#!/bin/bash
SERVERS=("admin" "admin2")
LOCAL="$HOME"
REMOTE_HOME="~"

for SERVER in "${SERVERS[@]}"; do
    echo "==> Syncing to $SERVER"
    rsync -avP --exclude ".git/" --exclude ".venv/" --exclude ".DS_Store" "$LOCAL/.dotfiles" "$SERVER:$REMOTE_HOME"
    #安装neovim
    echo "==> Syncing Neovim to $SERVER"
    rsync -avP ~/Softwares/nvim-linux-x86_64/* "$SERVER:$REMOTE_HOME/.local"
done
echo "==> Syncing complete."
