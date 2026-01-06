# notricks-public-web — Deploy

Sito pubblico statico per `notricks.app` / `www.notricks.app` (home + privacy + delete-account + support).

## Decisioni (ADR)

La decisione architetturale che descrive domini, pagine minime e policy Play Store è nel repo backend:
`docs/07_decisions_adr/ADR-0008_public-web-presence_play-store.md`

## Source of truth

Il **repo Git è la sorgente ufficiale**.  
Evitare modifiche manuali direttamente sulla EC2: aggiornare i file qui e fare deploy.

## Prerequisiti

-   Accesso SSH alla EC2 con chiave privata `.pem`
-   Host EC2: `51.118.75.4`
-   Path di deploy sulla EC2: `/opt/notricks/notricks-public-web`

## Test in locale

```bash
npx serve .
```

## Nota cache (CloudFront)

Abbiamo visto che con CloudFront i cambiamenti a CSS/JS possono non apparire subito.  
Per evitare problemi: versiona gli asset (es. `site.v2.css`) e aggiorna i link negli HTML; poi invalida solo gli HTML su CloudFront. Così non serve invalidare tutti gli asset ad ogni deploy.

## Deploy

Dalla root del repo:

```bash
chmod +x deploy.sh
./deploy.sh /percorso/alla/key.pem
```

Lo script usa `rsync --delete` (rimuove sul server file che non esistono più nel repo).

## Verifica rapida

```bash
curl -I https://notricks.app/
curl -I https://notricks.app/assets/site.v2.css
curl -I https://www.notricks.app/   # deve redirigere verso notricks.app
```

## Note

-   `www.notricks.app` redirige verso `https://notricks.app/...` (canonical).
-   Cache:
    -   HTML: `Cache-Control: no-cache`
    -   `/assets/*`: `Cache-Control: public, max-age=31536000, immutable`
