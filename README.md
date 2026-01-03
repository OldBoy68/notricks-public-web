# notricks-public-web — Deploy

Sito pubblico statico per `notricks.app` / `www.notricks.app` (home + privacy + delete-account + support).

## Source of truth

Il **repo Git è la sorgente ufficiale**.  
Evitare modifiche manuali direttamente sulla EC2: aggiornare i file qui e fare deploy.

## Prerequisiti

-   Accesso SSH alla EC2 con chiave privata `.pem`
-   Host EC2: `51.118.75.4`
-   Path di deploy sulla EC2: `/opt/notricks/notricks-public-web`

## Deploy

Dalla root del repo:

```bash
chmod +x deploy.sh
./deploy.sh /percorso/alla/key.pem
```
