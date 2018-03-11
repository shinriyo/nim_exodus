import os

proc main() =

  let dir = "templates"
  if not existsDir(dir):
    createDir(dir)

  var template_name = "templates/mytempl.nim"
  var template_fp = open(template_name, fmWrite)

  let hear = """
#? stdtmpl | standard
#proc generateHTMLPage(title, currentTab, content: string,
#                      tabs: openArray[string]): string =
#  result = ""
<head><title>$title</title></head>
<body>
  <div id="menu">
    <ul>
  #for tab in items(tabs):
    #if currentTab == tab:
    <li><a id="selected"
    #else:
    <li><a
    #end if
    href="${tab}.html">$tab</a></li>
  #end for
    </ul>
  </div>
  <div id="content">
    $content
    A dollar: $$.
  </div>
</body>
  """

  # html  
  template_fp.write(hear)
  template_fp.write("\n")

  defer: template_fp.close()

  # nim
  let nim_name = "main.nim"
  var nim_fp = open(nim_name, fmWrite)
  let nim = """
import jester, asyncdispatch, json
import httpcore
include "templates/mytempl.nim"

routes:
  get "/":
    resp "Hello World!"
  post "/receive_json":
    try:
      let j = parseJson(request.body)
    except:
      resp Http400, "Unable to parse JSON payload"

  # Using an HTML template from http://nim-lang.org/docs/filters.html
  get "/generated_page":
    resp generateHTMLPage("foo", "bar", "baz", ["fuga", "bar"])

runForever()
  """

  # html
  nim_fp.write(nim)
  nim_fp.write("\n")
      
  defer: nim_fp.close()

  # json
  var json_name = "json_app.nim"
  var json_fp = open(json_name, fmWrite)

  let json_nim = """
import jester, asyncdispatch, json

routes:
  get "/":
    resp "Hello World!"
  get "/users/@id":
    var data = %*{"id": @"id"}
    resp $data, "application/json"

runForever()
  """

  json_fp.write(json_nim)
  json_fp.write("\n")
  defer: json_fp.close()

main()
