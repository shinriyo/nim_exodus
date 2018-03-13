#? stdtmpl | standard
#import json
#proc generateEditHTMLPage(title: string, tab: JsonNode): string =
#  result = ""
<head><title>$title</title></head>
<body>
  <form action="./" method="post">
  <p>
  名前：<input type="text" name="name" value=${tab["name"].str}>
  </p>
  <p>
  <input type="submit" value="送信する">
  <input type="reset" value="入力内容をリセットする">
  </p>
  </form>

  <a href="../../users">戻る</a>
</body>
  