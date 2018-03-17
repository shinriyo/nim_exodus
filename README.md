# Nim Exodus

template gernerator like Rails scaffoldings.

## Install

  nimble install nim_exodus

## Required

  nim
  nimble

  (not yet)
  nimble install yaml

## Command

* scaffold

  ./nim_exodus [g|generate] scaffold [fieldName]:[fieldType]

* ex

  ./nim_exodus g scaffold user name:string

## Options

-type html (default)

  * feature supports

JSON
React
Karax

-db sqlie (default)

  feature supports
  postgresql or postgres

## Sample

`sample` folder

It is image of scadfdolding.

  nim c -r json_app.nim

## curl

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

