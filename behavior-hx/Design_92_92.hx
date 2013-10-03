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



class Design_92_92 extends ActorScript
{          	
	
public var _IsOpen:Bool;

public var _Openanimation:String;

public var _Closedanimation:String;

public var _Openinganimation:String;

public var _Destination:String;

public var _Actortomove:Actor;

public var _CollectionEvent:String;

public var _SaveExit:Bool;
    public function _customEvent_whenThisHears_CollectionEvent():Void
{
        if(!(_IsOpen))
{
            actor.setAnimation("" + _Openinganimation);
            /* "GA: Unlocked Doors (List)" */
            scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_UnlockExit(_Destination);
            _IsOpen = true;
propertyChanged("_IsOpen", _IsOpen);
            actor.say("Usable Item PM", "_customBlock_SetIsEnabled", [true]);
            saveGame("mySave", function(success:Bool):Void {

});
}

}

    public function _customEvent_UseDoor():Void
{
        /* "Now move to the linked scene" */
        trace("" + (("" + "USE DOOR: ") + ("" + _Destination)));
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


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Is Open?", "_IsOpen");
_IsOpen = false;
nameMap.set("Open animation", "_Openanimation");
nameMap.set("Closed animation", "_Closedanimation");
nameMap.set("Opening animation", "_Openinganimation");
nameMap.set("Destination", "_Destination");
_Destination = "";
nameMap.set("Actor to move", "_Actortomove");
nameMap.set("Collection Event", "_CollectionEvent");
_CollectionEvent = "";
nameMap.set("Save Exit?", "_SaveExit");
_SaveExit = true;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            /* "GA: Unlocked Doors (List)" */
        _IsOpen = cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_IsDoorUnlocked(_Destination)), Bool);
propertyChanged("_IsOpen", _IsOpen);
        if(_IsOpen)
{
            actor.setAnimation("" + _Openanimation);
}

        else
{
            actor.setAnimation("" + _Closedanimation);
}

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

        /* "this delay is to give the usable item behaviour time to set up" */
        runLater(1000 * 0.2, function(timeTask:TimedTask):Void {
                    actor.say("Usable Item PM", "_customBlock_SetIsEnabled", [_IsOpen]);
}, actor);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		if(msg == ("_customEvent_" + _CollectionEvent))
{
_customEvent_whenThisHears_CollectionEvent();
return;
}

	}
}