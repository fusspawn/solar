import 'dart:io';
import 'dart:async';


class StaticFileHandler {
    String BaseDir; 
    
    StaticFileHandler(String Base) {
      BaseDir = Base;
    }
   
    void HandleFile(HttpRequest req) {
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
          
            file.readAsString()    
            .then((String text) {
              req.response.write(text);
              req.response.close();
              print("Connection Closed");
            });  
        });
    }
  
}