library NetworkManager;
import 'dart:html';
import 'dart:json';
import 'dart:async';

class Entitys {
    int ID; 
}


class ConnectionManager {
   WebSocket _Socket;
   bool IsConnected = false;
   
   ConnectionManager(WebSocket SocketConnection) {
      _Socket = SocketConnection;
      SetupWebSocket();
   }
   
   void SetupWebSocket() {
      _Socket.onOpen.listen((e) {
          IsConnected = true;
          Map<String, Object> Packet = new Map<String, Object>();
          Packet["Test"] = "Hello World";
          SendObject(Packet);
          print("ConnectionManager:_Socket:open | $e"); 
      });
      
      _Socket.onClose.listen((e) {
          IsConnected = false;
          print("ConnectionManager:_Socket:close | $e");
      });
      
      _Socket.onMessage.listen((m) {
          HandleIncomingPacket(m.data);
      });
   }
   
   void SendPacketString(String Packet) {
      if(!IsConnected) {
        print("ConnectedManager:_Socket:SendPacketString | Trying to send packet while connection closed, Packet not sent");
        return;
      } else {
        _Socket.send(Packet);
      }
    }
 
   void SendObject(Object O) {
      SendPacketString(BuildPacket(O));
      print("PacketSent");
   }
 
   
   
   void HandleIncomingPacket(M) {
       Map Packetdata = parse(M);
       print("Inc Packet: $Packetdata");
   }
   
   String BuildPacket(Object Packet) {
      String Data =  stringify(Packet);
      print(Data);
      return Data;
   }
   
   Future RequestEntitys() {
      Completer Complete = new Completer();
      new Timer(new Duration(seconds:2), () {
        Complete.complete([{"id":0, "x":1, "y":2},
                         {"id":1, "x":20, "y":20},
                         {"id":2, "x":40, "y":40}]);
      });
      return Complete.future;
   }
}