#!/usr/bin/env python3
import subprocess, time, urllib.request, urllib.error
from pathlib import Path
from elasticsearch import Elasticsearch

RACINE = Path(__file__).parent  # Répertoire racine du script
env = dict(
    l.strip().split("=", 1)
    for l in (RACINE / "elastic-start-local/.env").read_text().splitlines()
    if "=" in l and not l.startswith("#")
)  # Lire les variables d'environnement depuis le fichier .env

ES_URL = f"http://localhost:{env.get('ES_LOCAL_PORT', '9200')}"
KB_URL = f"http://localhost:{env.get('KIBANA_LOCAL_PORT', '5601')}"

# Démarrer les conteneurs s'ils sont arrêtés
if not subprocess.run(["docker", "ps", "-q", "-f", "name=es-local-dev"],
                      capture_output=True, text=True).stdout.strip():
    print("Démarrage d'Elasticsearch et Kibana...")
    subprocess.run(["./start.sh"], cwd=RACINE / "elastic-start-local")

es = Elasticsearch(ES_URL, api_key=env["ES_LOCAL_API_KEY"])
print("Version :", es.info()["version"]["number"])
print("Adresses :", es.count(index="bano")["count"])

subprocess.run(["explorer.exe", f"{KB_URL}/app/dev_tools#/console"])