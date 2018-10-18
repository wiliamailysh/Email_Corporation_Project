# Le Grand Mailing 

*L'équipe :* 
- Hava ***Guerni*** 
- Corentin ***Nadaud*** 
- Alexandre ***Lovergne***
- Victor ***Douay*** 
- Maxime ***Martin***


# Les fichiers 
 Comment ça marche ?

En lançant app.rb toutes les fonctions, par un habile jeu de classes et de méthodes bien organisées, se lancent : 
- app.rb appelle le fichier mailer pour envoyer les emails (voir code app.rb)
- elle même est subdivisée en plusieurs méthodes afin de scrapper, ajouter à la database, retravailler le data pour avoir des adresses email propres, et suivre des mairies sur Twitter. 

## L'arborescence 

```
├── Gemfile
├── README.md  (⇒ VOUS ÊTES ICI ⇐) 
├── app.rb
├── mailer.rb
├── db
│   └── townhalls.json
└── lib
    └── app
       └── townhalls_adder_to_db.rb
       └── townhalls_follower.rb
       └── townhalls_mailer.rb
       └── townhalls_scrapper.rb
    └──views
       └── done.rb
       └── index.rb
```

## Bundle Install - les gems nécessaires :

Une fois fois dans le repository, lancer la commande ``:$ bundle install`` pour installer les gems nécessaires au programmes : 

-  Gmail 
- Nokogiri 
- Dotenv
- Json 
- Rainbow
- Open-Uri
- Twitter

Hint : vu que vous avez sûrement travaillé sur ce projet, il y a de fortes chances que vous ayez déjà ces gems installés sur votre terminal. 

## Miracle Explained 

townhall_adder_to_db.rb créé un Json avec la data récupérée par townhall_scrapper.db.rb.
mailer.rb envoie les emails en se servait des adresses du fichier Json.

Le bot twitter a une interface utilisateur depuis le terminal pour lancer la collecte de données (@handles, elles aussi stockées dans le Json).  

Ce qui donne au final : 

- Une database propre en Json qui contient tous les emails scrapés des communes ainsi que leur nom.
- Un bot twitter qui collecte les @handles et les ajoute au Json.
- une application qui utilise les adresses email recueillies pour envoyer à chaque commune un mail en HTML présentant notre projet + THP avec le numéro de téléphone de Charles D. le cofondateur. 
