#!/bin/bash
SERVERS=("admin" "admin2")
LOCAL="$HOME"
REMOTE_HOME="~"

for SERVER in "${SERVERS[@]}"; do
    echo "==> Syncing to $SERVER"
    rsync -avP "$LOCAL/.dotfiles/common" "$SERVER:$REMOTE_HOME/.dotfiles"
done
