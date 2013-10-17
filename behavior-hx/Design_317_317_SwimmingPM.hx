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



class Design_317_317_SwimmingPM extends ActorScript
{          	
	
public var _AnimationCategory:String;

public var _KeyReleased:Bool;

public var _PreventSwimming:Bool;

public var _CanSwim:Bool;

public var _SwimSound:Sound;

public var _SwimRightAnimation:String;

public var _SwimLeftAnimation:String;

public var _SwimForce:Float;

public var _MobileSwimForce:Float;

public var _ElapsedSwimTime:Float;

public var _SwimmingSlowdown:Float;

public var _MaxSwimTime:Float;
    

/* Params are:__Self */
public function _customBlock_CanSwim():Bool
{
var __Self:Actor = actor;
        return !(actor.getValue("Swimming PM", "_PreventSwimming"));
}
    

/* Params are:__Self __Value */
public function _customBlock_SetPreventSwim(__Value:Bool):Void
{
var __Self:Actor = actor;
        __Self.setValue("Swimming PM", "_PreventSwimming", __Value);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Swimming";
nameMap.set("Key Released?", "_KeyReleased");
_KeyReleased = false;
nameMap.set("Prevent Swimming?", "_PreventSwimming");
_PreventSwimming = false;
nameMap.set("Can Swim?", "_CanSwim");
_CanSwim = false;
nameMap.set("Swim Sound", "_SwimSound");
nameMap.set("Actor", "actor");
nameMap.set("Swim Right Animation", "_SwimRightAnimation");
nameMap.set("Swim Left Animation", "_SwimLeftAnimation");
nameMap.set("Swim Force", "_SwimForce");
_SwimForce = 35.0;
nameMap.set("Mobile Swim Force", "_MobileSwimForce");
_MobileSwimForce = 35.0;
nameMap.set("Elapsed Swim Time", "_ElapsedSwimTime");
_ElapsedSwimTime = 0.0;
nameMap.set("Swimming Slowdown", "_SwimmingSlowdown");
_SwimmingSlowdown = 0.75;
nameMap.set("Max Swim Time", "_MaxSwimTime");
_MaxSwimTime = 0.075;

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((_PreventSwimming || asBoolean(actor.getActorValue("On Ground?"))))
{
            return;
}

        if(asBoolean(actor.getActorValue("In Liquid?")))
{
            actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
            if(asBoolean(actor.getActorValue("Facing Right?")))
{
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_SwimRightAnimation,_AnimationCategory]);
}

            else
{
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_SwimLeftAnimation,_AnimationCategory]);
}

            actor.setValue("Falling PM", "_PreventFalling", true);
            if(_KeyReleased)
{
                _CanSwim = true;
propertyChanged("_CanSwim", _CanSwim);
}

}

        else
{
            actor.setValue("Falling PM", "_PreventFalling", false);
}

        /* "Check for the jump key press, but also allow a bit of leeway for smoother jumping" */
        /* "Custom: \"Jump\" was switched on for Self" */
        if(cast((actor.say("Control Adapter PM", "_customBlock_ControlSwitchedOn", ["Jump"])), Bool))
{
            if(!(asBoolean(actor.getActorValue("In Liquid?"))))
{
                runLater(1000 * 0.15, function(timeTask:TimedTask):Void {
                            if(actor.isAlive())
{
                                if(!(asBoolean(actor.getActorValue("In Liquid?"))))
{
                                    _KeyReleased = false;
propertyChanged("_KeyReleased", _KeyReleased);
}

}

}, actor);
}

}

        /* "Detect the release of the jump key" */
        /* "Custom: Is \"Jump\" on for Self" */
        if((!(_KeyReleased) && !(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Jump"])), Bool))))
{
            _KeyReleased = true;
propertyChanged("_KeyReleased", _KeyReleased);
            /* "If we're still in the middle of jumping, slow down our upward ascent" */
            if(asBoolean(actor.getActorValue("Is Swimming?")))
{
                actor.setYVelocity((actor.getYVelocity() * _SwimmingSlowdown));
}

}

        /* "Detect the jump key press, and initiate the jump" */
        /* "Custom: Is \"Jump\" on for Self" */
        if((cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Jump"])), Bool) && (_CanSwim && (_KeyReleased && asBoolean(actor.getActorValue("In Liquid?"))))))
{
            playSound(_SwimSound);
            _ElapsedSwimTime = asNumber(0);
propertyChanged("_ElapsedSwimTime", _ElapsedSwimTime);
            if(#if mobile true #else false #end)
{
                actor.setYVelocity(-(_MobileSwimForce));
}

            else
{
                actor.setYVelocity(-(_SwimForce));
}

            _KeyReleased = false;
propertyChanged("_KeyReleased", _KeyReleased);
            /* "Add a small delay before setting the jumping flag, since another collision can occur before the Actor" */
            /* "gets off the ground, and this would just reset the flag to FALSE." */
            runLater(1000 * 0.075, function(timeTask:TimedTask):Void {
                        if(actor.isAlive())
{
                            actor.setActorValue("Is Swimming?", true);
}

}, actor);
            return;
}

        if(asBoolean(actor.getActorValue("Is Swimming?")))
{
            /* "Check to see if the amount of time we've been jumping for has exceeded the max jumping time" */
            /* "if not, keep setting the jump velocity" */
            if((_ElapsedSwimTime <= ((_MaxSwimTime * 1000) / getStepSize())))
{
                /* "Custom: Is \"Jump\" on for Self" */
                if((cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Jump"])), Bool) && !(_KeyReleased)))
{
                    if(#if mobile true #else false #end)
{
                        actor.setYVelocity(-(_MobileSwimForce));
}

                    else
{
                        actor.setYVelocity(-(_SwimForce));
}

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