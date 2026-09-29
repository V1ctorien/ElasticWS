1:
    POST /customer/_doc/1
{
  "firstname": "Jennifer",
  "lastname": "Walters"
}

    result:

    {
  "_index": "customer",
  "_id": "1",
  "_version": 2,
  "result": "updated",
  "_shards": {
    "total": 2,
    "successful": 1,
    "failed": 0
  },
  "_seq_no": 1,
  "_primary_term": 1
}

2:
    GET /customer/_doc/1

    result :
    {
  "_index": "customer",
  "_id": "1",
  "_version": 2,
  "_seq_no": 1,
  "_primary_term": 1,
  "found": true,
  "_source": {
    "firstname": "Jennifer",
    "lastname": "Walters"
  }
}

3:
    GET customer/_search
{
  "query" : {
    "match" : { "firstname": "Jennifer" }
  }

  result:

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
      "value": 1,
      "relation": "eq"
    },
    "max_score": 0.18232156,
    "hits": [
      {
        "_index": "customer",
        "_id": "1",
        "_score": 0.18232156,
        "_source": {
          "firstname": "Jennifer",
          "lastname": "Walters"
        }
      }
    ]
  }
}

4:
    PUT customer/_bulk
{ "create": { } }
{ "firstname": "Monica","lastname":"Rambeau"}
{ "create": { } }
{ "firstname": "Carol","lastname":"Danvers"}
{ "create": { } }
{ "firstname": "Wanda","lastname":"Maximoff"}
{ "create": { } }
{ "firstname": "Jennifer","lastname":"Takeda"}

    result:

    {
  "errors": false,
  "took": 0,
  "items": [
    {
      "create": {
        "_index": "customer",
        "_id": "6pIC7KAB3l9RvKcuKhMd",
        "_version": 1,
        "result": "created",
        "_shards": {
          "total": 2,
          "successful": 1,
          "failed": 0
        },
        "_seq_no": 2,
        "_primary_term": 1,
        "status": 201
      }
    },
    {
      "create": {
        "_index": "customer",
        "_id": "65IC7KAB3l9RvKcuKhMd",
        "_version": 1,
        "result": "created",
        "_shards": {
          "total": 2,
          "successful": 1,
          "failed": 0
        },
        "_seq_no": 3,
        "_primary_term": 1,
        "status": 201
      }
    },
    {
      "create": {
        "_index": "customer",
        "_id": "7JIC7KAB3l9RvKcuKhMd",
        "_version": 1,
        "result": "created",
        "_shards": {
          "total": 2,
          "successful": 1,
          "failed": 0
        },
        "_seq_no": 4,
        "_primary_term": 1,
        "status": 201
      }
    },
    {
      "create": {
        "_index": "customer",
        "_id": "7ZIC7KAB3l9RvKcuKhMd",
        "_version": 1,
        "result": "created",
        "_shards": {
          "total": 2,
          "successful": 1,
          "failed": 0
        },
        "_seq_no": 5,
        "_primary_term": 1,
        "status": 201
      }
    }
  ]
}

5:
 GET customer/_search
{
  "query" : {
    "match" : { "firstname": "Jennifer" }
  }
}
    result:

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
    "max_score": 0.87546873,
    "hits": [
      {
        "_index": "customer",
        "_id": "1",
        "_score": 0.87546873,
        "_source": {
          "firstname": "Jennifer",
          "lastname": "Walters"
        }
      },
      {
        "_index": "customer",
        "_id": "7ZIC7KAB3l9RvKcuKhMd",
        "_score": 0.87546873,
        "_source": {
          "firstname": "Jennifer",
          "lastname": "Takeda"
        }
      }
    ]
  }
}