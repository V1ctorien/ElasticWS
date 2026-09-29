1: 
    GET books/_search
    {
    "query": {
        "match": {
        "name": "brave"
        }
    }
    }

    reslut:

    {
  "took": 2,
  "timed_out": false,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 2,
      "relation": "eq"
    },
    "max_score": 1.289742,
    "hits": [
      {
        "_index": "books",
        "_id": "seNgbKAB6XUvxNiAj2YW",
        "_score": 1.289742,
        "_source": {
          "name": "Brave New World",
          "author": "Aldous Huxley",
          "release_date": "1932-06-01",
          "page_count": 268
        }
      },
      {
        "_index": "books",
        "_id": "aHTr5qABdfbWajddKVkR",
        "_score": 1.289742,
        "_source": {
          "name": "Brave New World",
          "author": "Aldous Huxley",
          "release_date": "1932-06-01",
          "page_count": 268
        }
      }
    ]
  }
}

2:
    GET _index_template/bano

    result: 
    {
  "index_templates": [
    {
      "name": "bano",
      "index_template": {
        "index_patterns": [
          "bano-*"
        ],
        "template": {
          "settings": {
            "index": {
              "analysis": {
                "filter": {
                  "bano_synonym": {
                    "type": "synonym",
                    "synonyms": [
                      "bd => boulevard",
                      "av => avenue",
                      "r => rue",
                      "rte => route"
                    ]
                  }
                },
                "analyzer": {
                  "bano_street_analyzer": {
                    "filter": [
                      "lowercase",
                      "asciifolding",
                      "bano_synonym"
                    ],
                    "type": "custom",
                    "tokenizer": "standard"
                  },
                  "bano_analyzer": {
                    "filter": [
                      "lowercase",
                      "asciifolding"
                    ],
                    "type": "custom",
                    "tokenizer": "standard"
                  }
                }
              },
              "number_of_shards": "1",
              "number_of_replicas": "0"
            }
          },
          "mappings": {
            "properties": {
              "address": {
                "properties": {
                  "zipcode": {
                    "type": "keyword"
                  },
                  "number": {
                    "type": "keyword"
                  },
                  "city": {
                    "analyzer": "bano_analyzer",
                    "type": "text",
                    "fields": {
                      "keyword": {
                        "type": "keyword"
                      }
                    }
                  },
                  "street_name": {
                    "analyzer": "bano_street_analyzer",
                    "type": "text"
                  }
                }
              },
              "location": {
                "type": "geo_point"
              },
              "id": {
                "type": "keyword"
              },
              "source": {
                "type": "keyword"
              },
              "region": {
                "type": "keyword"
              }
            }
          },
          "aliases": {
            "bano": {}
          }
        },
        "composed_of": [],
        "created_date_millis": 1788526660107,
        "modified_date_millis": 1788526660107
      }
    }
  ]
}

3:
    GET _cat/indices?v

    result:

    health status index                                           uuid                   pri rep docs.count docs.deleted store.size pri.store.size dataset.size
green  open   .ds-.workflows-events-2026.09.04-000001         JzKrK_9tQKSylj3VEMCwxQ   1   0          0            0       249b           249b         249b
yellow open   produits                                        lrh1XQ7mR8ymPgGDMyubRA   1   1          2            0      6.4kb          6.4kb        6.4kb
yellow open   books                                           OPFsqBifTtO2jt6UZjOzwQ   1   1         10            0     15.8kb         15.8kb       15.8kb
green  open   .ds-.kibana_change_history-2026.09.04-000001    o6AllnXMT4Kxg8aI5aJWqQ   1   0         16            0    120.7kb        120.7kb      120.7kb
green  open   bano-39                                         k12FUvccRhmZM8nCGqWR5Q   1   0     135142            0     12.8mb         12.8mb       12.8mb
green  open   .internal.alerts-security.alerts-default-000001 C_NNLw4GQUiUVkTuQtMwZw   1   0          0            0       249b           249b         249b
green  open   bano-25                                         GTbRLhjDTBydhbmTwXF-Uw   1   0     203672            0     19.6mb         19.6mb       19.6mb
green  open   bano-70                                         6_fTYLUaQeKAoNWB6bmYYQ   1   0     133348            0     12.6mb         12.6mb       12.6mb
green  open   bano-90                                         1nhu0B9RQs2mocZianS0-Q   1   0      46583            0        4mb            4mb          4mb

