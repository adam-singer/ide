function Drive() {
	
}

Drive.prototype.setToken = function(token) {

	gapi.auth.setToken(token);
	
}

Drive.prototype.setApiKey = function(api_key) {
	gapi.client.setApiKey(api_key);
	gapi.client.load('drive', 'v2');
}

Drive.prototype.getFile = function(fileId) {
	var request = gapi.client.drive.files.get({
    	'fileId': fileId
  	});
  	request.execute(function(resp) {
    	console.log('Title: ' + resp.title);
    	console.log('Description: ' + resp.description);
    	console.log('MIME type: ' + resp.mimeType);
  	});
}