import 'dart:io';
import 'dart:json';
import 'dart:async';


class NetworkedSystem {
  Set<WebSocket> SocketConnections;
  
  NetworkedSystem() {
    SocketConnections = new Set<WebSocket>();
  }
  
  OnConnection(WebSocket S) 
  {
    SocketConnections.add(S);
    S.listen(
        (Message) 
        {
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