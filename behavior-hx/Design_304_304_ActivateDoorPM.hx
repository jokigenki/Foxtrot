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

public var _SaveExit:Bool;

public var _SlideToCentre:Bool;

public var _MoveToLastX:Bool;

public var _DoorReady:Bool;

public var _TargetDoorName:String;

public var _ExitTime:Float;

public var _EntranceTime:Float;
    public function _customEvent_ActivateDoor():Void
{
        if(cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_DoExitsMatch(_Destination,getGameAttribute("Last Destination"))), Bool))
{
            if(!(_DoorReady))
{
                return;
}

            runLater(1000 * _EntranceTime, function(timeTask:TimedTask):Void {
                        _DoorReady = true;
propertyChanged("_DoorReady", _DoorReady);
}, actor);
            _DoorReady = false;
propertyChanged("_DoorReady", _DoorReady);
            _ActorToMove.fadeTo(0 / 100, 0, Linear.easeNone);
            _ActorToMove.fadeTo(1, _EntranceTime, Linear.easeNone);
            _ActorToMove.setY(actor.getY());
            trace("" + actor.getY());
            if(_SlideToCentre)
{
                if((_ExitSide < 0))
{
                    _ActorToMove.setActorValue("Facing Right?", false);
                    _ActorToMove.setX((actor.getXCenter() - (_ActorToMove.getWidth() / 2)));
                    _ActorToMove.moveTo((cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft(actor)), Float) - (_ActorToMove.getWidth() + 5)), _ActorToMove.getY(), _EntranceTime, Expo.easeOut);
}

                else if((_ExitSide > 0))
{
                    _ActorToMove.setActorValue("Facing Right?", true);
                    _ActorToMove.setX((actor.getXCenter() + (_ActorToMove.getWidth() / 2)));
                    _ActorToMove.moveTo((cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorRight(actor)), Float) + 5), _ActorToMove.getY(), _EntranceTime, Expo.easeOut);
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
            runLater(1000 * _ExitSide, function(timeTask:TimedTask):Void {
                        _DoorReady = true;
propertyChanged("_DoorReady", _DoorReady);
}, actor);
            setGameAttribute("Last Destination", _Destination);
            /* "GA: Set Destination Scene (Text) to <Exit Name>" */
            _ActorToMove.setXVelocity(0);
            _ActorToMove.fadeTo(0 / 100, _ExitTime, Quad.easeOut);
            if(_SlideToCentre)
{
                _ActorToMove.moveTo(actor.getX(), (cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorBottom(actor)), Float) - _ActorToMove.getHeight()), _ExitTime, Expo.easeOut);
}

            else if(_MoveToLastX)
{
                setGameAttribute("Last Scene X Position", _ActorToMove.getX());
}

            if((!(("" + _TargetDoorName) == ("")) && !(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorIsNull(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorInScene(_TargetDoorName)), Actor))), Bool))))
{
                runLater(1000 * (_ExitTime + 0.1), function(timeTask:TimedTask):Void {
                            cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorInScene(_TargetDoorName)), Actor).say("Activate Door PM", "_customEvent_" + "ActivateDoor");
}, actor);
}

            else
{
                sayToScene("Scene Transition PM", "_customEvent_" + "SwitchScene");
}

            if(_SaveExit)
{
                setGameAttribute("Save Destination", _Destination);
                saveGame("mySave", function(success:Bool):Void {

});
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
nameMap.set("Save Exit?", "_SaveExit");
_SaveExit = true;
nameMap.set("Slide To Centre?", "_SlideToCentre");
_SlideToCentre = true;
nameMap.set("Move To Last X", "_MoveToLastX");
_MoveToLastX = false;
nameMap.set("Door Ready?", "_DoorReady");
_DoorReady = true;
nameMap.set("Target Door Name", "_TargetDoorName");
_TargetDoorName = "";
nameMap.set("Exit Time", "_ExitTime");
_ExitTime = 0.5;
nameMap.set("Entrance Time", "_EntranceTime");
_EntranceTime = 0.5;
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