import db_sqlite
import json

proc insert() =
  block:
    let db = open("mydb.db","user","password","dbname")
    let ddl = @[
      sql"""drop table work""",
      sql"""create table work (id integer primary key autoincrement,name varchar(50) not null)"""
    ]
    defer:
      echo "db closed"
      db.close()
    # DDLを実行
    for cmd in ddl :
      discard db.tryExec(cmd)
    # レコードを挿入
    db.exec(sql"BEGIN")
    # 追加したれコードに自動採番された値を取り出す
    echo "追加されたID=",db.tryInsertID(sql"insert into work(name) values(?)","Mr.スポック" )
    echo "追加されたID=",db.tryInsertID(sql"insert into work(name) values(?)","Mr.ビーン" )
    echo "追加されたID=",db.tryInsertID(sql"insert into work(name) values(?)","Mr.サタン" )
    echo "更新された行=",db.execAffectedRows(sql"update work set name=? where id=?","Mr.ホームズ",3)
    db.exec(sql"COMMIT")

proc select(id: string): JsonNode =
  block:
    let db = open("mydb.db","user","password","dbname")

    # select
    var row: Row = db.getRow(sql"select * from work where id = ?", id)
    var data = %*{"id": row[0], "name": row[1]}
    return data

proc selectAll(): seq[JsonNode] =
  block:
    let db = open("mydb.db","user","password","dbname")
    var rows: seq[Row] = db.getAllRows(sql"select * from work")
    var users: seq[JsonNode]
    users = @[]
    for row in rows:
      users.add(%*{"id": row[0], "name": row[1]})
    # select
    return users

proc insert(name: string): untyped =
    let db = open("mydb.db","user","password","dbname")
    var id = db.tryInsertId(sql"insert into work (name) values (?)", name)
    var data = %*{"id": id, "name": name}
    return data

proc delete() =
  block:
    let db = open("mydb.db","user","password","dbname")
    let ddl = @[
      sql"""drop table work""",
      sql"""create table work (id integer primary key autoincrement,name varchar(50) not null)"""
    ]
    defer:
      echo "db closed"
      db.close()
    # DDLを実行
    for cmd in ddl :
      discard db.tryExec(cmd)

    # セレクトする
    for x in db.fastRows(sql"select id,name from work order by id") :
      echo x
    # var data = %*[{"id": "id"}, {"id": "id"}]