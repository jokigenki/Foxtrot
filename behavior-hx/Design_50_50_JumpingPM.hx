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



class Design_50_50_JumpingPM extends ActorScript
{          	
	
public var _KeyReleased:Bool;

public var _CanJump:Bool;

public var _MaxJumpTime:Float;

public var _JumpRightAnimation:String;

public var _JumpLeftAnimation:String;

public var _PreventJumping:Bool;

public var _ElapsedJumpTime:Float;

public var _oldY:Float;

public var _CurrentJumpTime:Float;

public var _JumpSound:Sound;

public var _JumpingSlowdown:Float;

public var _AnimationCategory:String;

public var _JumpForce:Float;

public var _AllowSwipeJumping:Bool;

public var _MobileJumpForce:Float;

public var _SwipeJumpForce:Float;
    

/* Params are:__Self __Value */
public function _customBlock_SetPreventJump(__Value:Bool):Void
{
var __Self:Actor = actor;
        __Self.setValue("Jumping PM", "_PreventJumping", __Value);
}
    

/* Params are:__Self */
public function _customBlock_GetPreventJumping():Bool
{
var __Self:Actor = actor;
        return !(__Self.getValue("Jumping PM", "_PreventJumping"));
}
    

/* Params are: */
public function _customBlock_CheckForKeyJump():Void
{
var __Self:Actor = actor;
        /* "Check for the jump key press, but also allow a bit of leeway for smoother jumping" */
        /* "Custom: \"Jump\" was switched on for Self" */
        if(cast((actor.say("Control Adapter PM", "_customBlock_ControlSwitchedOn", ["Jump"])), Bool))
{
            if(!(asBoolean(actor.getActorValue("On Ground?"))))
{
                runLater(1000 * 0.15, function(timeTask:TimedTask):Void {
                            if(actor.isAlive())
{
                                if(!(asBoolean(actor.getActorValue("On Ground?"))))
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
            if((asBoolean(actor.getActorValue("Is Jumping?")) && (actor.getY() < _oldY)))
{
                actor.setYVelocity((actor.getYVelocity() * _JumpingSlowdown));
}

}

        /* "Detect the jump key press, and initiate the jump" */
        /* "Custom: Is \"Jump\" on for Self" */
        if((cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Jump"])), Bool) && (_CanJump && _KeyReleased)))
{
            sayToScene("Sound Manager PM", "_customBlock_PlaySound", [_JumpSound]);
            _ElapsedJumpTime = asNumber(0);
propertyChanged("_ElapsedJumpTime", _ElapsedJumpTime);
            if(#if mobile true #else false #end)
{
                actor.setYVelocity(-(_MobileJumpForce));
}

            else
{
                actor.setYVelocity(-(_JumpForce));
}

            _CanJump = false;
propertyChanged("_CanJump", _CanJump);
            _KeyReleased = false;
propertyChanged("_KeyReleased", _KeyReleased);
            /* "Add a small delay before setting the jumping flag, since another collision can occur before the Actor" */
            /* "gets off the ground, and this would just reset the flag to FALSE." */
            runLater(1000 * 0.075, function(timeTask:TimedTask):Void {
                        if(actor.isAlive())
{
                            actor.setActorValue("Is Jumping?", true);
}

}, actor);
            return;
}

        /* "If we are currently jumping, set the jumping animation" */
        if(asBoolean(actor.getActorValue("Is Jumping?")))
{
            _ElapsedJumpTime += 1;
propertyChanged("_ElapsedJumpTime", _ElapsedJumpTime);
            if(asBoolean(actor.getActorValue("Facing Right?")))
{
                if((actor.getY() < _oldY))
{
                    /* "Custom: Loop <Jump Right Animation> for Self Using <Animation Category>" */
                    actor.say("Animation Manager", "_customBlock_LoopAnim", [_JumpRightAnimation,_AnimationCategory]);
}

}

            else
{
                if((actor.getY() < _oldY))
{
                    /* "Custom: Loop <Jump Left Animation> for Self Using <Animation Category>" */
                    actor.say("Animation Manager", "_customBlock_LoopAnim", [_JumpLeftAnimation,_AnimationCategory]);
}

}

            /* "Check to see if the amount of time we've been jumping for has exceeded the max jumping time" */
            /* "if not, keep setting the jump velocity" */
            if((_ElapsedJumpTime <= ((_MaxJumpTime * 1000) / getStepSize())))
{
                /* "Custom: Is \"Jump\" on for Self" */
                if((cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Jump"])), Bool) && (!(_KeyReleased) && (actor.getY() < _oldY))))
{
                    if(#if mobile true #else false #end)
{
                        actor.setYVelocity(-(_MobileJumpForce));
}

                    else
{
                        actor.setYVelocity(-(_JumpForce));
}

}

}

}

        _oldY = asNumber(actor.getY());
propertyChanged("_oldY", _oldY);
}
    

/* Params are: */
public function _customBlock_CheckForSwipeJump():Bool
{
var __Self:Actor = actor;
        if((!(_CanJump) || !(asBoolean(actor.getActorValue("Swipe Jump")))))
{
            actor.setActorValue("Swipe Jump", false);
            return false;
}

        actor.setActorValue("Swipe Jump", false);
        actor.applyImpulseInDirection(Utils.DEG * (actor.getActorValue("Swipe Jump Direction")), _SwipeJumpForce);
        return true;
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Key Released?", "_KeyReleased");
_KeyReleased = true;
nameMap.set("Can Jump?", "_CanJump");
_CanJump = false;
nameMap.set("Max Jump Time", "_MaxJumpTime");
_MaxJumpTime = 0.075;
nameMap.set("Jump Right Animation", "_JumpRightAnimation");
nameMap.set("Jump Left Animation", "_JumpLeftAnimation");
nameMap.set("Prevent Jumping?", "_PreventJumping");
_PreventJumping = false;
nameMap.set("Elapsed Jump Time", "_ElapsedJumpTime");
_ElapsedJumpTime = 0.0;
nameMap.set("Actor", "actor");
nameMap.set("oldY", "_oldY");
_oldY = 0.0;
nameMap.set("Current Jump Time", "_CurrentJumpTime");
_CurrentJumpTime = 0.0;
nameMap.set("Jump Sound", "_JumpSound");
nameMap.set("Jumping Slowdown", "_JumpingSlowdown");
_JumpingSlowdown = 0.75;
nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Jumping";
nameMap.set("Jump Force", "_JumpForce");
_JumpForce = 35.0;
nameMap.set("Allow Swipe Jumping?", "_AllowSwipeJumping");
_AllowSwipeJumping = true;
nameMap.set("Mobile Jump Force", "_MobileJumpForce");
_MobileJumpForce = 35.0;
nameMap.set("Swipe Jump Force", "_SwipeJumpForce");
_SwipeJumpForce = 50.0;

	}
	
	override public function init()
	{
		            /* "Inputs: ----------------------" */
        /* "\"On Ground?\" -- <Boolean> Actor Level Attribute, from \"On Ground\" Behavior (required)" */
        /* "\"Facing Right?\" -- <Boolean> Actor Level Attribute, from \"Walking\" Behavior (required)" */
        /* "Outputs: ---------------------" */
        /* "\"Is Jumping?\" -- <Boolean> Actor Level Attribute" */
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_PreventJumping)
{
            return;
}

        /* "If we're on the ground, we're not jumping" */
        _CanJump = false;
propertyChanged("_CanJump", _CanJump);
        if(asBoolean(actor.getActorValue("On Ground?")))
{
            actor.setActorValue("Is Jumping?", false);
            /* "Custom: Clear Current Anim Category If Same As <Animation Category>" */
            actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
            if(_KeyReleased)
{
                _CanJump = true;
propertyChanged("_CanJump", _CanJump);
}

}

        if(_AllowSwipeJumping)
{
            if(!(cast((actor.say("Jumping PM", "_customBlock_CheckForSwipeJump")), Bool)))
{
                actor.say("Jumping PM", "_customBlock_CheckForKeyJump");
}

}

        else
{
            actor.say("Jumping PM", "_customBlock_CheckForKeyJump");
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}