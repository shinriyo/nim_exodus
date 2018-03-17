import os
import strutils

type
  Field* = object
    fieldName*, fieldType*: string

proc scaffoldiong(modelName: string, fields: seq[Field]) =
  # TODO: just add s, so fix feature.
  var pluralModelName = modelName & "s"
  var capModelName = capitalizeAscii(modelName)

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
// Delete a -modelName-
function delete-capModelName-(id) {
  var url = "-pluralModelName-/" + id;
  var xhr = new XMLHttpRequest();
  xhr.open("DELETE", url, true);
  xhr.onload = function () {
    var -pluralModelName- = JSON.parse(xhr.responseText);
    if (xhr.readyState == 4 && xhr.status == "200") {
      // console.table(-pluralModelName-);
      alert("Delete success.");
      location.reload();
    } else {
      // console.error(-pluralModelName-);
      alert("Delete failed");
    }
  }
  xhr.send(null);
}
</script>
<body>
  <h1>-pluralModelName- List</h1>
  <div id="menu">
    <ul>
  #for item in items(tabs):
    <li>
      <a href=-pluralModelName-/${item["id"].str}>${item["-fieldName-"].str}</a>
      <a href=-pluralModelName-/${item["id"].str}/edit>Edit</a>
      <a href="javascript:delete-capModelName-(${item["id"].str});">Delete</a>
    </li>
  #end for
    </ul>
  </div>
  <a href="-pluralModelName-/new">New</a>
</body>
  """

  index_hear = index_hear.replace("-modelName-", modelName)
  index_hear = index_hear.replace("-pluralModelName-", pluralModelName)
  index_hear = index_hear.replace("-capModelName-", capModelName)

  # TODO: support more than 2
  var fieldName = fields[0].fieldName
  # fields[0].fieldType
  index_hear = index_hear.replace("-fieldName-", fieldName)

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
// Post a -modelName-
function create-capModelName-() {
  var url = "../../-pluralModelName-";
  var data = {};
  data.-fieldName- = document.myform["-fieldName-"].value;
  var json = JSON.stringify(data);
  
  var xhr = new XMLHttpRequest();
  xhr.open("POST", url, true);
  xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
  xhr.onload = function () {
    var -pluralModelName- = JSON.parse(xhr.responseText);
    if (xhr.readyState == 4 && xhr.status == "201") {
      console.table(-pluralModelName-);
    } else {
      console.error(-pluralModelName-);
    }
  }
  xhr.send(json);
}
</script>
<body>
  <h1>New -modelName-</h1>
  <form name="myform" onSubmit="JavaScript:create-capModelName-()">
  <p>
  -fieldName-: <input type="text" name="-fieldName-">
  </p>
  <p>
  <input type="submit" value="Submit">
  <input type="reset" value="Reset">
  </p>
  </form>
  <a href="../../-pluralModelName-">Return</a>
</body>
  """

  new_hear = new_hear.replace("-modelName-", modelName)
  new_hear = new_hear.replace("-pluralModelName-", pluralModelName)
  new_hear = new_hear.replace("-capModelName-", capModelName)
  new_hear = new_hear.replace("-fieldName-", fieldName)

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
// Update a -modelName-
function update-capModelName-(id) {
  var url = "../../-pluralModelName-/" + id;
  var data = {};
  data.-fieldName- = document.myform["-fieldName-"].value;
  var json = JSON.stringify(data);

  var xhr = new XMLHttpRequest();
  xhr.open("PATCH", url, true);
  xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
  xhr.onload = function () {
    var -pluralModelName- = JSON.parse(xhr.responseText);
    if (xhr.readyState == 4 && xhr.status == "200") {
      console.table(-pluralModelName-);
    } else {
      console.error(-pluralModelName-);
    }
  }
  xhr.send(json);
}
</script>
<body>
  <h1>Edit -modelName-</h1>
  <form name="myform" onSubmit="JavaScript:update-capModelName-(${tab["id"].str})">
  <p>
  -fieldName-: <input type="text" name="-fieldName-" value=${tab["-fieldName-"].str}>
  </p>
  <p>
  <input type="submit" value="Submit">
  <input type="reset" value="Reset">
  </p>
  </form>

  <a href="../../-pluralModelName-">Return</a>
