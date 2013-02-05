function OAuth() {

}

OAuth.prototype.getAuthToken = function () {
	chrome.experimental.identity.getAuthToken({ 'interactive': true }, onGetAuthToken);
}