# nim_exodus

## Command

nim c -r index.nim

## Options

-type html (default)

JSON
React
Karax

-db sqlie (default)

postgresql or postgres

## Sample

It is image of scadfdolding.

---
nim c -r json_app.nim
---

* curl

- select

    curl localhost:5000/users/1

- select all

    curl localhost:5000/users

- insert

    curl -F name=test localhost:5000/users

- update

    curl -X PATCH -F name=hoge localhost:5000/users/1

- delete

    curl -X DELETE -F localhost:5000/users/1

