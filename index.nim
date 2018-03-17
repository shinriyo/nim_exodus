import os

proc main() =
  let dir = "templates"
  if not existsDir(dir):
    createDir(dir)

  var index_template_name = "templates/index_tmpl.nim"
  var index_template_fp = open(index_template_name, fmWrite)

  var index_hear = """
#? stdtmpl | standard
#import json
#proc generateIndexHTMLPage(title: string, tabs: openarray[JsonNode]): string =
#  result = ""
<head><title>$title</title></head>
<script>
 // Delete a user
function deleteUser(id) {
  var url = "users/" + id;
  var xhr = new XMLHttpRequest();
  xhr.open("DELETE", url, true);
  xhr.onload = function () {
    var users = JSON.parse(xhr.responseText);
    if (xhr.readyState == 4 && xhr.status == "200") {
      // console.table(users);
      alert("Delete success.");
      location.reload();
    } else {
      // console.error(users);
      alert("Delete failed");
    }
  }
  xhr.send(null);
}
</script>
<body>
  <div id="menu">
    <ul>
  #for item in items(tabs):
    <li>
      <a href=users/${item["id"].str}>${item["name"].str}</a>
      <a href=users/${item["id"].str}/edit>Edit</a>
      <a href="javascript:deleteUser(${item["id"].str});">Delete</a>
    </li>
  #end for
    </ul>
  </div>
  <a href="users/new">New</a>
</body>
  """

  index_template_fp.write(index_hear)
  index_template_fp.write("\n")
  defer: index_template_fp.close()

  let new_template_name = "templates/new_tmpl.nim"
  var new_template_fp = open(new_template_name, fmWrite)

  var new_hear = """
#? stdtmpl | standard
#proc generateNewHTMLPage(title: string): string =
#  result = ""
<head><title>$title</title></head>
<script>
// Post a user
function createUser() {
  var url = "../../users";
  var data = {};
  data.name = document.myform["name"].value;
  var json = JSON.stringify(data);
  
  var xhr = new XMLHttpRequest();
  xhr.open("POST", url, true);
  xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
  xhr.onload = function () {
    var users = JSON.parse(xhr.responseText);
    if (xhr.readyState == 4 && xhr.status == "201") {
      console.table(users);
    } else {
      console.error(users);
    }
  }
  xhr.send(json);
}
</script>
<body>
  <form name="myform" onSubmit="JavaScript:createUser()">
  <p>
  Name: <input type="text" name="name">
  </p>
  <p>
  <input type="submit" value="Submit">
  <input type="reset" value="Reset">
  </p>
  </form>
  <a href="../../users">Return</a>
</body>
  """

  new_template_fp.write(new_hear)
  new_template_fp.write("\n")
  defer: new_template_fp.close()

  let edit_template_name = "templates/edit_tmpl.nim"
  var edit_template_fp = open(edit_template_name, fmWrite)

  var edit_hear = """
#? stdtmpl | standard
#import json
#proc generateEditHTMLPage(title: string, tab: JsonNode): string =
#  result = ""
<head><title>$title</title></head>
<script>
// Update a user
function updateUser(id) {
  var url = "../../users/" + id;
  var data = {};
  data.name = document.myform["name"].value;
  var json = JSON.stringify(data);

  var xhr = new XMLHttpRequest();
  xhr.open("PATCH", url, true);
  xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
  xhr.onload = function () {
    var users = JSON.parse(xhr.responseText);
    if (xhr.readyState == 4 && xhr.status == "200") {
      console.table(users);
    } else {
      console.error(users);
    }
  }
  xhr.send(json);
}
</script>
<body>
  <form name="myform" onSubmit="JavaScript:updateUser(${tab["id"].str})">
  <p>
  Name: <input type="text" name="name" value=${tab["name"].str}>
  </p>
  <p>
  <input type="submit" value="Submit">
  <input type="reset" value="Reset">
  </p>
  </form>

  <a href="../../users">Return</a>
</body>
  """

  edit_template_fp.write(edit_hear)
  edit_template_fp.write("\n")
  defer: edit_template_fp.close()

  let show_template_name = "templates/show_tmpl.nim"
  var show_template_fp = open(show_template_name, fmWrite)

  var show_hear = """
#? stdtmpl | standard
#import json
#proc generateShowHTMLPage(title: string, tab: JsonNode): string =
#  result = ""
<head><title>$title</title></head>
<body>
  <div id="menu">
    <ul>
    <li>Id: ${tab["id"].str}</li>
    <li>Name: ${tab["name"].str}</li>
    </ul>
  </div>
</body>
  """

  # html  
  show_template_fp.write(show_hear)
  show_template_fp.write("\n")
  defer: show_template_fp.close()

  # nim
  var nim_name = "main.nim"
  var nim_fp = open(nim_name, fmWrite)
  let nim_hear = """
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

runForever()
  """

  # nim roure
  nim_fp.write(nim_hear)
  nim_fp.write("\n")
  defer: nim_fp.close()

  # controller
  var sc_name = "sqlite_controller.nim"
  var sc_fp = open(sc_name, fmWrite)
  let sc_hear = """
import db_sqlite
import json

let db = open("mydb.db","user","password","dbname")

proc select(id: string): JsonNode =
  # select
  var row: Row = db.getRow(sql"select * from work where id = ?", id)
  var data = %*{"id": row[0], "name": row[1]}
  return data

proc selectAll(): seq[JsonNode] =
  var rows: seq[Row] = db.getAllRows(sql"select * from work")
  var users: seq[JsonNode]
  users = @[]
  for row in rows:
    users.add(%*{"id": row[0], "name": row[1]})
  # select
  return users

proc insert(name: string): JsonNode =
  var id = db.tryInsertId(sql"insert into work (name) values (?)", name)
  var data = %*{"id": id, "name": name}
  return data

proc update(id: string, name: string): JsonNode =
  db.exec(sql"update work set name = ? where id = ?", name, id)
  var data = %*{"id": id, "name": name}
  return data

proc delete(id: string): JsonNode =
  var data = %*{"id": id}
  discard db.tryExec(sql"delete from work where id = ?", id)
  return data
  """

  sc_fp.write(sc_hear)
  sc_fp.write("\n")
  defer: sc_fp.close()

main()

var cnt = paramCount()
if cnt > 1:
  var i = 1
  while i <= cnt:
    var paraName = paramStr(i)
    var paraArg = paramStr(i + 1)
    # increment i by 2
    inc(i, 2)
