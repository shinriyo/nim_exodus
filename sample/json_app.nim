import jester, asyncdispatch, json
include "sqlite_controller.nim"

routes:
  get "/":
    resp "Hello World!"
  get "/users/@id":
    var row = select(@"id")
    var data = %*{"id": row[0], "name": row[1]}
    resp $data, "application/json"
  get "/users":
    var data = selectAll()
    resp $data, "application/json"

runForever()
  
