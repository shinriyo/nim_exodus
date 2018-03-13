import jester, asyncdispatch, json
include "sqlite_controller.nim"

routes:
  get "/":
    resp "Hello World!"
  get "/users/@id":
    var data: JsonNode = select(@"id")
    resp $data, "application/json"
  get "/users":
    var data: seq[JsonNode] = selectAll()
    resp $data, "application/json"
  post "/users":
    var params: MultiData = request.formData
    var name = params["name"].body
    var data: JsonNode = insert(name)
    resp $data, "application/json"
  patch "/users/@id":
    # Update
    var params = request.formData
    var name: string = params["name"].body
    var data: JsonNode = update(@"id", name)
    resp $data, "application/json"
  delete "/users/@id":
    var params = request.formData
    var data: JsonNode = delete(@"id")
    resp $data, "application/json"

runForever()
  
