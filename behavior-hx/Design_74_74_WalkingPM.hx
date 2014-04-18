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
import nme.display.BitmapData;
import nme.display.Bitmap;
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

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_74_74_WalkingPM extends ActorScript
{          	
	
public var _Acceleration:Float;

public var _MaxWalkingSpeed:Float;

public var _LimitSpeed:Bool;

public var _WalkRightAnimation:String;

public var _WalkLeftAnimation:String;

public var _IdleRightAnimation:String;

public var _IdleLeftAnimation:String;

public var _PreventWalking:Bool;

public var _DisableStatuses:Array<Dynamic>;

public var _AnimationCategory:String;

public var _ShouldPlaySound:Bool;

public var _FootstepSFXName:String;

public var _FootstepSFXNumber:Float;

public var _SFXSpacing:Float;
    

/* Params are:__Self */
public function _customBlock_AtMaxWalkingSpeed():Bool
{
var __Self:Actor = actor;
        if((asBoolean(actor.getActorValue("Facing Right?")) && (actor.getXVelocity() >= _MaxWalkingSpeed)))
{
            if(_LimitSpeed)
{
                actor.setXVelocity(_MaxWalkingSpeed);
}

            return true;
}

        if((!(asBoolean(actor.getActorValue("Facing Right?"))) && (actor.getXVelocity() <= -(_MaxWalkingSpeed))))
{
            if(_LimitSpeed)
{
                actor.setXVelocity(-(_MaxWalkingSpeed));
}

            return true;
}

        return false;
}
    

/* Params are:__Self __Accel */
public function _customBlock_WalkAccel(__Accel:Float):Void
{
var __Self:Actor = actor;
        _Acceleration = asNumber(__Accel);
propertyChanged("_Acceleration", _Acceleration);
}
    

/* Params are:__Self */
public function _customBlock_GetWalkAccel():Float
{
var __Self:Actor = actor;
        return _Acceleration;
}
    

/* Params are:__Self __MaxSpeed */
public function _customBlock_MaxWalkSpeed(__MaxSpeed:Float):Void
{
var __Self:Actor = actor;
        _MaxWalkingSpeed = asNumber(__MaxSpeed);
propertyChanged("_MaxWalkingSpeed", _MaxWalkingSpeed);
}
    

/* Params are:__Self */
public function _customBlock_GetMaxWalkSpeed():Float
{
var __Self:Actor = actor;
        return _MaxWalkingSpeed;
}
    

/* Params are:__Self __Prevent */
public function _customBlock_PreventWalk(__Prevent:Bool):Void
{
var __Self:Actor = actor;
        _PreventWalking = __Prevent;
propertyChanged("_PreventWalking", _PreventWalking);
}
    

/* Params are:__Self __Limit */
public function _customBlock_LimitSpeed(__Limit:Bool):Void
{
var __Self:Actor = actor;
        _LimitSpeed = __Limit;
propertyChanged("_LimitSpeed", _LimitSpeed);
}
    

/* Params are:__Self __Rate */
public function _customBlock_SlowToMax(__Rate:Float):Void
{
var __Self:Actor = actor;
        if((Math.abs(__Self.getXVelocity()) > _MaxWalkingSpeed))
{
            actor.setXVelocity((actor.getXVelocity() * __Rate));
}

}
    

/* Params are: */
public function _customBlock_PlayFootsteps():Void
{
var __Self:Actor = actor;
        if(_ShouldPlaySound)
{
            _ShouldPlaySound = false;
propertyChanged("_ShouldPlaySound", _ShouldPlaySound);
            runLater(1000 * _SFXSpacing, function(timeTask:TimedTask):Void {
                        _ShouldPlaySound = true;
propertyChanged("_ShouldPlaySound", _ShouldPlaySound);
}, actor);
            sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_FootstepSFXName,_FootstepSFXNumber]);
}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Acceleration", "_Acceleration");
_Acceleration = 85.0;
nameMap.set("Max Walking Speed", "_MaxWalkingSpeed");
_MaxWalkingSpeed = 20.0;
nameMap.set("Limit Speed?", "_LimitSpeed");
_LimitSpeed = false;
nameMap.set("Walk Right Animation", "_WalkRightAnimation");
nameMap.set("Walk Left Animation", "_WalkLeftAnimation");
nameMap.set("Idle Right Animation", "_IdleRightAnimation");
nameMap.set("Idle Left Animation", "_IdleLeftAnimation");
nameMap.set("Prevent Walking?", "_PreventWalking");
_PreventWalking = false;
nameMap.set("Disable Statuses", "_DisableStatuses");
_DisableStatuses = [];
nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Walking";
nameMap.set("Should Play Sound?", "_ShouldPlaySound");
_ShouldPlaySound = false;
nameMap.set("Footstep SFX Name", "_FootstepSFXName");
_FootstepSFXName = "";
nameMap.set("Actor", "actor");
nameMap.set("Footstep SFX Number", "_FootstepSFXNumber");
_FootstepSFXNumber = 1.0;
nameMap.set("SFX Spacing", "_SFXSpacing");
_SFXSpacing = 0.4;

	}
	
	override public function init()
	{
		            /* "Inputs: ----------------------" */
        /* "\"On Ground?\" -- <Boolean> Actor Level Attribute, from \"On Ground\" Behavior (required)" */
        /* "\"Is Running?\" -- <Boolean> Actor Level Attribute, from \"PM Jumping\" Behavior (NOT required)" */
        /* "\"Is Ducking?\" -- <Boolean> Actor Level Attribute, from \"PM Ducking\" Behavior (NOT required)" */
        /* "\"Is Slope Sliding?\" -- <Boolean> Actor Level Attribute, from \"Slope Detection\" Behavior (NOT required)" */
        /* "Outputs: ---------------------" */
        /* "\"Facing Right?\" -- <Boolean> Actor Level Attribute" */
        actor.setActorValue("Facing Right?", true);
        _ShouldPlaySound = true;
propertyChanged("_ShouldPlaySound", _ShouldPlaySound);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        for(item in cast(_DisableStatuses, Array<Dynamic>))
{
            if(asBoolean(actor.getActorValue(("" + item))))
{
                return;
}

}

        if(_PreventWalking)
{
            return;
}

        /* "Custom: Is \"Right\" on for Self, Is \"Left\" on for Self" */
        if((cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Right"])), Bool) && !(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Left"])), Bool))))
{
            actor.setActorValue("Facing Right?", true);
            if(asBoolean(actor.getActorValue("On Ground?")))
{
                /* "Loop <Walk Right Animation> for Self Using <Animation Category>" */
                scripts.Design_27_27_ActorExtrasPM._customBlock_SafeLoopAnimation(actor,_WalkRightAnimation,_AnimationCategory);
                actor.say("Walking PM", "_customBlock_PlayFootsteps");
}

            /* "Custom: Self At Max Walking Speed" */
            if(cast((actor.say("Walking PM", "_customBlock_AtMaxWalkingSpeed")), Bool))
{
                return;
}

            if(actor.getActorValue("Vertical Jump"))
{
                actor.push(1, 0, (_Acceleration * 1.5));
}

            else
{
                actor.push(1, 0, _Acceleration);
}

}

        /* "Custom: Is \"Left\" on for Self, Is \"Right\" on for Self" */
        if((cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Left"])), Bool) && !(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Right"])), Bool))))
{
            actor.setActorValue("Facing Right?", false);
            if(asBoolean(actor.getActorValue("On Ground?")))
{
                /* "Custom: Loop <Walk Left Animation> for Self Using <Animation Category>" */
                scripts.Design_27_27_ActorExtrasPM._customBlock_SafeLoopAnimation(actor,_WalkLeftAnimation,_AnimationCategory);
                actor.say("Walking PM", "_customBlock_PlayFootsteps");
}

            /* "Custom: Self At Max Walking Speed" */
            if(cast((actor.say("Walking PM", "_customBlock_AtMaxWalkingSpeed")), Bool))
{
                return;
}

            if(actor.getActorValue("Vertical Jump"))
{
                actor.push(-1, 0, (_Acceleration * 1.5));
}

            else
{
                actor.push(-1, 0, _Acceleration);
}

}

        /* "Custom: Is \"Right\" on for Self, Is \"Left\" on for Self" */
        if((!(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Right"])), Bool)) && !(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Left"])), Bool))))
{
            if(asBoolean(actor.getActorValue("On Ground?")))
{
                if(asBoolean(actor.getActorValue("Facing Right?")))
{
                    /* "Loop <Idle Right Animation> for Self Using <Animation Category>" */
                    scripts.Design_27_27_ActorExtrasPM._customBlock_SafeLoopAnimation(actor,_IdleRightAnimation,_AnimationCategory);
}

                else
{
                    /* "Loop <Idle Left Animation> for Self Using <Animation Category>" */
                    scripts.Design_27_27_ActorExtrasPM._customBlock_SafeLoopAnimation(actor,_IdleLeftAnimation,_AnimationCategory);
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