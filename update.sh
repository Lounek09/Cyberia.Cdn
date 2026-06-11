#!/usr/bin/env bash

SSH_USER="salamandra"
SSH_HOST="amphibian.fr"
SSH_PORT="9"
REMOTE_PATH="/var/www/cyberia/Cdn"

ssh "$SSH_USER@$SSH_HOST" -p "$SSH_PORT" "cd $REMOTE_PATH && git pull --rebase"