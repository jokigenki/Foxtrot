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



class Design_99_99 extends ActorScript
{          	
	
public var _DoorRegion:Region;

public var _Destination:String;

public var _Canusedoor:Bool;

public var _HasUsedDoor:Bool;

public var _Actortomove:Actor;

public var _Actorbydoor:Actor;

public var _ExitSide:Float;

public var _SaveExit:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Door Region", "_DoorRegion");
nameMap.set("Destination", "_Destination");
_Destination = "";
nameMap.set("Can use door?", "_Canusedoor");
_Canusedoor = false;
nameMap.set("Has Used Door?", "_HasUsedDoor");
_HasUsedDoor = false;
nameMap.set("Actor to move", "_Actortomove");
nameMap.set("Actor by door", "_Actorbydoor");
nameMap.set("Exit Side", "_ExitSide");
_ExitSide = 0.0;
nameMap.set("Actor", "actor");
nameMap.set("Save Exit?", "_SaveExit");
_SaveExit = true;

	}
	
	override public function init()
	{
		            actor.disableActorDrawing();
        /* "GA: Unlocked Doors (List)" */
        trace("" + (("" + cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop(actor)), Float)) + ("" + (("" + "") + ("" + cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorBottom(actor)), Float))))));
        createBoxRegion((actor.getXCenter() - 2), cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop(actor)), Float), 4, (cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorBottom(actor)), Float) - cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop(actor)), Float)));
        _DoorRegion = getLastCreatedRegion();
propertyChanged("_DoorRegion", _DoorRegion);
        _Canusedoor = false;
propertyChanged("_Canusedoor", _Canusedoor);
        _HasUsedDoor = false;
propertyChanged("_HasUsedDoor", _HasUsedDoor);
        /* "GA: Last Scene Name (Text)" */
        if(!(getGameAttribute("Last Destination") == "none"))
{
            /* "GA: Last Scene Name (Text)" */
            if(cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_DoExitsMatch(_Destination,getGameAttribute("Last Destination"))), Bool))
{
                _Actortomove.fadeTo(0 / 100, 0, Linear.easeNone);
                _Actortomove.fadeTo(1, 0.5, Linear.easeNone);
                _Actortomove.setY(actor.getY());
                if((_ExitSide < 0))
{
                    _Actortomove.setActorValue("Facing Right?", false);
                    _Actortomove.setX((actor.getXCenter() - (_Actortomove.getWidth() / 2)));
                    _Actortomove.moveTo((cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft(actor)), Float) - (_Actortomove.getWidth() + 5)), _Actortomove.getYCenter(), 0.5, Expo.easeOut);
}

                else if((_ExitSide > 0))
{
                    _Actortomove.setActorValue("Facing Right?", true);
                    _Actortomove.setX((actor.getXCenter() + (_Actortomove.getWidth() / 2)));
                    _Actortomove.moveTo((cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorRight(actor)), Float) + 5), _Actortomove.getYCenter(), 0.5, Expo.easeOut);
}

}

}

    addActorEntersRegionListener(_DoorRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(9),a.getType(),a.getGroup())){
        if(isTransitioning())
{
            return;
}

        trace("" + "hit");
        _Canusedoor = true;
propertyChanged("_Canusedoor", _Canusedoor);
        _Actorbydoor = a;
propertyChanged("_Actorbydoor", _Actorbydoor);
        if(_HasUsedDoor)
{
            _Canusedoor = false;
propertyChanged("_Canusedoor", _Canusedoor);
}

        /* "Custom: Is \"UseObject\" on for <Actor by door>" */
        if(_Canusedoor)
{
            _HasUsedDoor = true;
propertyChanged("_HasUsedDoor", _HasUsedDoor);
            _Canusedoor = false;
propertyChanged("_Canusedoor", _Canusedoor);
            /* "Now move to the linked scene" */
            if(!(_Destination == "none"))
{
                setGameAttribute("Last Destination", _Destination);
                /* "GA: Set Destination Scene (Text) to <Exit Name>" */
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
    addActorExitsRegionListener(_DoorRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(9),a.getType(),a.getGroup())){
        _Canusedoor = false;
propertyChanged("_Canusedoor", _Canusedoor);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}