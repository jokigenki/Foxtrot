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

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;



class SceneEvents_46 extends SceneScript
{          	
	
public var _ExitName:String;

public var _EggBall:Actor;
    public function _customEvent_JumpStart():Void
{
        _EggBall.disableBehavior("Match Horizontal Movement PM");
}


 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";
nameMap.set("Egg Ball", "_EggBall");

	}
	
	override public function init()
	{
		            runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_LockDoorActor(getActor(4));
                    _EggBall = getActor(6);
propertyChanged("_EggBall", _EggBall);
}, null);
    addWhenTypeGroupKilledListener(getActorType(757), function(eventActor:Actor, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        trace("" + "EGG BALL KILLED!");
        createRecycledActor(getActorType(757), getActor(3).getX(), 262, Script.FRONT);
        getLastCreatedActor().setValue("Match Horizontal Movement PM", "_Target", getActor(3));
        getLastCreatedActor().setValue("Jump To Start PM", "_Target", getActor(3));
        _EggBall = getLastCreatedActor();
propertyChanged("_EggBall", _EggBall);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}