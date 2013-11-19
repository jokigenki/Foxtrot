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



class Design_49_49_RunningPM extends ActorScript
{          	
	
public var _PreventRunning:Bool;

public var _KeyReleased:Bool;

public var _OldAccel:Float;

public var _OldMaxSpeed:Float;

public var _AtFullSpeed:Bool;

public var _ElapsedTime:Float;

public var _Acceleration:Float;

public var _MidRunSpeed:Float;

public var _MaxRunSpeed:Float;

public var _RightKey:String;

public var _LeftKey:String;

public var _TimeToMaxSpeed:Float;

public var _CanSlide:Bool;

public var _RunRightAnimation:String;

public var _SlipRightAnimation:String;

public var _RunLeftAnimation:String;

public var _FullRunRightAnimation:String;

public var _SlipLeftAnimation:String;

public var _AnimationCategory:String;

public var _FullRunLeftAnimation:String;
    public function _customEvent_SetAnimation():Void
{
        if(((!(isKeyDown(_RightKey)) && !(isKeyDown(_LeftKey))) || !(asBoolean(actor.getActorValue("On Ground?")))))
{
            return;
}

        if(asBoolean(actor.getActorValue("Facing Right?")))
{
            if((isKeyDown(_RightKey) && ((actor.getXVelocity() <= -1) && _CanSlide)))
{
                /* "Custom: Loop <Slip Right Animation> for Self Using \"Running\"" */
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_SlipRightAnimation,"Running"]);
                return;
}

