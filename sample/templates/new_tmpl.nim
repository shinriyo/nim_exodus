#? stdtmpl | standard
#proc generateNewHTMLPage(title: string): string =
#  result = ""
<head><title>$title</title></head>
<script>
// Post a user
function createUser() {
  var url = "../../users";
  var data = {};
  data.name = document.myform["name"].value;
  var json = JSON.stringify(data);
  
  var xhr = new XMLHttpRequest();
  xhr.open("POST", url, true);
  xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
  xhr.onload = function () {
  	var users = JSON.parse(xhr.responseText);
  	if (xhr.readyState == 4 && xhr.status == "201") {
      console.table(users);
  	} else {
  		console.error(users);
  	}
  }
  xhr.send(json);
}
</script>
<body>
  <form name="myform" onSubmit="JavaScript:createUser()">
  <p>
  名前：<input type="text" name="name">
  </p>
  <p>
  <input type="submit" value="送信する">
  <input type="reset" value="入力内容をリセットする">
  </p>
  </form>
  <a href="../../users">戻る</a>
</body>
  