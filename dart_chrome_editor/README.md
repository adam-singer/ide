For more information about packaged apps, see 
http://developer.chrome.com/apps/about_apps.html.

`web/manifest.json` describes the Chrome packaged application.

`web/main.js` is the entry point to the application; it launches 
`web/dart_chrome_editor.html`. `web/dart_chrome_editor.html` and `web/dart_chrome_editor.dart` 
are the entry points to the Dart application.

`web/dart_chrome_editor.html` script tags included and modified since chrome apps 
don't have dart support, only javascript should be loaded. 