            if(_AtFullSpeed)
{
                /* "Custom: Loop <Full Run Right Animation> for Self Using \"Running\"" */
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_FullRunRightAnimation,"Running"]);
}

            else
{
                /* "Custom: Loop <Run Right Animation> for Self Using \"Running\"" */
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_RunRightAnimation,"Running"]);
}

}

        else
{
            if((isKeyDown(_LeftKey) && ((actor.getXVelocity() >= 1) && _CanSlide)))
{
                /* "Custom: Loop <Slip Left Animation> for Self Using \"Running\"" */
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_SlipLeftAnimation,"Running"]);
                return;
}

            if(_AtFullSpeed)
{
                /* "Custom: Loop <Full Run Left Animation> for Self Using \"Running\"" */
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_FullRunLeftAnimation,"Running"]);
}

            else
{
                /* "Custom: Loop <Run Left Animation> for Self Using \"Running\"" */
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_RunLeftAnimation,"Running"]);
}

}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Prevent Running?", "_PreventRunning");
_PreventRunning = false;
nameMap.set("Key Released?", "_KeyReleased");
_KeyReleased = true;
nameMap.set("Old Accel", "_OldAccel");
_OldAccel = 0.0;
nameMap.set("Old Max Speed", "_OldMaxSpeed");
_OldMaxSpeed = 0.0;
nameMap.set("At Full Speed?", "_AtFullSpeed");
_AtFullSpeed = false;
nameMap.set("Elapsed Time", "_ElapsedTime");
_ElapsedTime = 0.0;
nameMap.set("Acceleration", "_Acceleration");
_Acceleration = 100.0;
nameMap.set("Mid Run Speed", "_MidRunSpeed");
_MidRunSpeed = 25.0;
nameMap.set("Max Run Speed", "_MaxRunSpeed");
_MaxRunSpeed = 35.0;
nameMap.set("Right Key", "_RightKey");
nameMap.set("Left Key", "_LeftKey");
nameMap.set("Time To Max Speed", "_TimeToMaxSpeed");
_TimeToMaxSpeed = 0.4;
nameMap.set("Can Slide?", "_CanSlide");
_CanSlide = true;
nameMap.set("Run Right Animation", "_RunRightAnimation");
nameMap.set("Actor", "actor");
nameMap.set("Slip Right Animation", "_SlipRightAnimation");
nameMap.set("Run Left Animation", "_RunLeftAnimation");
nameMap.set("Full Run Right Animation", "_FullRunRightAnimation");
nameMap.set("Slip Left Animation", "_SlipLeftAnimation");
nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Running";
nameMap.set("Full Run Left Animation", "_FullRunLeftAnimation");

	}
	
	override public function init()
	{
		            /* **Note** - This Behavior requires the "Walking" Behavior to function properly.  */
        /* "Inputs: ----------------------" */
        /* "\"Facing Right?\" -- <Boolean> Actor Level Attribute, from \"Walking\" Behavior (required)" */
        /* "Outputs: ---------------------" */
        /* "\"Is Running?\" -- <Boolean> Actor Level Attribute" */
        _KeyReleased = true;
propertyChanged("_KeyReleased", _KeyReleased);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_PreventRunning)
{
            return;
}

        /* "Custom: Is \"Run\" on for Self" */
        if(((cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Run"])), Bool) && _KeyReleased) && asBoolean(actor.getActorValue("On Ground?"))))
{
            actor.setActorValue("Is Running?", true);
            _KeyReleased = false;
propertyChanged("_KeyReleased", _KeyReleased);
            /* "Custom: Get Walk Accel for Self" */
            _OldAccel = asNumber(cast((actor.say("Walking PM", "_customBlock_GetWalkAccel")), Float));
propertyChanged("_OldAccel", _OldAccel);
            /* "Custom: Get Max Walk Speed for Self" */
            _OldMaxSpeed = asNumber(cast((actor.say("Walking PM", "_customBlock_GetMaxWalkSpeed")), Float));
propertyChanged("_OldMaxSpeed", _OldMaxSpeed);
            /* "Custom: For Self Set Walk Accel to <Acceleration>, For Self Set Max Walk Speed to <Mid Run Speed>" */
            
            
            return;
}

        /* "Custom: Is \"Run\" on for Self" */
        if((!(_KeyReleased) && !(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Run"])), Bool))))
{
            actor.setActorValue("Is Running?", false);
            /* "Custom: Clear Current Anim Category If Same As <Animation Category>" */
            actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
            _AtFullSpeed = false;
propertyChanged("_AtFullSpeed", _AtFullSpeed);
            _KeyReleased = true;
propertyChanged("_KeyReleased", _KeyReleased);
            _ElapsedTime = asNumber(0);
propertyChanged("_ElapsedTime", _ElapsedTime);
            /* "Custom: For Self Set Walk Accel to <Old Accel>, For Self Set Max Walk Speed To <Old Max Speed>" */
            
            
}

        /* "Custom: Is \"Right\" on for Self, Is \"Left\" on for Self" */
        if((!(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Right"])), Bool)) && !(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Left"])), Bool))))
{
            actor.setActorValue("Is Running?", false);
            /* "Custom: Clear Current Anim Category If Same As <Animation Category>" */
            actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
            _AtFullSpeed = false;
propertyChanged("_AtFullSpeed", _AtFullSpeed);
            return;
}

        /* "Custom: Is \"Run\" on for Self, Is \"Left\" on for Self, Is \"Right\" on for Self" */
        if((cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Run"])), Bool) && (cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Left"])), Bool) || cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Right"])), Bool))))
{
            actor.setActorValue("Is Running?", true);
}

        if(asBoolean(actor.getActorValue("Is Running?")))
{
            _customEvent_SetAnimation();
            if((Math.abs(actor.getXVelocity()) < _MaxRunSpeed))
{
                _AtFullSpeed = false;
propertyChanged("_AtFullSpeed", _AtFullSpeed);
}

            if((Math.abs(actor.getXVelocity()) < _MidRunSpeed))
{
                return;
}

            _ElapsedTime += 1;
propertyChanged("_ElapsedTime", _ElapsedTime);
            if(((_ElapsedTime >= ((_TimeToMaxSpeed * 1000) / getStepSize())) && !(_AtFullSpeed)))
{
                _AtFullSpeed = true;
propertyChanged("_AtFullSpeed", _AtFullSpeed);
                /* "Custom: For Self Set Max Walk Speed to <Max Run Speed>" */
                
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}