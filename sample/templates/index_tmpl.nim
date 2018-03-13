#? stdtmpl | standard
#import json
#proc generateIndexHTMLPage(title: string, tabs: openarray[JsonNode]): string =
#  result = ""
<head><title>$title</title></head>
<body>
  <div id="menu">
    <ul>
  #for item in items(tabs):
    <li>
      <a href=users/${item["id"].str}>${item["name"].str}</a>
      <a href=users/${item["id"].str}/edit>編集</a>
    </li>
  #end for
    </ul>
  </div>
</body>