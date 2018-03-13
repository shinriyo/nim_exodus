#? stdtmpl | standard
#import json
#proc generateIndexHTMLPage(title: string, tabs: openarray[JsonNode]): string =
#  result = ""
<head><title>$title</title></head>
<script>
 // Delete a user
function deleteUser(id) {
  var url = "users/" + id;
  var xhr = new XMLHttpRequest();
  xhr.open("DELETE", url, true);
  xhr.onload = function () {
  	var users = JSON.parse(xhr.responseText);
  	if (xhr.readyState == 4 && xhr.status == "200") {
  		console.table(users);
  	} else {
      console.error(users);
  	}
  }
  xhr.send(null);
}
</script>
<body>
  <div id="menu">
    <ul>
  #for item in items(tabs):
    <li>
      <a href=users/${item["id"].str}>${item["name"].str}</a>
      <a href=users/${item["id"].str}/edit>編集</a>
      <a href="javascript:deleteUser(${item["id"].str});">削除</a>
    </li>
  #end for
    </ul>
  </div>
</body>