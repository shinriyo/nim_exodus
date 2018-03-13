#? stdtmpl | standard
#import json
#proc generateShowHTMLPage(title: string, tab: JsonNode): string =
#  result = ""
<head><title>$title</title></head>
<body>
  <div id="menu">
    <ul>
    <li>Id: ${tab["id"]}</li>
    <li>Name: ${tab["name"]}</li>
    </ul>
  </div>
</body>