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



class Design_408_408_RandomTimedActivationPM extends ActorScript
{          	
	
public var _MinTime:Float;

public var _MaxTime:Float;

public var _StartActive:Bool;

public var _IsActive:Bool;
    

/* Params are:__Self */
public function _customBlock_SwitchActive():Void
{
var __Self:Actor = actor;
        if(actor.isAlive())
{
            if(_IsActive)
{
                actor.shout("_customEvent_" + "Deactivated");
                _IsActive = false;
propertyChanged("_IsActive", _IsActive);
}

            else
{
                actor.shout("_customEvent_" + "Activated");
                _IsActive = true;
propertyChanged("_IsActive", _IsActive);
}

            runLater(1000 * randomInt(Math.floor(_MinTime), Math.floor(_MaxTime)), function(timeTask:TimedTask):Void {
                        actor.say("Random Timed Activation PM", "_customBlock_SwitchActive");
}, actor);
}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Min Time", "_MinTime");
_MinTime = 0.0;
nameMap.set("Max Time", "_MaxTime");
_MaxTime = 0.0;
nameMap.set("Start Active?", "_StartActive");
_StartActive = false;
nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _IsActive = _StartActive;
propertyChanged("_IsActive", _IsActive);
        runLater(1000 * randomInt(Math.floor(_MinTime), Math.floor(_MaxTime)), function(timeTask:TimedTask):Void {
                    actor.say("Random Timed Activation PM", "_customBlock_SwitchActive");
}, actor);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}