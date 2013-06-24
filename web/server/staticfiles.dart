library StaticFileHandler;

import 'dart:io';
import 'dart:async';
import 'package:pathos/path.dart' as path;

class StaticFileHandler {
    String BaseDir; 
    
    StaticFileHandler(String Base) {
      BaseDir = Base;
    }
   
    void HandleFile(HttpRequest req) {
        String _path = Directory.current.path + BaseDir + req.uri.path;
        String RelativePath = _path;
        print(RelativePath);
        File file = new File(RelativePath);
        file.exists().then((bool exists) { 
            if(!exists)
            {
              print("file not found");
              print(RelativePath);
              req.response.write("No such file: $RelativePath");
              req.response.close();
              return;
            }
          
            file.readAsString()    
            .then((String text) {
              req.response.write(text);
              req.response.close();
              print("Connection Closed");
            });  
        });
    }
  
}