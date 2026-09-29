#!/bin/bash
cd ~/elastic-tuto
source elastic-start-local/.env

for DEPT in 39 70 90; do
  echo "=== Département $DEPT ==="

  # -N ne retélécharge que si le fichier distant est plus récent
  wget -q -N "http://bano.openstreetmap.fr/data/bano-$DEPT.csv"

  if [ ! -f "bano-$DEPT.csv" ]; then
    echo "Téléchargement échoué, on passe."
    continue
  fi

  echo "$(wc -l < bano-$DEPT.csv) lignes"

  # L'article supprime l'index avant chaque import, pour repartir propre
  curl -s -X DELETE "$ES_LOCAL_URL/bano-$DEPT" \
    -u "elastic:$ES_LOCAL_PASSWORD" > /dev/null

  REGION=$DEPT ./run-logstash.sh < "bano-$DEPT.csv" 2>/dev/null

  echo "Terminé pour $DEPT"
done
