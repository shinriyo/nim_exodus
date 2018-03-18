[日本語]: README.jp.md
[繁體中文]: README.zh-tw.md
[简体中文]: README.zh-cn.md
[한국어]: README.ko.md
[Русский]: README.ru.md
[Português]: README.pt.md
[Türkçe]: README.tr.md
[Español]: README.es.md
[Français]: README.fr.md
[Català]: README.ca.md
[Deutsch]: README.du.md
[فارسی]: README.fa.md

# Exodus

Template gernerator like Rails scaffoldings.


Translations: [日本語], [繁體中文], [简体中文], [한국어], [Русский], [Português], [Türkçe], [Español], [Français], [Català], [Deutsch], [فارسی].

<div class="centered">
<img src="https://i.imgur.com/rzYIP9u.png" alt="Exodus logs" />
</div>

<div class="centered">
<img src="https://i.imgur.com/eP4WhXZ.jpg" alt="Moses" />
</div>

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