4:
    GET _cat/indices/bano*?v&h=index,health,docs.count,store.size

    result: 

    index   health docs.count store.size
bano-39 green      135142     12.8mb
bano-25 green      203672     19.6mb
bano-70 green      133348     12.6mb
bano-90 green       46583        4mb

5: 
    GET bano-25/_search
{ "size": 2 }

    result:

    {
  "took": 3,
  "timed_out": false,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 10000,
      "relation": "gte"
    },
    "max_score": 1,
    "hits": [
      {
        "_index": "bano-25",
        "_id": "250310277-24B",
        "_score": 1,
        "_source": {
          "location": {
            "lat": 47.486122,
            "lon": 6.859817
          },
          "id": "250310277-24B",
          "source": "OSM",
          "region": "25",
          "address": {
            "zipcode": "25400",
            "number": "24 Bis",
            "street_name": "Rue de la Combotte",
            "city": "Audincourt"
          }
        }
      },
      {
        "_index": "bano-25",
        "_id": "250310110-97B",
        "_score": 1,
        "_source": {
          "location": {
            "lat": 47.484366,
            "lon": 6.860794
          },
          "id": "250310110-97B",
          "source": "OSM",
          "region": "25",
          "address": {
            "zipcode": "25400",
            "number": "97 Bis",
            "street_name": "Rue des Cantons",
            "city": "Audincourt"
          }
        }
      }
    ]
6:
    GET bano-25/_mapping

    result: 

    {
  "bano-25": {
    "mappings": {
      "properties": {
        "address": {
          "properties": {
            "city": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword"
                }
              },
              "analyzer": "bano_analyzer"
            },
            "number": {
              "type": "keyword"
            },
            "street_name": {
              "type": "text",
              "analyzer": "bano_street_analyzer"
            },
            "zipcode": {
              "type": "keyword"
            }
          }
        },
        "id": {
          "type": "keyword"
        },
        "location": {
          "type": "geo_point"
        },
        "region": {
          "type": "keyword"
        },
        "source": {
          "type": "keyword"
        }
      }
    }
  }
}

7:
    GET _cat/aliases?v

    result:

    alias                                              index                                                              filter routing.index routing.search is_write_index
.alerts-ml.anomaly-detection.alerts-default        .internal.alerts-ml.anomaly-detection.alerts-default-000001        -      -             -              true
.alerts-observability.slo.alerts-default           .internal.alerts-observability.slo.alerts-default-000001           -      -             -              true
.kibana_security_session                           .kibana_security_session_1                                         -      -             -              true
.integration_knowledge                             .integration_knowledge-7                                           -      -             -              true
.workflows-workflows                               .workflows-workflows-000001                                        -      -             -              true
.alerts-security.attack.discovery.alerts-default   .internal.alerts-security.attack.discovery.alerts-default-000001   -      -             -              true
.alerts-observability.metrics.alerts-default       .internal.alerts-observability.metrics.alerts-default-000001       -      -             -              true
bano                                               bano-25                                                            -      -             -              -
.security-profile                                  .security-profile-8                                                -      -             -              -
.alerts-stack.alerts-default                       .internal.alerts-stack.alerts-default-000001                       -      -             -              true
.kibana_security_solution                          .kibana_security_solution_9.5.3_001                                -      -             -              -
.kibana_security_solution_9.5.3                    .kibana_security_solution_9.5.3_001                                -      -             -              -
.ml-annotations-read                               .ml-annotations-000001                                             -      -             -              -
.ml-annotations-write                              .ml-annotations-000001                                             -      -             -              -
.alerts-observability.uptime.alerts-default        .internal.alerts-observability.uptime.alerts-default-000001        -      -             -              true
.kibana_streams                                    .kibana_streams-000001                                             -      -             -              true
.kibana                                            .kibana_9.5.3_001                                                  -      -             -              -
.kibana_9.5.3                                      .kibana_9.5.3_001                                                  -      -             -              -
bano                                               bano-90                                                            -      -             -              -
.alerts-observability.threshold.alerts-default     .internal.alerts-observability.threshold.alerts-default-000001     -      -             -              true
.kibana_search_solution                            .kibana_search_solution_9.5.3_001                                  -      -             -              -
.kibana_search_solution_9.5.3                      .kibana_search_solution_9.5.3_001                                  -      -             -              -
.kibana_alerting_cases                             .kibana_alerting_cases_9.5.3_001                                   -      -             -              -
.kibana_alerting_cases_9.5.3                       .kibana_alerting_cases_9.5.3_001                                   -      -             -              -
.inference-alias                                   .inference                                                         -      -             -              true
.ml-notifications-write                            .ml-notifications-000002                                           -      -             -              -
.alerts-transform.health.alerts-default            .internal.alerts-transform.health.alerts-default-000001            -      -             -              true
.kibana_task_manager                               .kibana_task_manager_9.5.3_001                                     -      -             -              -
.kibana_task_manager_9.5.3                         .kibana_task_manager_9.5.3_001                                     -      -             -              -
.alerts-default.alerts-default                     .internal.alerts-default.alerts-default-000001                     -      -             -              true
.alerts-observability.apm.alerts-default           .internal.alerts-observability.apm.alerts-default-000001           -      -             -              true
.kibana_analytics                                  .kibana_analytics_9.5.3_001                                        -      -             -              -
.kibana_analytics_9.5.3                            .kibana_analytics_9.5.3_001                                        -      -             -              -
.alerts-streams.alerts-default                     .internal.alerts-streams.alerts-default-000001                     -      -             -              true
.alerts-ml.anomaly-detection-health.alerts-default .internal.alerts-ml.anomaly-detection-health.alerts-default-000001 -      -             -              true
.alerts-security.alerts-default                    .internal.alerts-security.alerts-default-000001                    -      -             -              true
.siem-signals-default                              .internal.alerts-security.alerts-default-000001                    -      -             -              false
.alerts-observability.logs.alerts-default          .internal.alerts-observability.logs.alerts-default-000001          -      -             -              true
bano                                               bano-70                                                            -      -             -              -
.kibana_ingest                                     .kibana_ingest_9.5.3_001                                           -      -             -              -
.kibana_ingest_9.5.3                               .kibana_ingest_9.5.3_001                                           -      -             -              -
.security                                          .security-7                                                        -      -             -              -
.kibana_usage_counters                             .kibana_usage_counters_9.5.3_001                                   -      -             -              -
.kibana_usage_counters_9.5.3                       .kibana_usage_counters_9.5.3_001                                   -      -             -              -
bano                                               bano-39                                                            -      -             -              -
.alerts-dataset.quality.alerts-default             .internal.alerts-dataset.quality.alerts-default-000001   

