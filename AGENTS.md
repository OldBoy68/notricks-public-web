# AGENTS.md

## Scopo del progetto
Sito pubblico statico per `notricks.app` e `www.notricks.app`.
Contiene la home, la privacy policy, la pagina di cancellazione account e la
pagina di supporto. Non c'è un framework o un build step: si lavora su HTML,
CSS e asset statici.
La documentazione canonica del progetto vive nel workspace sotto
`../../docs/projects/notricks-public-web/`.

## Setup e preview
```bash
npx serve .
```

Questo è il controllo locale minimo. In alternativa puoi aprire direttamente
gli HTML statici per una verifica rapida del contenuto.

## Deploy
`deploy.sh` sincronizza la root del repo sulla EC2 `51.118.75.4` in
`/opt/notricks/notricks-public-web` usando `rsync --delete`.

Per eseguirlo serve il path a una chiave SSH `.pem`:
```bash
chmod +x deploy.sh
./deploy.sh /percorso/alla/key.pem
```

Non modificare i file direttamente sulla macchina remota: il repo locale è la
sorgente di verità.

## Struttura
- `index.html`: home page.
- `privacy/index.html`: privacy policy.
- `delete-account/index.html`: procedura di cancellazione dati.
- `support/index.html`: supporto e contatti.
- `assets/`: CSS, immagini, font e icone.
- `deploy.sh`: sync verso EC2.
- `robots.txt` e `sitemap.xml`: crawling e indicizzazione.

## Convenzioni
- Il dominio canonico è `https://notricks.app/`.
- `www.notricks.app` deve restare un redirect verso il canonical.
- Usa percorsi assoluti per asset e pagine interne, ad esempio `/assets/...` e
  `/privacy`.
- Quando cambi CSS o JS statici, usa nomi versionati per gli asset e aggiorna i
  riferimenti HTML per ridurre i problemi di cache CloudFront.
- Mantieni allineati privacy, supporto e cancellazione account con i testi del
  prodotto mobile.

## Vincoli e do/don't
- Non introdurre un bundler o una pipeline JS senza richiesta esplicita.
- Non committare segreti o chiavi private.
- Non spostare la logica di deploy fuori da `deploy.sh` senza una ragione
  concreta.
- Non cambiare il comportamento del redirect `www -> notricks.app` senza
  coordinamento.

## Checklist verifica
- `npx serve .` dalla root del repo.
- `curl -I https://notricks.app/`
- `curl -I https://notricks.app/assets/site.v2.css`
- `curl -I https://www.notricks.app/`
