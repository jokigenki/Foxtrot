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



class Design_242_242_TimedActivationPM extends ActorScript
{          	
	
public var _InitialDelay:Float;

public var _IsActive:Bool;

public var _DelayBeforeActivate:Float;

public var _DelayBeforeDeactivate:Float;

public var _IsRunning:Bool;
    public function _customEvent_ToggleActive():Void
{
        _IsActive = !(_IsActive);
propertyChanged("_IsActive", _IsActive);
        _IsRunning = false;
propertyChanged("_IsRunning", _IsRunning);
        if(_IsActive)
{
            actor.say("Activate On Event PM", "_customEvent_" + "Activate");
            if((_DelayBeforeDeactivate > 0))
{
                _IsRunning = true;
propertyChanged("_IsRunning", _IsRunning);
                runLater(1000 * _DelayBeforeDeactivate, function(timeTask:TimedTask):Void {
                            actor.say("Timed Activation PM", "_customEvent_" + "ToggleActive");
}, actor);
}

            else
{
                actor.say("Timed Activation PM", "_customEvent_" + "ToggleActive");
}

}

        else
{
            actor.say("Activate On Event PM", "_customEvent_" + "Deactivate");
            if((_DelayBeforeActivate > 0))
{
                _IsRunning = true;
propertyChanged("_IsRunning", _IsRunning);
                runLater(1000 * _DelayBeforeActivate, function(timeTask:TimedTask):Void {
                            actor.say("Timed Activation PM", "_customEvent_" + "ToggleActive");
}, actor);
}

            else
{
                actor.say("Timed Activation PM", "_customEvent_" + "ToggleActive");
}

}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Initial Delay", "_InitialDelay");
_InitialDelay = 0.0;
nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Delay Before Activate", "_DelayBeforeActivate");
_DelayBeforeActivate = 0.0;
nameMap.set("Delay Before Deactivate", "_DelayBeforeDeactivate");
_DelayBeforeDeactivate = 0.0;
nameMap.set("Is Running?", "_IsRunning");
_IsRunning = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if((_InitialDelay > 0))
{
            _IsRunning = true;
propertyChanged("_IsRunning", _IsRunning);
            runLater(1000 * _InitialDelay, function(timeTask:TimedTask):Void {
                        actor.say("Timed Activation PM", "_customEvent_" + "ToggleActive");
}, actor);
}

        else
{
            actor.say("Timed Activation PM", "_customEvent_" + "ToggleActive");
}

    addPropertyChangeListener("_IsActive", null, function(property:Dynamic, list:Array<Dynamic>):Void {
if(wrapper.enabled && cast(property, Bool) == true){
        if(!(_IsRunning))
{
            if((_InitialDelay > 0))
{
                runLater(1000 * _InitialDelay, function(timeTask:TimedTask):Void {
                            actor.say("Timed Activation PM", "_customEvent_" + "ToggleActive");
}, actor);
}

            else
{
                actor.say("Timed Activation PM", "_customEvent_" + "ToggleActive");
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}