8:
    GET bano/_count

    result:

    {
  "count": 518745,
  "_shards": {
    "total": 4,
    "successful": 4,
    "skipped": 0,
    "failed": 0
  }
}

9:
    GET bano/_search
{
  "size": 0,
  "aggs": {
    "top_villes": { "terms": { "field": "address.city.keyword", "size": 10 } }
  }
}

    result:

    {
  "took": 22,
  "timed_out": false,
  "_shards": {
    "total": 4,
    "successful": 4,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 10000,
      "relation": "gte"
    },
    "max_score": null,
    "hits": []
  },
  "aggregations": {
    "top_villes": {
      "doc_count_error_upper_bound": 3419,
      "sum_other_doc_count": 451559,
      "buckets": [
        {
          "key": "Besançon",
          "doc_count": 19674
        },
        {
          "key": "Dole",
          "doc_count": 8778
        },
        {
          "key": "Belfort",
          "doc_count": 8063
        },
        {
          "key": "Montbéliard",
          "doc_count": 5141
        },
        {
          "key": "Pontarlier",
          "doc_count": 4725
        },
        {
          "key": "Vesoul",
          "doc_count": 4410
        },
        {
          "key": "Héricourt",
          "doc_count": 4397
        },
        {
          "key": "Lons-le-Saunier",
          "doc_count": 4368
        },
        {
          "key": "Audincourt",
          "doc_count": 4309
        },
        {
          "key": "Valentigney",
          "doc_count": 3321
        }
      ]
    }
  }
}

10:
    GET bano-25/_search
{ "size": 0, "track_total_hits": true }

    result:

   {
  "took": 10,
  "timed_out": false,
  "terminated_early": false,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 203672,
      "relation": "eq"
    },
    "max_score": null,
    "hits": []
  }
} 

