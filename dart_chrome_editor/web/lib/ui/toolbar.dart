part of ui;

final DivElement toolbar = query("#toolbar");
final ButtonElement open = new ButtonElement();
final ButtonElement update = new ButtonElement();
final DivElement editor = query("#editor");

//https://accounts.google.com/o/oauth2/auth?scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&client_id=897507319316-0j3p4c925ahn7tsej9d8br0gde6vnui0.apps.googleusercontent.com&access_type=offline
//4/bCc8r_BTYkr_DrRRpA05qrTVWY2_.gmBumeh831QcaDn_6y0ZQNj61BxEeQI

void buildToolbar() {

  open.onClick.listen(handleOpen);
  open.text = "o";
  toolbar.children.add(open);
  
  update.onClick.listen(handleUpdate);
  update.text = "u";
  toolbar.children.add(update);
}

void handleOpen(Event e) {
  
  var request = new HttpRequest();
  
  request.onLoad.listen((Event e){
    if (request.status == 200) {
    
      print(request.responseText);

    } else {
      print("Error ${request.status}: ${request.statusText}");
    }
  });
  String fileID = "0B315YrNkj-ZxZGZoVENDMFdIbmc";
  String key = "AIzaSyA0ivauoDqNLjHoQF8Q2jehEEyxVB_ZSX0";
  
  request.open("GET","https://www.googleapis.com/drive/v2/files/${fileID}?key=${key}");
  request.setRequestHeader("Authorization", "Bearer $_token");
  request.send();
  
}

void handleUpdate(Event e) {
  var request = new HttpRequest();
  
  request.onLoad.listen((Event e){
    if (request.status == 200) {
    
      print(request.responseText);

    } else {
      print("Error ${request.status}: ${request.statusText}");
    }
  });
  String fileID = "0B315YrNkj-ZxZGZoVENDMFdIbmc";
  String key = "AIzaSyA0ivauoDqNLjHoQF8Q2jehEEyxVB_ZSX0";
  
  const boundary = '-------314159265358979323846';
  const delimiter = "\r\n--${boundary}\r\n";
  const close_delim = "\r\n--${boundary}--";
  
  request.open("PUT","https://www.googleapis.com/upload/drive/v2/files/${fileID}?key=${key}&alt=json");
  //request.setRequestHeader("","");
  String title = "hellodart2.dart";
  String contentType = "text/plain";
  String content = "a";
  var metadata = {'title':title,'mimeType':contentType};
  
  var base64Data = window.btoa(content);
  
  var multipartRequestBody =
      "$delimiter"
      "Content-Type: application/json\r\n\r\n"
      "${stringify(metadata)}"
      "$delimiter"
      "Content-Type: ${contentType}\r\n"
      //"Content-Transfer-Encoding: base64\r\n"
      //"\r\n"
      //"$base64Data"
      "$close_delim";
  
  
  var data = {'body':multipartRequestBody};
  //request.setRequestHeader("Content-Type","text/plain");
  request.setRequestHeader("Content-Type","multipart/mixed; boundary=\"${boundary}\"");
  request.setRequestHeader("Authorization", "Bearer $_token");
  
  request.send(data);
}

