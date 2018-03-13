#? stdtmpl | standard
#import json
#proc generateShowHTMLPage(title: string, tab: JsonNode): string =
#  result = ""
<head><title>$title</title></head>
<body>
  <div id="menu">
    <ul>
    <li><a href="${tab}.html">$tab</a></li>
    </ul>
  </div>
</body>