11:
    GET bano-25/_search
{
  "size": 3,
  "query": {
    "bool": {
      "should": [
        { "match": { "address.street_name": "r republique" } },
        { "match": { "address.city": "besancon" } }
      ]
    }
  }
}

    result:

    {
  "took": 28,
  "timed_out": false,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 10000,
      "relation": "gte"
    },
    "max_score": 8.908395,
    "hits": [
      {
        "_index": "bano-25",
        "_id": "250564430-1",
        "_score": 8.908395,
        "_source": {
          "location": {
            "lat": 47.238515,
            "lon": 6.024597
          },
          "id": "250564430-1",
          "source": "OSM",
          "region": "25",
          "address": {
            "zipcode": "25000",
            "number": "1",
            "street_name": "Rue de la République",
            "city": "Besançon"
          }
        }
      },
      {
        "_index": "bano-25",
        "_id": "250564430-10",
        "_score": 8.908395,
        "_source": {
          "location": {
            "lat": 47.238914,
            "lon": 6.025461
          },
          "id": "250564430-10",
          "source": "OSM",
          "region": "25",
          "address": {
            "zipcode": "25000",
            "number": "10",
            "street_name": "Rue de la République",
            "city": "Besançon"
          }
        }
      },
      {
        "_index": "bano-25",
        "_id": "250564430-11",
        "_score": 8.908395,
        "_source": {
          "location": {
            "lat": 47.239018,
            "lon": 6.025399
          },
          "id": "250564430-11",
          "source": "OSM",
          "region": "25",
          "address": {
            "zipcode": "25000",
            "number": "11",
            "street_name": "Rue de la République",
            "city": "Besançon"
          }
        }
      }
    ]
  }
}

11:
    GET bano/_search
{
  "size": 5,
  "query": {
    "bool": {
      "should": [
        { "match": { "address.street_name": "r republique" } },
        { "match": { "address.city": "belfort" } }
      ]
    }
  }
}

    result:

    {
  "took": 10,
  "timed_out": false,
  "_shards": {
    "total": 4,
    "successful": 4,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 10000,
      "relation": "gte"
    },
    "max_score": 8.111343,
    "hits": [
      {
        "_index": "bano-90",
        "_id": "900103380-1",
        "_score": 8.111343,
        "_source": {
          "source": "OSM",
          "address": {
            "city": "Belfort",
            "street_name": "Rue de la République",
            "zipcode": "90000",
            "number": "1"
          },
          "region": "90",
          "location": {
            "lat": 47.638015,
            "lon": 6.859676
          },
          "id": "900103380-1"
        }
      },
      {
        "_index": "bano-90",
        "_id": "900103380-2",
        "_score": 8.111343,
        "_source": {
          "source": "OSM",
          "address": {
            "city": "Belfort",
            "street_name": "Rue de la République",
            "zipcode": "90000",
            "number": "2"
          },
          "region": "90",
          "location": {
            "lat": 47.637882,
            "lon": 6.859523
          },
          "id": "900103380-2"
        }
      },
      {
        "_index": "bano-90",
        "_id": "900103380-3",
        "_score": 8.111343,
        "_source": {
          "source": "OSM",
          "address": {
            "city": "Belfort",
            "street_name": "Rue de la République",
            "zipcode": "90000",
            "number": "3"
          },
          "region": "90",
          "location": {
            "lat": 47.637813,
            "lon": 6.859724
          },
          "id": "900103380-3"
        }
      },
      {
        "_index": "bano-90",
        "_id": "900103380-4",
        "_score": 8.111343,
        "_source": {
          "source": "OSM",
          "address": {
            "city": "Belfort",
            "street_name": "Rue de la République",
            "zipcode": "90000",
            "number": "4"
          },
          "region": "90",
          "location": {
            "lat": 47.637643,
            "lon": 6.859576
          },
          "id": "900103380-4"
        }
      },
      {
        "_index": "bano-90",
        "_id": "900103380-5",
        "_score": 8.111343,
        "_source": {
          "source": "OSM",
          "address": {
            "city": "Belfort",
            "street_name": "Rue de la République",
            "zipcode": "90000",
            "number": "5"
          },
          "region": "90",
          "location": {
            "lat": 47.63756,
            "lon": 6.859781
          },
          "id": "900103380-5"
        }
      }
    ]
  }
}

