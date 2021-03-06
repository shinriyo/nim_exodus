import db_sqlite
import json

let db = open("mydb.db","user","password","dbname")

proc select(id: string): JsonNode =
  # select
  var row: Row = db.getRow(sql"select * from user where id = ?", id)
  var data = %*{"id": row[0], "name": row[1]}
  return data

proc selectAll(): seq[JsonNode] =
  var rows: seq[Row] = db.getAllRows(sql"select * from user")
  var users: seq[JsonNode]
  users = @[]
  for row in rows:
    users.add(%*{"id": row[0], "name": row[1]})
  # select
  return users

proc insert(name: string): JsonNode =
  var id = db.tryInsertId(sql"insert into user (name) values (?)", name)
  var data = %*{"id": id, "name": name}
  return data

proc update(id: string, name: string): JsonNode =
  db.exec(sql"update user set name = ? where id = ?", name, id)
  var data = %*{"id": id, "name": name}
  return data

proc delete(id: string): JsonNode =
  var data = %*{"id": id}
  discard db.tryExec(sql"delete from user where id = ?", id)
  return data


proc create() =
  block:
    let db = open("mydb.db","user","password","dbname")
    let ddl = @[
      sql"drop table user",
      sql"create table user(id integer primary key autoincrement, name varchar(50) not null)"
    ]
    # create db
    for cmd in ddl :
      discard db.tryExec(cmd)
  
