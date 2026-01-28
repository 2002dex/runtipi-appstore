# phpMyAdmin + MySQL

Deploy a MySQL server together with phpMyAdmin (web UI) to manage your database.

## Features
- MySQL server (persistent data)
- phpMyAdmin web interface
- Smritimegh install-time prompts for DB name, user and passwords
- Exposable through your Smritimegh domain / Traefik

## Security notes
- Use a strong root password.
- If you expose phpMyAdmin to the internet, restrict access with a strong domain + HTTPS and consider additional auth or IP allowlist.
