library NetworkedSolar;

import 'dart:io';
import 'dart:json';
import 'dart:async';


class NetworkedSystem {
  Set<WebSocket> SocketConnections;
  List<Function> OnConnectionEvents;
  List<Function> OnDisconnectionEvents;
  List<Function> OnMessageIncomingEvents;
  
  NetworkedSystem() {
    SocketConnections = new Set<WebSocket>();
    OnConnectionEvents = new List<Function>();
    OnDisconnectionEvents = new List<Function>();
    OnMessageIncomingEvents = new List<Function>();
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
        onError: (e) { 
          OnDisconnect(S);
          SocketConnections.remove(S);
        }   
    );
    
    OnConnectionEvents.forEach((e) {
        e(S);
    });
  }
  
  OnDisconnect(WebSocket S) {
    OnDisconnectionEvents.forEach((e) {
        e(S);
    });
  }
 
  OnMessage(WebSocket S, String Message) 
  {
    OnMessageIncomingEvents.forEach((f) {
          f(S, Message);
    });
  }
  
  AllBarOne(Message, WebSocket Excludee) 
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
  
  SendTo(WebSocket Socket, String Message) {
      Socket.add(Message);
  }
}