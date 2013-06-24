import 'dart:html';
import 'dart:json';
import 'dart:async';
import 'connectionmanager.dart';
import 'package:stagexl/stagexl.dart';

final IP = 'solardart.herokuapp.com';
final PORT = 80;

ConnectionManager ConnManager;
Stage GameStage;
RenderLoop GameRenderLoop;




main() {
    ConnManager = new ConnectionManager(new WebSocket("ws://$IP:$PORT/ws"));
    GameStage = new Stage("mystage", query("#container"));
    GameRenderLoop = new RenderLoop();
    GameRenderLoop.addStage(GameStage);
    
    ConnManager.RequestEntitys().then((Ents) {
        Ents.forEach((M) {
            Shape S = new Shape();
            S.graphics.circle(M["x"], M["y"], 20);
            S.graphics.fillColor(Color.Red);
            GameStage.addChild(S);
        });
    });
}

