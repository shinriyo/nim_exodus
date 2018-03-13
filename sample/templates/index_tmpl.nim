#? stdtmpl | standard
#import json
#proc generateIndexHTMLPage(title: string, tabs: openarray[JsonNode]): string =
#  result = ""
<head><title>$title</title></head>
<body>
  <div id="menu">
    <ul>
  #for item in items(tabs):
    <li><a href=users/${item["id"]}>${item["name"].str}</a></li>
  #end for
    </ul>
  </div>
</body>