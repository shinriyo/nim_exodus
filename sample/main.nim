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
    let hear = """
GET	/users	users#index	すべてのユーザの一覧を表示<br/>
GET	/users/new	users#new	ユーザを1つ作成するためのHTMLフォームを返す<br/>
POST	/users	users#create	ユーザを1つ作成する<br/>
GET	/users/:id	users#show	特定のユーザを表示する<br/>
GET	/users/:id/edit	users#edit	ユーザ編集用のHTMLフォームを1つ返す<br/>
PATCH/PUT	/users/:id	users#update	特定のユーザを更新する<br/>
DELETE	/users/:id	users#destroy	特定のユーザを削除する<br/>
    """
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
    # var params: MultiData = request.formData
    # var name = params["name"].body
    # data: JsonNode = insert(name)
    # resp $data, "application/json"
    try:
      let j = parseJson(request.body)
      var data: JsonNode = insert(j["name"].str)
      resp $data, "application/json"
    except:
      resp Http400, "Unable to parse JSON payload"
  patch "/users/@id":
    # Update
    # var params = request.formData
    # var name: string = params["name"].body
    # var data: JsonNode = update(@"id", name)
    # resp $data, "application/json"
    try:
      let j = parseJson(request.body)
      var data: JsonNode = update(@"id", j["name"].str)
      resp $data, "application/json"
    except:
      resp Http400, "Unable to parse JSON payload"
  delete "/users/@id":
    var data: JsonNode = delete(@"id")
    resp $data, "application/json"

runForever()
  