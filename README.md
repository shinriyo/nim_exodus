# Nim Exodus

template gernerator like Rails scaffoldings.

## Required (not yet)

nimble install yaml

## Command

* scaffold

  nim c -r index.nim [g|generate] scaffold [fieldName]:[fieldType]

* ex

  nim c -r index.nim g scaffold user name:string

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

