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
      // console.table(users);
      alert("Delete success.");
      location.reload();
    } else {
      // console.error(users);
      alert("Delete failed");
    }
  }
  xhr.send(null);
}
</script>
<body>
  <h1>users List</h1>
  <div id="menu">
    <ul>
  #for item in items(tabs):
    <li>
      <a href=users/${item["id"].str}>${item["name"].str}</a>
      <a href=users/${item["id"].str}/edit>Edit</a>
      <a href="javascript:deleteUser(${item["id"].str});">Delete</a>
    </li>
  #end for
    </ul>
  </div>
  <a href="users/new">New</a>
</body>
  
