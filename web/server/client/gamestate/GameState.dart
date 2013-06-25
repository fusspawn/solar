library GameState;

import 'dart:html';
import 'GameObject.dart';
import 'package:stagexl/stagexl.dart';
import 'GameStateManager.dart';


class GameState extends GameObject {
  
     Function OnUpdate;
     Function OnEnter;
     Function OnExit;
     
     Stage StateStage;
     GameStateManager StageManager;
     
     GameState(String Name, GameStateManager GSM) {
          this.Tag = Name;
          this.StageManager = GSM;
          this.StateStage = new Stage(this.Tag, query(StageManager.StageContainer));
     }
     
     ResetStage() {
          this.StateStage = new Stage(this.Tag, query(StageManager.StageContainer));
     }
}


class DebugState extends GameState {
    DebugState(String Name, GameStateManager Manager)
      : super(Name, Manager)
    {
          this.OnUpdate = OnUpdateFunc;
          this.OnEnter = OnEnterFunc;
    }
    
    OnUpdateFunc() {
         print("Updating");
    }
    
    OnEnterFunc() {
        print("Entering DebugState");
        Shape shape = new Shape();
        shape.graphics.circle(10, 10, 10);
        shape.graphics.fillColor(Color.Red);
        this.StateStage.addChild(shape);
    }
    
    OnExitFunc() {
        ResetStage();
    }
}