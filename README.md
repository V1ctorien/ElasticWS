# Import et enrichissement d'adresses BANO

Reproduction de la série Elastic « Enriching Your Postal Addresses With
the Elastic Stack », adaptée à Elasticsearch 9 et à la Franche-Comté
(départements 25, 39, 70, 90).

## Prérequis

- Docker
- Une stack locale : `curl -fsSL https://elastic.co/start-local | sh`

## Mise en route

1. Récupérer les données :
   `wget http://bano.openstreetmap.fr/data/bano-25.csv`
2. Créer le template d'index à partir de `template.json`
3. Importer : `./import-bano.sh`
4. Enrichir en interactif : `./run-enrich.sh`, puis `./samples.sh`
5. Enrichir un fichier : `./run-file.sh`

## Contenu

| Fichier | Rôle |
|---|---|
| `logstash/bano-data.conf` | import des CSV BANO |
| `logstash/bano-enrich.conf` | enrichissement via entrée HTTP |
| `logstash/bano-file.conf` | enrichissement d'un CSV de personnes |
| `logstash/search-by-*.json` | templates de requête Elasticsearch |
| `template.json` | mapping, analyzers et alias de l'index |
| `lancement.py` | démarrage de la stack et requêtes d'exemple |

Les scripts supposent une stack lancée par `start-local`, dont le `.env`
fournit l'URL, le mot de passe et le nom du réseau Docker.
