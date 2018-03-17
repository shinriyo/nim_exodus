import os
import jester, asyncdispatch, json
import httpcore
include "templates/index_tmpl.nim"
include "templates/new_tmpl.nim"
include "templates/edit_tmpl.nim"
include "templates/show_tmpl.nim"
include "sqlite_controller.nim"

var title: string = "Scaffolding"
routes:
  get "/":
    let hear = "GET	/users	users#index	Show all users<br/>" &
               "GET	/users/new	users#new	show HTML for create a user<br/>" &
               "POST	/users	users#create create a user<br/>" &
               "GET	/users/:id	users#show show a user<br/>" &
               "GET	/users/:id/edit	users#edit show HTML for edit user form<br/>" &
               "PATCH/PUT	/users/:id	users#update update a user<br/>" &
               "DELETE	/users/:id	users#destroy delete a user<br/>"
    resp hear
  get "/users":
    var data: seq[JsonNode] = selectAll()
    resp generateIndexHTMLPage(title, data)
  get "/users/new":
    resp generateNewHTMLPage(title)
  get "/users/@id/edit":
    var data: JsonNode = select(@"id")
    resp generateEditHTMLPage(title, data)
  get "/users/@id":
    var data: JsonNode = select(@"id")
    resp generateShowHTMLPage(title, data)

  post "/users":
    try:
      let j = parseJson(request.body)
      var data: JsonNode = insert(j["name"].str)
      resp $data, "application/json"
    except:
      resp Http400, "Unable to parse JSON payload"
  patch "/users/@id":
    # Update
    try:
      let j = parseJson(request.body)
      var data: JsonNode = update(@"id", j["name"].str)
      resp $data, "application/json"
    except:
      resp Http400, "Unable to parse JSON payload"
  delete "/users/@id":
    var data: JsonNode = delete(@"id")
    resp $data, "application/json"


var cnt = paramCount()

if cnt > 0:
  var paraArg = paramStr(1)
  var arg: string = paraArg
  if arg in ["init"]:
    create()
    echo "db was created."
else:
  runForever()
  
