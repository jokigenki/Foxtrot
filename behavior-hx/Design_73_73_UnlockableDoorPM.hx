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



class Design_73_73_UnlockableDoorPM extends ActorScript
{          	
	
public var _IsOpen:Bool;

public var _Openanimation:String;

public var _Closedanimation:String;

public var _Openinganimation:String;

public var _DoorRegion:Region;

public var _Destination:String;

public var _Canusedoor:Bool;

public var _HasUsedDoor:Bool;

public var _Actortomove:Actor;

public var _DoorIsReady:Bool;

public var _KeyTypes:Array<Dynamic>;

public var _Actorbydoor:Actor;

public var _ActorType:ActorType;

public var _SaveExit:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Is Open?", "_IsOpen");
_IsOpen = false;
nameMap.set("Open animation", "_Openanimation");
nameMap.set("Closed animation", "_Closedanimation");
nameMap.set("Opening animation", "_Openinganimation");
nameMap.set("Door Region", "_DoorRegion");
nameMap.set("Destination", "_Destination");
_Destination = "";
nameMap.set("Can use door?", "_Canusedoor");
_Canusedoor = false;
nameMap.set("Has Used Door?", "_HasUsedDoor");
_HasUsedDoor = false;
nameMap.set("Actor to move", "_Actortomove");
nameMap.set("Door Is Ready?", "_DoorIsReady");
_DoorIsReady = false;
nameMap.set("Key Types", "_KeyTypes");
_KeyTypes = [];
nameMap.set("Actor by door", "_Actorbydoor");
nameMap.set("Actor Type", "_ActorType");
nameMap.set("Save Exit?", "_SaveExit");
_SaveExit = true;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            /* "GA: Unlocked Doors (List)" */
        _IsOpen = (cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_IsDoorUnlocked(_Destination)), Bool) || (getCurrentSceneName() == _Destination));
propertyChanged("_IsOpen", _IsOpen);
        createBoxRegion((actor.getXCenter() - 2), (actor.getYCenter() - 10), 4, 4);
        _DoorRegion = getLastCreatedRegion();
propertyChanged("_DoorRegion", _DoorRegion);
        if(_IsOpen)
{
            actor.setAnimation("" + _Openanimation);
}

        else
{
            actor.setAnimation("" + _Closedanimation);
}

        _Canusedoor = false;
propertyChanged("_Canusedoor", _Canusedoor);
        _HasUsedDoor = false;
propertyChanged("_HasUsedDoor", _HasUsedDoor);
        /* "GA: Last Scene Name (Text)" */
        if(!(_Destination == "none"))
{
            /* "GA: Last Scene Name (Text)" */
            if(cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_DoExitsMatch(_Destination,getGameAttribute("Last Destination"))), Bool))
{
                _Actortomove.setX(actor.getX());
                _Actortomove.setY(actor.getY());
}

}

        /* "prevent the player returning through the door until a second has elapsed" */
        _DoorIsReady = false;
propertyChanged("_DoorIsReady", _DoorIsReady);
        runLater(1000 * 1, function(timeTask:TimedTask):Void {
                    _DoorIsReady = true;
propertyChanged("_DoorIsReady", _DoorIsReady);
}, actor);
    addActorEntersRegionListener(_DoorRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(_ActorType,a.getType(),a.getGroup())){
        _Canusedoor = false;
propertyChanged("_Canusedoor", _Canusedoor);
        /* "Custom: Key from Inventory" */
        if(_IsOpen)
{
            /* "Custom: Set Prevent Jump to <true> for <the actor>" */
            a.say("Jumping PM", "_customBlock_SetPreventJump", [true]);
            _Canusedoor = true;
propertyChanged("_Canusedoor", _Canusedoor);
            _Actorbydoor = a;
propertyChanged("_Actorbydoor", _Actorbydoor);
}

}
});
    addActorExitsRegionListener(_DoorRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(_ActorType,a.getType(),a.getGroup())){
        /* "Custom: Set Prevent Jump to <false> for <the actor>" */
        a.say("Jumping PM", "_customBlock_SetPreventJump", [false]);
        _Canusedoor = false;
propertyChanged("_Canusedoor", _Canusedoor);
}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(!(_DoorIsReady))
{
            return;
}

        if(_HasUsedDoor)
{
            _Canusedoor = false;
propertyChanged("_Canusedoor", _Canusedoor);
}

        /* "Custom: Is \"UseObject\" on for <Actor by door>" */
        if((_Canusedoor && cast((_Actorbydoor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["UseObject"])), Bool)))
{
            _HasUsedDoor = true;
propertyChanged("_HasUsedDoor", _HasUsedDoor);
            _Canusedoor = false;
propertyChanged("_Canusedoor", _Canusedoor);
            /* "If the door isn't already unlocked, unlock it and tell the game the door is unlocked" */
            if(!(_IsOpen))
{
                actor.setAnimation("" + _Openinganimation);
                scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_UnlockExit(_Destination);
}

            /* "Now move to the linked scene" */
            if(!(_Destination == "none"))
{
                setGameAttribute("Last Destination", _Destination);
                _Actortomove.setXVelocity(0);
                _Actortomove.fadeTo(0 / 100, 0.5, Quad.easeOut);
                _Actortomove.moveBy((actor.getXCenter() - _Actortomove.getXCenter()), 0, 0.5, Expo.easeOut);
                sayToScene("Scene Transition PM", "_customEvent_" + "SwitchScene");
                if(_SaveExit)
{
                    setGameAttribute("Save Destination", _Destination);
}

}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}