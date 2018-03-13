#? stdtmpl | standard
#import json
#proc generateIndexHTMLPage(title: string, tabs: openarray[JsonNode]): string =
#  result = ""
<head><title>$title</title></head>
<body>
  <div id="menu">
    <ul>
  #for item in items(tabs):
    <li><a href=
    $item["id"]
    >
    $item["name"]
    </a></li>
  #end for
    </ul>
  </div>
</body>