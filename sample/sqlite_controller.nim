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

proc delete() =
  block:
    let db = open("mydb.db","user","password","dbname")
    let ddl = @[
      sql"""drop table work""",
      sql"""create table work (id integer primary key autoincrement,name varchar(50) not null)"""
    ]
    # DDLを実行
    for cmd in ddl :
      discard db.tryExec(cmd)

    # セレクトする
    for x in db.fastRows(sql"select id,name from work order by id") :
      echo x
    # var data = %*[{"id": "id"}, {"id": "id"}]