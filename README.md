# API Documentation
Auth token from login stores at `Authorization` header
```
'Authorization': "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NzY3NTYyMjZ9.GISV1RJZBw_RaY_yqAP3bGuU8HL28vB-6f6PvATdG8w"
```

## Login

POST - `/auth/login`

Request body:
```JSON
{
    "email": "user1@user.com",
    "password": "qwerty123"
}
```

Response:
```JSON
{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NzY3NTYyMjZ9.GISV1RJZBw_RaY_yqAP3bGuU8HL28vB-6f6PvATdG8w",
    "exp": "02-18-2023 23:37",
    "user_id": 1,
    "email": "user1@user.com"
}
```

## Short Urls

### Use short url

GET - `/shortify/:slug`

### Create Short Url List

POST - `/short_urls`

Request body:
```JSON
{
    "slug": null,
    "url": "https://www.otodom.pl/pl/oferty/sprzedaz/mieszkanie/warszawa?distanceRadius=0&market=ALL&priceMax=500000&areaMin=35&locations=%5Bcities_6-26%5D&viewType=listing&lang=pl",
    "expired_at": "2024-10-19T21:26:42.699Z"
}
```

Response:
```JSON
{
    "id": 9,
    "slug": "VRD8ldVTTX",
    "url": "https://www.otodom.pl/pl/oferty/sprzedaz/mieszkanie/warszawa?distanceRadius=0&market=ALL&priceMax=500000&areaMin=35&locations=%5Bcities_6-26%5D&viewType=listing&lang=pl",
    "user_id": 1,
    "created_at": "2024-10-19T21:26:42.699Z",
    "updated_at": "2023-02-17T21:37:51.773Z",
    "expired_at": "2022-10-19T21:26:42.699Z"
}
```

### Active Short Url List

GET - `/short_urls`

Request body: There is not

Response:
```JSON
[
    {
        "id": 7,
        "slug": "lol123545",
        "url": "https://www.otodom.pl/pl/oferty/sprzedaz/mieszkanie/warszawa?distanceRadius=0&market=ALL&priceMax=500000",
        "user_id": 1,
        "created_at": "2023-02-17T21:29:26.029Z",
        "updated_at": "2023-02-17T21:29:26.029Z",
        "expired_at": "2023-03-19T21:29:25.994Z"
    },
    {
        "id": 8,
        "slug": "newtest",
        "url": "https://www.otodom.pl/pl/oferty/sprzedaz/mieszkanie/warszawa",
        "user_id": 1,
        "created_at": "2023-02-17T21:29:36.791Z",
        "updated_at": "2023-02-17T21:29:36.791Z",
        "expired_at": "2023-10-19T21:26:42.699Z"
    }
]
```
## Metrics

### Most viewed

GET - `/metrics`

Request body: There is not

Response:
```JSON
[
    {
        "url": "https://www.otodom.pl/pl/oferty/sprzedaz/mieszkanie/warszawa",
        "slug": "sF44QVY5qH",
        "view": 6
    },
    {
        "url": "https://www.otodom.pl/pl/oferty/sprzedaz/mieszkanie",
        "slug": "7kgqZE6dus",
        "view": 1
    }
]
```

### View `ShortUrl` metadata

GET - `/metrics/7kgqZE6dus`

Request body: There is not

Response:
```JSON
{
    "url": "https://www.otodom.pl/pl/oferty/sprzedaz/mieszkanie/warszawa?distanceRadius=0&market=ALL&priceMax=500000&areaMin=35&locations=%5Bcities_6-26%5D&viewType=listing",
    "slug": "7kgqZE6dus",
    "view": 1,
    "metadata": [
        {
            "browser": "Firefox",
            "os": "OS X 10.15",
            "version": {
                "str": "110.0",
                "nil": false,
                "sequences": [
                    110,
                    0
                ],
                "comparable": true
            },
            "platform": "Macintosh",
            "mobile": false,
            "remote_ip": "127.0.0.1"
        }
    ]
}
```

# .ENV
```
JSON_WEB_TOKEN_SECRET_KEY=secret_key
```
