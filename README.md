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

## Why Exodus?

* It is troublesome to create templates.

* From old testament

<div class="centered">
<img src="https://i.imgur.com/eP4WhXZ.jpg" alt="Moses" />
</div>

## Install

1. use nimble

	nimble install nim_exodus

2. set path, if you forgot.


set the command below in `.config/fish/config.fish`, if you use `fish` shell.

	set -x PATH ~/.nimble/bin $PATH

or

set the command below in `.bashrc` or `.bash_profile`, if you use `bash` or `zsh` shell.

	export PATH=$PATH:~/.nimble/bin

## Required

- nim
- nimble

	nimble install yaml
  (not yet)

## Command

* scaffold

	exodus [g|generate] scaffold [fieldName]:[fieldType]

* ex

	exodus g scaffold user name:string

## Options

	-type html (default)

### feature supports

- JSON
- React
- Karax

	-db sqlie (default)

### feature supports

- postgresql
- postgres

## Compile (for my notes)

	nim c --out:bin/exodus -r src/exodus.nim

you can get binary file in bin/exodus.

## Sample

`sample` folder

It is image of scadfdolding.

	nimble build

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

