import "dart:io";

final Path WATCHED_FILE = new Path.raw("web/dart_chrome_editor.dart");

bool get isWindows => Platform.operatingSystem == 'windows';
Path get sdkBinPath => new Path(new Options().executable).directoryPath;
Path get dart2jsPath => sdkBinPath.append(isWindows ? 'dart2js.bat' : 'dart2js');

/// This quick and dirty build script watches for changes to any .dart files
/// and re-compiles dart_chrome_editor.dart using dart2js. The --disallow-unsafe-eval
/// flag causes dart2js to output CSP (and Chrome app) friendly code.
void main() {
  var args = new Options().arguments;
  
  bool fullBuild = args.contains("--full");
  bool dartFilesChanged = args.any(
      (arg) => arg.startsWith("--changed=") && arg.endsWith(".dart"));

  if (fullBuild || dartFilesChanged) {
    callDart2js(WATCHED_FILE.toNativePath());
  }
  
  copyDependencies();
}

void callDart2js(String path) {
  print("dart2js --disallow-unsafe-eval -enable-checked-mode ${path}");

  Process.run(dart2jsPath.toNativePath(),
    ['--disallow-unsafe-eval', '--enable-checked-mode', '-o${path}.js', path]
  ).then((result) {
    if (result.stdout.length > 0) {
      print("${result.stdout.replaceAll('\r\n', '\n')}");
    }

    if (result.exitCode != 0) {
      exit(result.exitCode);
    }
  });
}

void copyDependencies() {
  String targetPath = "web/lib/ext/";
  String sourcePath = "packages/browser/";
  
  String name = "dart.js";
  
  File f = new File("${sourcePath}$name");
  f.exists().then((v){
    f.readAsString().then((s){
      File fw = new File("${targetPath}$name");
      fw.create().then((c){
        fw.writeAsString(s).then((o){
          print("Copied: ${f.name}");
        });
      });
    });
  });
  
  sourcePath = "packages/js/";
  name = "dart_interop.js";
  
  f = new File("${sourcePath}$name");
  f.exists().then((v){
    f.readAsString().then((s){
      File fw = new File("${targetPath}$name");
      fw.create().then((c){
        fw.writeAsString(s).then((o){
          print("Copied: ${f.name}");
        });
      });
    });
  });
}
