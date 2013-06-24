// Auto-generated from networkedsolar.html.
// DO NOT EDIT.

library networkedsolar_html;

import 'dart:html' as autogenerated;
import 'dart:svg' as autogenerated_svg;
import 'package:web_ui/web_ui.dart' as autogenerated;
import 'package:web_ui/observe/observable.dart' as __observe;
import 'dart:html';
import 'dart:json';
import 'dart:async';
import '../connectionmanager.dart';
import 'package:stagexl/stagexl.dart';


// Original code


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


// Additional generated code
void init_autogenerated() {
  var __root = autogenerated.document.body;
  var __t = new autogenerated.Template(__root);
  __t.create();
  __t.insert();
}

//# sourceMappingURL=networkedsolarclient.dart.map