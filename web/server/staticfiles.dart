import 'dart:io';
import 'dart:json';
import 'dart:async';


class StaticFileHandler {
    String BaseDir;
    Map<String, String> contentTypes = const {
      "html": "text/html; charset=UTF-8",
      "dart": "application/dart",
      "js": "application/javascript", 
    };
    
    
    StaticFileHandler(String Base) {
      BaseDir = Base;
    }
    
    void HandleFile(HttpRequest req) {
        print("Handling Static Files");
        
        String path = BaseDir + req.uri.path;
        print(path);
        File file = new File(path);
        file.exists().then((bool exists) { 
            if(!exists)
            {
              print("file not found");
              print(path);
              req.response.write("404");
              req.response.close();
              return;
            }
            
            print("File was found at path: $path");
          
            file.readAsString()    
            .then((String text) {
              //req.response.headers.set(HttpHeaders.CONTENT_TYPE, getContentType(file));
              req.response.write(text);
              req.response.close();
              print("Connection Closed");
            });  
        });
    }
    
    String getContentType(File file) => contentTypes[file.path.split(".").last];
}