</body>
  """

  edit_hear = edit_hear.replace("-modelName-", modelName)
  edit_hear = edit_hear.replace("-pluralModelName-", pluralModelName)
  edit_hear = edit_hear.replace("-capModelName-", capModelName)
  edit_hear = edit_hear.replace("-fieldName-", fieldName)

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
  <h1>Show -modelName-</h1>
  <div id="menu">
    <ul>
    <li>Id: ${tab["id"].str}</li>
    <li>-fieldName-: ${tab["-fieldName-"].str}</li>
    </ul>
  </div>
</body>
  """

  show_hear = show_hear.replace("-modelName-", modelName)
  show_hear = show_hear.replace("-pluralModelName-", pluralModelName)
  show_hear = show_hear.replace("-capModelName-", capModelName)
  show_hear = show_hear.replace("-fieldName-", fieldName)

  # html  
  show_template_fp.write(show_hear)
  show_template_fp.write("\n")
  defer: show_template_fp.close()

  # nim
  var nim_name = "main.nim"
  var nim_fp = open(nim_name, fmWrite)
  var nim_hear = """
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
    let hear = "GET	/-pluralModelName-	-pluralModelName-#index	すべてのユーザの一覧を表示<br/>" &
               "GET	/-pluralModelName-/new	-pluralModelName-#new	ユーザを1つ作成するためのHTMLフォームを返す<br/>" &
               "POST	/-pluralModelName-	-pluralModelName-#create	ユーザを1つ作成する<br/>" &
               "GET	/-pluralModelName-/:id	-pluralModelName-#show	特定のユーザを表示する<br/>" &
               "GET	/-pluralModelName-/:id/edit	-pluralModelName-#edit	ユーザ編集用のHTMLフォー&ムを1つ返す<br/>" &
               "PATCH/PUT	/-pluralModelName-/:id	-pluralModelName-#update	特定のユーザを更新する<br/>" &
               "DELETE	/-pluralModelName-/:id	-pluralModelName-#destroy	特定のユーザを削除する<br/>"
    resp hear
  get "/-pluralModelName-":
    var data: seq[JsonNode] = selectAll()
    resp generateIndexHTMLPage(title, data)
  get "/-pluralModelName-/new":
    resp generateNewHTMLPage(title)
  get "/-pluralModelName-/@id/edit":
    var data: JsonNode = select(@"id")
    resp generateEditHTMLPage(title, data)
  get "/-pluralModelName-/@id":
    var data: JsonNode = select(@"id")
    resp generateShowHTMLPage(title, data)

  post "/-pluralModelName-":
    try:
      let j = parseJson(request.body)
      var data: JsonNode = insert(j["-fieldName-"].str)
      resp $data, "application/json"
    except:
      resp Http400, "Unable to parse JSON payload"
  patch "/-pluralModelName-/@id":
    # Update
    try:
      let j = parseJson(request.body)
      var data: JsonNode = update(@"id", j["-fieldName-"].str)
      resp $data, "application/json"
    except:
      resp Http400, "Unable to parse JSON payload"
  delete "/-pluralModelName-/@id":
    var data: JsonNode = delete(@"id")
    resp $data, "application/json"

create()
runForever()
  """

  nim_hear = nim_hear.replace("-modelName-", modelName)
  nim_hear = nim_hear.replace("-pluralModelName-", pluralModelName)
  nim_hear = nim_hear.replace("-capModelName-", capModelName)
  nim_hear = nim_hear.replace("-fieldName-", fieldName)

  # nim roure
  nim_fp.write(nim_hear)
  nim_fp.write("\n")
  defer: nim_fp.close()

  # controller
  var sc_name = "sqlite_controller.nim"
  var sc_fp = open(sc_name, fmWrite)
  var sc_hear = """
import db_sqlite
import json

let db = open("mydb.db","-modelName-","password","dbname")

proc select(id: string): JsonNode =
  # select
  var row: Row = db.getRow(sql"select * from -modelName- where id = ?", id)
  var data = %*{"id": row[0], "-fieldName-": row[1]}
  return data

proc selectAll(): seq[JsonNode] =
  var rows: seq[Row] = db.getAllRows(sql"select * from -modelName-")
  var -pluralModelName-: seq[JsonNode]
  -pluralModelName- = @[]
  for row in rows:
    -pluralModelName-.add(%*{"id": row[0], "-fieldName-": row[1]})
  # select
  return -pluralModelName-

proc insert(name: string): JsonNode =
  var id = db.tryInsertId(sql"insert into -modelName- (name) values (?)", name)
  var data = %*{"id": id, "-fieldName-": name}
  return data

proc update(id: string, name: string): JsonNode =
  db.exec(sql"update -modelName- set name = ? where id = ?", name, id)
  var data = %*{"id": id, "-fieldName-": name}
  return data

proc delete(id: string): JsonNode =
  var data = %*{"id": id}
  discard db.tryExec(sql"delete from -modelName- where id = ?", id)
  return data


proc create() =
  block:
    let db = open("mydb.db","-modelName-","password","dbname")
    let ddl = @[
      sql"drop table -modelName-",
      sql"create table -modelName-(id integer primary key autoincrement, name varchar(50) not null)"
    ]
    # create db
    for cmd in ddl :
      discard db.tryExec(cmd)
  """

  sc_hear = sc_hear.replace("-modelName-", modelName)
  sc_hear = sc_hear.replace("-pluralModelName-", pluralModelName)
  sc_hear = sc_hear.replace("-capModelName-", capModelName)
  sc_hear = sc_hear.replace("-fieldName-", fieldName)

  sc_fp.write(sc_hear)
  sc_fp.write("\n")
  defer: sc_fp.close()

var cnt = paramCount()

var isGenerate = false
var modelName = ""

var i = 1
if cnt > 1:
  var paraName = paramStr(i)
  var paraArg = paramStr(i + 1)

  if paraName in ["generate", "g"]:
    isGenerate = true
    modelName = paraArg 

if isGenerate and cnt > 2:
  inc(i, 1)

  # TODO: later more than 2 supports
  var fields: seq[Field] = @[]

  while i <= cnt:
    var pa: string = paramStr(i)
    var arr = pa.split(":")
    if arr.len == 2:
      var name: string = arr[0]
      echo "arr"
      var fieldType: string = arr[1]

      var field = Field(
        fieldName: name,
        fieldType: fieldType
      )

      fields.add(field)
    # increment i by 1
    inc(i, 1)

  scaffoldiong(modelName , fields)
  echo ""
  echo "Yay! Run server command below."
  echo "> nim c -r main.nim"