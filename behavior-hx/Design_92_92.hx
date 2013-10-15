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

public var _CollectionEvent:String;
    public function _customEvent_whenThisHears_CollectionEvent():Void
{
        if(!(_IsOpen))
{
            actor.setAnimation("" + _Openinganimation);
            /* "GA: Unlocked Doors (List)" */
            actor.say("Activate Door PM", "_customEvent_" + "UnlockDestination");
            _IsOpen = true;
propertyChanged("_IsOpen", _IsOpen);
            actor.say("Usable Item PM", "_customBlock_SetIsEnabled", [true]);
            saveGame("mySave", function(success:Bool):Void {

});
}

}

    public function _customEvent_UseDoor():Void
{
        actor.say("Activate Door PM", "_customEvent_" + "UseDoor");
}

    public function _customEvent_DoorActivated():Void
{
        _IsOpen = cast((actor.say("Activate Door PM", "_customBlock_IsDoorOpen")), Bool);
propertyChanged("_IsOpen", _IsOpen);
        if(_IsOpen)
{
            actor.setAnimation("" + _Openinganimation);
}

        else
{
            actor.setAnimation("" + _Closedanimation);
}

        /* "GA: Last Scene Name (Text)" */
        actor.say("Usable Item PM", "_customBlock_SetIsEnabled", [_IsOpen]);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Is Open?", "_IsOpen");
_IsOpen = false;
nameMap.set("Open animation", "_Openanimation");
nameMap.set("Closed animation", "_Closedanimation");
nameMap.set("Opening animation", "_Openinganimation");
nameMap.set("Collection Event", "_CollectionEvent");
_CollectionEvent = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            /* "this delay is to give the other behaviours time to set up" */
        /* "GA: Unlocked Doors (List)" */
        runLater(1000 * 0.2, function(timeTask:TimedTask):Void {
                    if()
{

}

                    actor.say("Collectable Door PM", "_customEvent_" + "DoorActivated");
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