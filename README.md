# Cyberia.Cdn

This repository contains static images used for the Discord bot Salamandra and the website [amphibian.fr](https://amphibian.fr).

## Setup

> **Note:** This setup procedure is tailored to my specific use case, you can setup. Feel free to setup the CDN in any way that suits you.

### Installation Steps

1. **Install Caddy:**  
   Follow the [installation](https://caddyserver.com/docs/install) guide for [Caddy](https://caddyserver.com/).

2. **Create the `cyberia` Directory:**  
   Navigate to `/var/www`, create a directory named `cyberia`, and change the owner and group to your main user (for me, it's *salamandra*).  
   ```bash
   cd /var/www
   sudo mkdir cyberia
   sudo chown salamandra:salamandra cyberia
   ```
3. **Clone the Repository:**
   As the main user (in my case, salamandra), clone this repository into the cyberia directory.
   ```bash
   cd /var/www/cyberia
   git clone git@github.com:Lounek09/Cyberia.Cdn.git
   ```
4. **Configure Caddy:**
   Open the Caddy configuration file `/etc/caddy/Caddyfile`, remove the default configuration if present, and add the following block, replacing localhost with your own domain:
   ```caddy
   your-domain.com {
     root * /var/www/cyberia/Cyberia.Cdn
     file_server {
       hide .git
     }
     encode gzip
     header Cache-Control max-age=1209600
   }
   ```
5. **Restart Caddy:**
   Restart the Caddy service to apply the new configuration[^1]:
   ```bash
   sudo systemctl restart caddy
   ```

[^1]: If the service fails to start due to missing permissions, it's likely because Caddy creates certain directories without the correct permissions. Try the following command after each restart until it works: `sudo chmod -R 755 /var/lib/caddy/.local`
