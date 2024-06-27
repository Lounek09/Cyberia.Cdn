# Cyberia.Cdn

This repository contains static images used for the Discord bot [Salamandra](https://discord.com/application-directory/687745374294638594) and the website [amphibian.fr](https://amphibian.fr).

## Setup

> [!NOTE]
> This procedure is tailored to my specific use case. Feel free to setup the Cdn in any way that suits you.

### Prerequisites

Ensure you have the following prerequisites installed:
- **Caddy**: [Install Caddy](https://caddyserver.com/docs/install)

### Installation Steps
   
1. **Create the `cyberia` Directory:**  
   Navigate to `/var/www`, create a directory named `cyberia`, and change the owner and group to your main user (for me, it's *salamandra*).  
   ```bash
   cd /var/www
   sudo mkdir cyberia
   sudo chown salamandra:salamandra cyberia
   ```
   
2. **Clone the Repository:**  
   As the main user (in my case, salamandra), clone this repository into the cyberia directory.
   ```bash
   cd /var/www/cyberia
   git clone git@github.com:Lounek09/Cyberia.Cdn.git
   mv Cyberia.Cdn Cdn
   ```
   
3. **Configure Caddy:**  
   Open the Caddy configuration file `/etc/caddy/Caddyfile`, remove the default configuration if present, and add the following block, don't forget to replace *your-domain.com* with your own domain:
   ```caddy
   (common) {
     header -Server
   }

   cdn.your-domain.com {
     import common
   
     root * /var/www/cyberia/Cdn
     file_server {
       hide .git .github README.md
     }
     encode gzip
     header Cache-Control max-age=1209600
   }
   ```
   
4. **Restart Caddy:**  
   Restart the Caddy service to apply the new configuration[^1]:
   ```bash
   sudo systemctl restart caddy
   ```

[^1]: If the service fails to start due to missing permissions, it's likely because Caddy creates certain directories without the correct permissions. Try the following command after each restart until it works: `sudo chmod -R 755 /var/lib/caddy/.local`
