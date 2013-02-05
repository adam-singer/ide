part of ui;

final DivElement header = query("#header");
final DivElement nameDiv = new DivElement();
final DivElement mugshot = new DivElement();

//chrome://settings/search#Sign%20in

void buildHeader() {

  nameDiv.style
  ..marginLeft = "0.5em"
  ..marginRight = "0.5em"  
  ..display = "inline"
  ..float = "right";
  header.children.add(nameDiv);
  
  mugshot.style
  ..marginLeft = "0.5em"
  ..marginRight = "0.5em"
  ..display = "inline"
  ..float = "right";
  header.children.add(mugshot);
  
}

void loadUser() {

  var request = new HttpRequest();
  
  request.onLoad.listen((Event e){
    if (request.status == 200) {
      var user_data = parse(request.responseText);
      setMugShot(user_data["picture"]);
      setName(user_data["name"]);
      
      app.style.display = "block";
    } else {
      print("Error ${request.status}: ${request.statusText}");
    }
  });
  
  request.open("GET","https://www.googleapis.com/oauth2/v1/userinfo?alt=json");
  request.setRequestHeader("Authorization", "Bearer $_token");
  request.send();
}

void setMugShot(String url) {
  ImageElement image = new ImageElement();
  image.src = url;
  image.onLoad.listen((Event e){
    image.width = 27;
    image.height = 27;
  });
  
  mugshot.children.clear();
  mugshot.children.add(image);
}

void setName(String name) {
  nameDiv.text = name;
}