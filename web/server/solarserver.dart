import 'dart:io';
import 'dart:json';
import 'dart:async';
import 'staticfiles.dart';


final IP = '127.0.0.1';
final PORT = 80;
HttpServer WebServer;
NetworkedSystem NetworkConnectionManager;
StaticFileHandler StaticFiles;

main() {
    NetworkConnectionManager = new NetworkedSystem();
    StaticFiles = new StaticFileHandler("C:/Users/Fuss/dart/solar/web/client");
    _start_server();
}

void _start_server() {
  HttpServer.bind(IP, PORT)
  .then((HttpServer server) {
    print('listening for connections on $PORT');
    
    var sc = new StreamController();
    sc.stream
    .transform(new WebSocketTransformer())
    .listen(NetworkConnectionManager.OnConnection);

    server.listen((HttpRequest request) {
      if (request.uri.path == '/ws') {
        print("Incoming Websocket Request");
        sc.add(request);
      } else {
        print("was static handler");
        StaticFiles.HandleFile(request);
      }
    });
  },
  onError: (error) => print("Error starting HTTP server: $error"));
}


class NetworkedSystem {
  Set<WebSocket> SocketConnections;
  
  NetworkedSystem() {
    SocketConnections = new Set<WebSocket>();
  }
  
  OnConnection(WebSocket S) 
  {
    SocketConnections.add(S);
    S.listen((Message) {
            OnMessage(S, Message);
        },
        onDone: () => SocketConnections.remove(S),
        onError: (e) => SocketConnections.remove(S)    
    );
  }
 
  OnMessage(WebSocket S, String Message) 
  {
      S.add(Message);
  }
  
  AllBarOne(Message, Excludee) 
  { 
      SocketConnections.forEach((WebSocket S) {
          if(S != Excludee)
            S.add(S);
      });
  }
  
  All(Message)
  { 
      SocketConnections.forEach((WebSocket S) {
          S.add(Message);
      });
  }
}