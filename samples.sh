#!/bin/bash
post() { curl -s -XPOST "localhost:8080" -H "Content-Type: application/json" -d "$1"; }

post '{
  "test_case": "Adresse en texte",
  "name": "Joe Smith",
  "address": {
    "number": "23",
    "street_name": "r republique",
    "city": "besancon",
    "country": "France"
  }
}'

post '{
  "test_case": "Adresse en geo",
  "location": { "lat": 47.2378, "lon": 6.0241 }
}'

post '{
  "test_case": "Geo + code postal complet",
  "address": { "zipcode": "25000" },
  "location": { "lat": 47.2378, "lon": 6.0241 }
}'

post '{
  "test_case": "Geo + code postal partiel",
  "address": { "zipcode": "90" },
  "location": { "lat": 47.6379, "lon": 6.8628 }
}'
