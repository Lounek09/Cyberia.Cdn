@echo off

set SSH_USER=salamandra
set SSH_HOST=amphibian.fr
set SSH_PORT=9
set REMOTE_PATH=/var/www/cyberia/Cdn

ssh %SSH_USER%@%SSH_HOST% -p %SSH_PORT% "cd %REMOTE_PATH% && git pull --rebase"

pause