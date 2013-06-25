library GameStateManager;

import 'dart:json';
import 'dart:async';
import 'GameState.dart';
import 'package:stagexl/stagexl.dart';


class GameStateManager {
    GameState ActiveState;
    String StageContainer;
    
    RenderLoop Loop;
    bool IsActive;
    
    GameStateManager(String StageContainerQuery) {
        Loop = new RenderLoop();
        StageContainer = StageContainerQuery;
    }
    
    SetState(GameState S) {
        if(ActiveState != null) {
            Loop.removeStage(ActiveState.StateStage);
            if(ActiveState.OnExit != null)
                ActiveState.OnExit();
        }
        
        if(S != null && S.OnEnter != null)
            S.OnEnter();
        
        ActiveState = S;
        Loop.addStage(S.StateStage);
    }
}