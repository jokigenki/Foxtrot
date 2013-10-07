package scripts;

import com.stencyl.graphics.G;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.utils.Utils;

import nme.ui.Mouse;
import nme.display.Graphics;
import nme.display.BlendMode;
import nme.events.Event;
import nme.events.TouchEvent;
import nme.net.URLLoader;

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Back;
import com.eclecticdesignstudio.motion.easing.Cubic;
import com.eclecticdesignstudio.motion.easing.Elastic;
import com.eclecticdesignstudio.motion.easing.Expo;
import com.eclecticdesignstudio.motion.easing.Linear;
import com.eclecticdesignstudio.motion.easing.Quad;
import com.eclecticdesignstudio.motion.easing.Quart;
import com.eclecticdesignstudio.motion.easing.Quint;
import com.eclecticdesignstudio.motion.easing.Sine;



class Design_304_304_ActivateDoorPM extends ActorScript
{          	
	
public var _ExitSide:Float;

public var _Destination:String;

public var _ActorToMove:Actor;

public var _TargetDoor:Actor;

public var _SaveExit:Bool;

public var _SlideToCentre:Bool;

public var _MoveToLastX:Bool;

public var _DoorReady:Bool;
    public function _customEvent_ActivateDoor():Void
{
        if(cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_DoExitsMatch(_Destination,getGameAttribute("Last Destination"))), Bool))
{
            if(!(_DoorReady))
{
                return;
}

            runLater(1000 * 0.5, function(timeTask:TimedTask):Void {
                        _DoorReady = true;
propertyChanged("_DoorReady", _DoorReady);
}, actor);
            _DoorReady = false;
propertyChanged("_DoorReady", _DoorReady);
            _ActorToMove.fadeTo(0 / 100, 0, Linear.easeNone);
            _ActorToMove.fadeTo(1, 0.5, Linear.easeNone);
            _ActorToMove.setY(actor.getY());
            if(_SlideToCentre)
{
                if((_ExitSide < 0))
{
                    _ActorToMove.setActorValue("Facing Right?", false);
                    _ActorToMove.setX((actor.getXCenter() - (_ActorToMove.getWidth() / 2)));
                    _ActorToMove.moveTo((cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft(actor)), Float) - (_ActorToMove.getWidth() + 5)), _ActorToMove.getYCenter(), 0.5, Expo.easeOut);
}

                else if((_ExitSide > 0))
{
                    _ActorToMove.setActorValue("Facing Right?", true);
                    _ActorToMove.setX((actor.getXCenter() + (_ActorToMove.getWidth() / 2)));
                    _ActorToMove.moveTo((cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorRight(actor)), Float) + 5), _ActorToMove.getYCenter(), 0.5, Expo.easeOut);
}

                else
{
                    _ActorToMove.setX(actor.getX());
                    _ActorToMove.setY(actor.getY());
}

}

            else if(_MoveToLastX)
{
                _ActorToMove.setX(getGameAttribute("Last Scene X Position"));
}

}

}

    public function _customEvent_UseDoor():Void
{
        if(!(_Destination == "none"))
{
            if(!(_DoorReady))
{
                return;
}

            _DoorReady = false;
propertyChanged("_DoorReady", _DoorReady);
            runLater(1000 * 0.5, function(timeTask:TimedTask):Void {
                        _DoorReady = true;
propertyChanged("_DoorReady", _DoorReady);
}, actor);
            setGameAttribute("Last Destination", _Destination);
            /* "GA: Set Destination Scene (Text) to <Exit Name>" */
            _ActorToMove.setXVelocity(0);
            _ActorToMove.fadeTo(0 / 100, 0.5, Quad.easeOut);
            if(_SlideToCentre)
{
                _ActorToMove.moveBy((actor.getXCenter() - _ActorToMove.getXCenter()), 0, 0.5, Expo.easeOut);
}

            else if(_MoveToLastX)
{
                setGameAttribute("Last Scene X Position", _ActorToMove.getX());
}

            if((hasValue(_TargetDoor) != false))
{
                runLater(1000 * 0.6, function(timeTask:TimedTask):Void {
                            _TargetDoor.say("Activate Door PM", "_customEvent_" + "ActivateDoor");
}, actor);
}

            else
{
                sayToScene("Scene Transition PM", "_customEvent_" + "SwitchScene");
}

            if(_SaveExit)
{
                setGameAttribute("Save Destination", _Destination);
}

}

}

    public function _customEvent_UnlockDestination():Void
{
        scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_UnlockExit(_Destination);
}

    

/* Params are: */
public function _customBlock_IsDoorOpen():Bool
{
var __Self:Actor = actor;
        return (cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_IsDoorUnlocked(_Destination)), Bool) || (getCurrentSceneName() == _Destination));
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Exit Side", "_ExitSide");
_ExitSide = 0.0;
nameMap.set("Destination", "_Destination");
_Destination = "";
nameMap.set("Actor To Move", "_ActorToMove");
nameMap.set("Target Door", "_TargetDoor");
nameMap.set("Save Exit?", "_SaveExit");
_SaveExit = true;
nameMap.set("Slide To Centre?", "_SlideToCentre");
_SlideToCentre = true;
nameMap.set("Move To Last X", "_MoveToLastX");
_MoveToLastX = false;
nameMap.set("Door Ready?", "_DoorReady");
_DoorReady = true;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            actor.say("Activate Door PM", "_customEvent_" + "ActivateDoor");

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}