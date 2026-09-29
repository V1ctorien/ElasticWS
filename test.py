from pathlib import Path
from elasticsearch import Elasticsearch

import subprocess

env = dict(
    l.strip().split("=", 1)
    for l in Path("elastic-start-local/.env").read_text().splitlines()
    if "=" in l and not l.startswith("#")
)

url = f"http://localhost:{env.get('ES_LOCAL_PORT', '9200')}"

es = Elasticsearch(url, api_key=env["ES_LOCAL_API_KEY"])


port = env.get("KIBANA_LOCAL_PORT", "5601")

subprocess.run(["explorer.exe", f"http://localhost:{port}"])

print("Version :", es.info()["version"]["number"])
print("Adresses :", es.count(index="bano-25")["count"])