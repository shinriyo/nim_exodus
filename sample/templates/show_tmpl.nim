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