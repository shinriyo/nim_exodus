#? stdtmpl | standard
#proc generateNewHTMLPage(title, currentTab, content: string
#                      ): string =
#  result = ""
<head><title>$title</title></head>
<body>
  <form action="./" method="post">
  <p>
  名前：<input type="text" name="name">
  </p>
  <p>
  <input type="submit" value="送信する">
  <input type="reset" value="入力内容をリセットする">
  </p>
  </form>
</body>
  