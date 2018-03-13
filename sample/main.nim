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
    resp "Hello World!"
  # GET	/photos	photos#index	すべての写真の一覧を表示
  # GET	/photos/new	photos#new	写真を1つ作成するためのHTMLフォームを返す
  # POST	/photos	photos#create	写真を1つ作成する
  # GET	/photos/:id	photos#show	特定の写真を表示する
  # GET	/photos/:id/edit	photos#edit	写真編集用のHTMLフォームを1つ返す
  # PATCH/PUT	/photos/:id	photos#update	特定の写真を更新する
  # DELETE	/photos/:id	photos#destroy	特定の写真を削除する
  # Using an HTML template from http://nim-lang.org/docs/filters.html
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
  
