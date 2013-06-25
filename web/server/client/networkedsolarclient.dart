import 'dart:html';
import 'dart:json';
import 'dart:async';
import 'connectionmanager.dart';
import 'gamestate/GameStateManager.dart';
import 'gamestate/GameState.dart';
import 'package:stagexl/stagexl.dart';

final IP = 'solardart.herokuapp.com';
final PORT = 80;

GameStateManager GSM;
ConnectionManager ConnManager;

main() {
    ConnManager = new ConnectionManager(new WebSocket("ws://$IP:$PORT/ws"));
    GSM = new GameStateManager("#container");
    GSM.SetState(new DebugState("Debug", GSM));
}

