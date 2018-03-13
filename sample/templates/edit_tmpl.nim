#? stdtmpl | standard
#import json
#proc generateEditHTMLPage(title: string, tab: JsonNode): string =
#  result = ""
<head><title>$title</title></head>
<script>
// Update a user
function updateUser(id) {
  var url = "../../users/" + id;
  var data = {};
  data.name = document.myform["name"].value;
  var json = JSON.stringify(data);

  var xhr = new XMLHttpRequest();
  xhr.open("PATCH", url, true);
  xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
  xhr.onload = function () {
    var users = JSON.parse(xhr.responseText);
    if (xhr.readyState == 4 && xhr.status == "200") {
      console.table(users);
    } else {
      console.error(users);
    }
  }
  xhr.send(json);
}
</script>
<body>
  <form name="myform" onSubmit="JavaScript:updateUser(${tab["id"].str})">
  <p>
  Name: <input type="text" name="name" value=${tab["name"].str}>
  </p>
  <p>
  <input type="submit" value="Submit">
  <input type="reset" value="Reset">
  </p>
  </form>

  <a href="../../users">Return</a>
</body>
  