12:
    GET bano/_search
{
  "size": 0,
  "aggs": {
    "par_departement": {
      "terms": { "field": "region", "size": 10 },
      "aggs": {
        "top_villes": {
          "terms": { "field": "address.city.keyword", "size": 3 }
        }
      }
    }
  }
}
    result:

    {
  "took": 27,
  "timed_out": false,
  "_shards": {
    "total": 4,
    "successful": 4,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 10000,
      "relation": "gte"
    },
    "max_score": null,
    "hits": []
  },
  "aggregations": {
    "par_departement": {
      "doc_count_error_upper_bound": 0,
      "sum_other_doc_count": 0,
      "buckets": [
        {
          "key": "25",
          "doc_count": 203672,
          "top_villes": {
            "doc_count_error_upper_bound": 0,
            "sum_other_doc_count": 174132,
            "buckets": [
              {
                "key": "Besançon",
                "doc_count": 19674
              },
              {
                "key": "Montbéliard",
                "doc_count": 5141
              },
              {
                "key": "Pontarlier",
                "doc_count": 4725
              }
            ]
          }
        },
        {
          "key": "39",
          "doc_count": 135142,
          "top_villes": {
            "doc_count_error_upper_bound": 0,
            "sum_other_doc_count": 119218,
            "buckets": [
              {
                "key": "Dole",
                "doc_count": 8778
              },
              {
                "key": "Lons-le-Saunier",
                "doc_count": 4368
              },
              {
                "key": "Champagnole",
                "doc_count": 2778
              }
            ]
          }
        },
        {
          "key": "70",
          "doc_count": 133348,
          "top_villes": {
            "doc_count_error_upper_bound": 0,
            "sum_other_doc_count": 121296,
            "buckets": [
              {
                "key": "Vesoul",
                "doc_count": 4410
              },
              {
                "key": "Héricourt",
                "doc_count": 4397
              },
              {
                "key": "Lure",
                "doc_count": 3245
              }
            ]
          }
        },
        {
          "key": "90",
          "doc_count": 46583,
          "top_villes": {
            "doc_count_error_upper_bound": 0,
            "sum_other_doc_count": 34808,
            "buckets": [
              {
                "key": "Belfort",
                "doc_count": 8063
              },
              {
                "key": "Delle",
                "doc_count": 1912
              },
              {
                "key": "Beaucourt",
                "doc_count": 1800
              }
            ]
          }
        }
      ]
    }
  }
}

13:
    GET bano/_search
{
  "size": 5,
  "query": {
    "bool": {
      "filter": {
        "geo_distance": {
          "distance": "10km",
          "location": { "lat": 47.5167, "lon": 6.8000 }
        }
      }
    }
  },
  "sort": [
    { "_geo_distance": { "location": { "lat": 47.5167, "lon": 6.8000 } } }
  ],
  "_source": ["address", "region"]
}

    result:

    {
  "took": 57,
  "timed_out": false,
  "_shards": {
    "total": 4,
    "successful": 4,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 10000,
      "relation": "gte"
    },
    "max_score": null,
    "hits": [
      {
        "_index": "bano-25",
        "_id": "253880420-8",
        "_score": null,
        "_source": {
          "region": "25",
          "address": {
            "zipcode": "25200",
            "number": "8",
            "street_name": "Chemin du Cimetière",
            "city": "Montbéliard"
          }
        },
        "sort": [
          105.3079477867656
        ]
      },
      {
        "_index": "bano-25",
        "_id": "253880420-10",
        "_score": null,
        "_source": {
          "region": "25",
          "address": {
            "zipcode": "25200",
            "number": "10",
            "street_name": "Chemin du Cimetière",
            "city": "Montbéliard"
          }
        },
        "sort": [
          158.9795109070666
        ]
      },
      {
        "_index": "bano-25",
        "_id": "253880960-20B",
        "_score": null,
        "_source": {
          "region": "25",
          "address": {
            "zipcode": "25200",
            "number": "20b",
            "street_name": "Rue d'Héricourt",
            "city": "Montbéliard"
          }
        },
        "sort": [
          243.73251340262263
        ]
      },
      {
        "_index": "bano-25",
        "_id": "253881320-13",
        "_score": null,
        "_source": {
          "region": "25",
          "address": {
            "zipcode": "25200",
            "number": "13",
            "street_name": "Rue du Mont Christ",
            "city": "Montbéliard"
          }
        },
        "sort": [
          253.6902524140893
        ]
      },
      {
        "_index": "bano-25",
        "_id": "253881320-10",
        "_score": null,
        "_source": {
          "region": "25",
          "address": {
            "zipcode": "25200",
            "number": "10",
            "street_name": "Rue du Mont Christ",
            "city": "Montbéliard"
          }
        },
        "sort": [
          257.43840717967095
        ]
      }
    ]
  }
}

