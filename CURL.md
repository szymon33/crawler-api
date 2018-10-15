# Sample cURL sessions

## Simple test server status

```
curl -I http://api.example.com:3000/v1/status
```

```json
HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
Content-Type: application/json; charset=utf-8
Etag: W/"0c776997933eb60833b37beaf43814c8"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: f3256273-56d0-4706-8479-34691a06c839
X-Runtime: 0.333736
Server: WEBrick/1.3.1 (Ruby/2.3.1/2016-04-26)
Date: Mon, 15 Oct 2018 14:21:04 GMT
Content-Length: 0
Connection: Keep-Alive
```

## Successful scenario

```
curl -G "http://api.example.com:3000/v1/search" --data-urlencode "query=Mortgages – a beginner’s guide"

```

```json
{ 
  "en": {
    "title": "Mortgages – a beginner’s guide",
    "url": "https://www.moneyadviceservice.org.uk/en/articles/mortgages-a-beginners-guide"
  },
  "cy": {
    "title": "Morgeisi – canllaw i ddechreuwyr",
    "url": "https://www.moneyadviceservice.org.uk/cy/articles/morgeisi-canllaw-i-ddechreuwyr"
  }
}
```

```
curl -G "http://api.example.com:3000/v1/search" --data-urlencode "query=money advise service"
```

```json
{
  "en": {
    "title": "Money Advice Toolkits",
    "url":"https://www.moneyadviceservice.org.uk/en/corporate/toolkits-parhub"
  },
  "cy": {
    "title": "Pecynnau Cymorth Cyngor Ariannol",
    "url": "https://www.moneyadviceservice.org.uk/cy/corporate/pecynnau-cymorth-cyngor-ariannol"
  }
}
```

## Failing scenario

```
curl -G -I "http://api.example.com:3000/v1/search" --data-urlencode "query=hello world"
```

```json
HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
Content-Type: application/json; charset=utf-8
Etag: W/"99914b932bd37a50b983c5e7c90ae93b"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: d0b032c2-4f6f-414c-81a1-6addef4f61d8
X-Runtime: 0.472668
Server: WEBrick/1.3.1 (Ruby/2.3.1/2016-04-26)
Date: Mon, 15 Oct 2018 14:56:51 GMT
Content-Length: 0
Connection: Keep-Alive
```

```
curl -G "http://api.example.com:3000/v1/search" --data-urlencode "query=hello world"
```

```json
{}
```
