#? stdtmpl | standard
#import json
#proc generateShowHTMLPage(title: string, tab: JsonNode): string =
#  result = ""
<head><title>$title</title></head>
<body>
  <h1>Show user</h1>
  <div id="menu">
    <ul>
    <li>id: ${tab["id"].str}</li>
    <li>name: ${tab["name"].str}</li>
    </ul>
  </div>
</body>
  
