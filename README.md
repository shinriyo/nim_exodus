# Exodus

Template gernerator like Rails scaffoldings.

## Install

	nimble install nim_exodus

## Required

- nim
- nimble

	nimble install yaml
  (not yet)

## Command

* scaffold

	./exodus [g|generate] scaffold [fieldName]:[fieldType]

* ex

	./exodus g scaffold user name:string

## Options

	-type html (default)

* feature supports

- JSON
- React
- Karax

	-db sqlie (default)

*feature supports

** postgresql
** postgres

## Sample

`sample` folder

It is image of scadfdolding.

	nim c -r json_app.nim

## curl samples

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

