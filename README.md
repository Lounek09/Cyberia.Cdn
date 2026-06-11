# Cyberia.Cdn

This repository contains static images used for the Discord bot [Salamandra](https://discord.com/application-directory/687745374294638594) and the website [amphibian.fr](https://amphibian.fr).

## Setup

> [!NOTE]
> This procedure is tailored to my specific use case. Feel free to setup the Cdn in any way that suits you.

### Prerequisites

Ensure you have the following prerequisites installed:
- **Caddy**: [Install Caddy](https://caddyserver.com/docs/install)

### Installation steps

1. **Create the `cyberia` directory:**  
   Navigate to `/var/www`, create a directory named `cyberia`, and change the owner and group to your main user (for me, it's *salamandra*).  
   ```bash
   cd /var/www
   sudo mkdir cyberia
   sudo chown salamandra:salamandra cyberia
   ```

2. **Clone the repository:**  
   As the main user (in my case, salamandra), clone this repository into the cyberia directory.
   ```bash
   cd /var/www/cyberia
   git clone git@github.com:Lounek09/Cyberia.Cdn.git
   mv Cyberia.Cdn Cdn
   ```

3. **Configure Caddy:**  
   Edit the Caddy configuration file located at `/etc/caddy/Caddyfile` to include the following block, remove the default configuration if present. Replace *your-domain.com* with your actual domain:
   ```caddy
   (common) {
     header -Server
   }
   cdn.your-domain.com {
     import common
   
     root * /var/www/cyberia/Cdn
     file_server {
       hide .git README.md update.sh update.bat
     }
     encode gzip
     header Cache-Control max-age=1209600
   }
   ```
   For more information, see the [Caddiyfile documentation](https://caddyserver.com/docs/caddyfile).  

4. **Restart Caddy:**  
   Restart the Caddy service to apply the new configuration[^1]:
   ```bash
   sudo systemctl restart caddy
   ```

5. **Pull latest assets remotely:**  
   Edit the variables at the top of the script to match your server, then run it whenever you want to pull the latest assets:
   - Linux/macOS: `update.sh`
   - Windows: `update.bat`

   Ensure that SSH key authentication is configured for the target server.

[^1]: If the service fails to start due to missing permissions, it's likely because Caddy creates certain directories without the correct permissions. Try the following command after each restart until it works: `sudo chmod -R 755 /var/lib/caddy/.local`