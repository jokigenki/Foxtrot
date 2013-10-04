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



class Design_61_61_HorizontalOscillationPM extends ActorScript
{          	
	
public var _MotionRegion:Region;

public var _CurrentVelocity:Float;

public var _XSpeed:Float;

public var _IsActive:Bool;

public var _HasSwitchedDirection:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Motion Region", "_MotionRegion");
nameMap.set("Current Velocity", "_CurrentVelocity");
_CurrentVelocity = 0.0;
nameMap.set("X Speed", "_XSpeed");
_XSpeed = 0.0;
nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Has Switched Direction?", "_HasSwitchedDirection");
_HasSwitchedDirection = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _CurrentVelocity = asNumber(_XSpeed);
propertyChanged("_CurrentVelocity", _CurrentVelocity);
        _HasSwitchedDirection = false;
propertyChanged("_HasSwitchedDirection", _HasSwitchedDirection);
        actor.setXVelocity(_CurrentVelocity);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(!(_IsActive))
{
            actor.setXVelocity(0);
            return;
}

        if(isInRegion(actor, _MotionRegion))
{
            _HasSwitchedDirection = false;
propertyChanged("_HasSwitchedDirection", _HasSwitchedDirection);
}

        else if(!(_HasSwitchedDirection))
{
            _CurrentVelocity = asNumber(-(_CurrentVelocity));
propertyChanged("_CurrentVelocity", _CurrentVelocity);
            _HasSwitchedDirection = true;
propertyChanged("_HasSwitchedDirection", _HasSwitchedDirection);
}

        actor.setXVelocity(_CurrentVelocity);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}