14:
    GET bano/_search
{
  "size": 1,
  "sort": [{ "_geo_distance": { "location": { "lat": 47.2378, "lon": 6.0241 } } }]
}
    result:

    {
  "took": 11,
  "timed_out": false,
  "_shards": {
    "total": 4,
    "successful": 4,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 10000,
      "relation": "gte"
    },
    "max_score": null,
    "hits": [
      {
        "_index": "bano-25",
        "_id": "250562440-52",
        "_score": null,
        "_source": {
          "location": {
            "lat": 47.237805,
            "lon": 6.02403
          },
          "id": "250562440-52",
          "source": "OSM",
          "region": "25",
          "address": {
            "zipcode": "25000",
            "number": "52",
            "street_name": "Grande Rue",
            "city": "Besançon"
          }
        },
        "sort": [
          5.315952974053344
        ]
      }
    ]
  }
}

15:
    GET bano/_search
{
  "size": 1,
  "query": {
    "bool": {
      "filter": {
        "geo_distance": {
          "distance": "1km",
          "location": { "lat": 47.2378, "lon": 6.0241 }
        }
      }
    }
  },
  "sort": [{ "_geo_distance": { "location": { "lat": 47.2378, "lon": 6.0241 } } }]
}

    result:

    {
  "took": 7,
  "timed_out": false,
  "_shards": {
    "total": 4,
    "successful": 4,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 2888,
      "relation": "eq"
    },
    "max_score": null,
    "hits": [
      {
        "_index": "bano-25",
        "_id": "250562440-52",
        "_score": null,
        "_source": {
          "location": {
            "lat": 47.237805,
            "lon": 6.02403
          },
          "id": "250562440-52",
          "source": "OSM",
          "region": "25",
          "address": {
            "zipcode": "25000",
            "number": "52",
            "street_name": "Grande Rue",
            "city": "Besançon"
          }
        },
        "sort": [
          5.315952974053344
        ]
      }
    ]
  }
}

16:
    GET personnes/_search

    result:

    {
  "took": 1,
  "timed_out": false,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 5,
      "relation": "eq"
    },
    "max_score": 1,
    "hits": [
      {
        "_index": "personnes",
        "_id": "2",
        "_score": 1,
        "_source": {
          "id": "2",
          "dateOfBirth": "1975-05-02",
          "address": {
            "street_name": "Place d'Armes",
            "number": "3",
            "city": "Belfort",
            "zipcode": "90000"
          },
          "name": "Marie Dupont",
          "gender": "female",
          "location": {
            "lon": 6.862894,
            "lat": 47.637995
          },
          "children": 3
        }
      },
      {
        "_index": "personnes",
        "_id": "5",
        "_score": 1,
        "_source": {
          "id": "5",
          "dateOfBirth": "1988-03-07",
          "address": {
            "street_name": "Rue de la Gare",
            "number": "4",
            "city": "Pontarlier",
            "zipcode": "25300"
          },
          "name": "Paul Girard",
          "gender": "male",
          "location": {
            "lon": 6.355032,
            "lat": 46.902887
          },
          "children": 2
        }
      },
      {
        "_index": "personnes",
        "_id": "1",
        "_score": 1,
        "_source": {
          "id": "1",
          "dateOfBirth": "1980-11-15",
          "address": {
            "street_name": "Grande Rue",
            "number": "52",
            "city": "Besançon",
            "zipcode": "25000"
          },
          "name": "Joe Smith",
          "gender": "male",
          "location": {
            "lon": 6.02403,
            "lat": 47.237805
          },
          "children": 2
        }
      },
      {
        "_index": "personnes",
        "_id": "3",
        "_score": 1,
        "_source": {
          "id": "3",
          "dateOfBirth": "1990-09-23",
          "address": {
            "street_name": "Rue Paul Morel",
            "number": "39",
            "city": "Vesoul",
            "zipcode": "70000"
          },
          "name": "Lucas Martin",
          "gender": "male",
          "location": {
            "lon": 6.154956,
            "lat": 47.620036
          },
          "children": 0
        }
      },
      {
        "_index": "personnes",
        "_id": "4",
        "_score": 1,
        "_source": {
          "id": "4",
          "dateOfBirth": "1964-10-18",
          "address": {
            "street_name": "Rue du Collège de l'Arc",
            "number": "20",
            "city": "Dole",
            "zipcode": "39100"
          },
          "name": "Sophie Bernard",
          "gender": "female",
          "location": {
            "lon": 5.490625,
            "lat": 47.092888
          },
          "children": 1
        }
      }
    ]
  }
}