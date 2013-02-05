part of ui;

final DivElement app = query("#app");
final String api_key = "AIzaSyA0ivauoDqNLjHoQF8Q2jehEEyxVB_ZSX0";
String _token = null;

void initiateLogin() {
  app.style.display = "none";

  js.scoped(() {
    
    js.context.onGetAuthToken = new js.Callback.once(onGetAuthToken);
    
    var oauth = new js.Proxy(js.context.OAuth);
    
    oauth.getAuthToken();
    
  });
}

void onGetAuthToken(auth_token) {
  
  _token = auth_token;
  loadUser();
  
 
}



