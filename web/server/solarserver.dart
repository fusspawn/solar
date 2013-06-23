import 'dart:io';
import 'dart:json';
import 'dart:async';
import 'staticfiles.dart';
import 'NetworkConnectionManager.dart';


final IP = '127.0.0.1';
final PORT = 80;
HttpServer WebServer;
NetworkedSystem NetworkConnectionManager;
StaticFileHandler StaticFiles;

main() {
    NetworkConnectionManager = new NetworkedSystem();
    StaticFiles = new StaticFileHandler("C:/Users/Fuss/dart/solar/web/client");
    _start_network_server();
    _bind_network_events();
}

void _bind_network_events() {
}

void _start_network_server() {
  HttpServer.bind(IP, PORT)
  .then((HttpServer server) {
    print('listening for connections on $PORT');
    
    var sc = new StreamController();
    sc.stream
    .transform(new WebSocketTransformer())
    .listen(NetworkConnectionManager.OnConnection);

    server.listen((HttpRequest request) {
      if (request.uri.path == '/ws') {
        sc.add(request);
      } else {
        print("was static handler");
        StaticFiles.HandleFile(request);
      }
    });
  },
  onError: (error) => print("Error starting HTTP server: $error"));
}


