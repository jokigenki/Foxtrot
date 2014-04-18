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



class Design_28_28_WallJumpingPM extends ActorScript
{          	
	
public var _CollidingLeft:Bool;

public var _CollidingRight:Bool;

public var _CollidedLeft:Bool;

public var _CollidedRight:Bool;

public var _KeyReleased:Bool;

public var _Jumped:Bool;

public var _CanJump:Bool;

public var _ElapsedTime:Float;

public var _JumpRightAngle:Float;

public var _JumpLeftAngle:Float;

public var _JumpForce:Float;

public var _WallJumpRightAnimation:String;

public var _WallJumpLeftAnimation:String;

public var _AnimationCategory:String;

public var _PreventWallJump:Bool;
    

/* Params are:__Self __Prevent */
public function _customBlock_PreventWallJump(__Prevent:Bool):Void
{
var __Self:Actor = actor;
        _PreventWallJump = __Prevent;
propertyChanged("_PreventWallJump", _PreventWallJump);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Colliding Left?", "_CollidingLeft");
_CollidingLeft = false;
nameMap.set("Colliding Right?", "_CollidingRight");
_CollidingRight = false;
nameMap.set("Collided Left?", "_CollidedLeft");
_CollidedLeft = false;
nameMap.set("Collided Right?", "_CollidedRight");
_CollidedRight = false;
nameMap.set("Key Released?", "_KeyReleased");
_KeyReleased = true;
nameMap.set("Jumped?", "_Jumped");
_Jumped = false;
nameMap.set("Can Jump?", "_CanJump");
_CanJump = false;
nameMap.set("Elapsed Time", "_ElapsedTime");
_ElapsedTime = 0.0;
nameMap.set("Jump Right Angle", "_JumpRightAngle");
_JumpRightAngle = 290.0;
nameMap.set("Jump Left Angle", "_JumpLeftAngle");
_JumpLeftAngle = 250.0;
nameMap.set("Jump Force", "_JumpForce");
_JumpForce = 65.0;
nameMap.set("Wall Jump Right Animation", "_WallJumpRightAnimation");
nameMap.set("Wall Jump Left Animation", "_WallJumpLeftAnimation");
nameMap.set("Actor", "actor");
nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Wall Jumping";
nameMap.set("Prevent Wall Jump", "_PreventWallJump");
_PreventWallJump = false;

	}
	
	override public function init()
	{
		            /* "Inputs: ----------------------" */
        /* "\"On Ground?\" -- <Boolean> Actor Level Attribute, from \"On Ground\" Behavior (required)" */
        /* "\"Facing Right?\" -- <Boolean> Actor Level Attribute, from \"PM Walking\" Behavior (required)" */
        /* "Outputs: ---------------------" */
        /* "\"Is Wall Jumping?\" -- <Boolean> Actor Level Attribute" */
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_PreventWallJump)
{
            return;
}

        _CollidedLeft = _CollidingLeft;
propertyChanged("_CollidedLeft", _CollidedLeft);
        _CollidedRight = _CollidingRight;
propertyChanged("_CollidedRight", _CollidedRight);
        _CollidingLeft = false;
propertyChanged("_CollidingLeft", _CollidingLeft);
        _CollidingRight = false;
propertyChanged("_CollidingRight", _CollidingRight);
        if(asBoolean(actor.getActorValue("On Ground?")))
{
            actor.setActorValue("Is Wall Jumping?", false);
            actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
            _KeyReleased = false;
propertyChanged("_KeyReleased", _KeyReleased);
            _Jumped = false;
propertyChanged("_Jumped", _Jumped);
            return;
}

        /* "Custom: \"Jump\" was switched on for Self" */
        if(cast((actor.say("Control Adapter PM", "_customBlock_ControlSwitchedOn", ["Jump"])), Bool))
{
            if(asBoolean(actor.getActorValue("On Ground?")))
{
                _KeyReleased = false;
propertyChanged("_KeyReleased", _KeyReleased);
                if((!(_CollidedLeft) && !(_CollidedRight)))
{
                    runLater(1000 * 0.15, function(timeTask:TimedTask):Void {
                                if((!(_CollidedLeft) && !(_CollidedRight)))
{
                                    _KeyReleased = false;
propertyChanged("_KeyReleased", _KeyReleased);
}

}, actor);
}

}

}

        if(_KeyReleased)
{
            _CanJump = true;
propertyChanged("_CanJump", _CanJump);
}

        /* "Custom: Is \"Jump\" on for Self" */
        if((!(_KeyReleased) && !(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Jump"])), Bool))))
{
            if(!(asBoolean(actor.getActorValue("On Ground?"))))
{
                _KeyReleased = true;
propertyChanged("_KeyReleased", _KeyReleased);
}

}

        /* "Custom: Is \"Jump\" on for Self" */
        if((cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Jump"])), Bool) && ((_CanJump && _KeyReleased) && !(asBoolean(actor.getActorValue("On Ground?"))))))
{
            _KeyReleased = false;
propertyChanged("_KeyReleased", _KeyReleased);
            _Jumped = false;
propertyChanged("_Jumped", _Jumped);
            if(_CollidedLeft)
{
                _Jumped = true;
propertyChanged("_Jumped", _Jumped);
                _ElapsedTime = asNumber(0);
propertyChanged("_ElapsedTime", _ElapsedTime);
                _CanJump = false;
propertyChanged("_CanJump", _CanJump);
                actor.setYVelocity(0);
                actor.applyImpulseInDirection(_JumpRightAngle, _JumpForce);
                actor.setActorValue("Facing Right?", true);
                
                actor.say("Air Jumping PM", "_customBlock_PreventAirJump", [true]);
                actor.say("Wall Sliding PM", "_customBlock_PreventWallSlide", [true]);
}

            if(_CollidedRight)
{
                _Jumped = true;
propertyChanged("_Jumped", _Jumped);
                _ElapsedTime = asNumber(0);
propertyChanged("_ElapsedTime", _ElapsedTime);
                _CanJump = false;
propertyChanged("_CanJump", _CanJump);
                actor.setYVelocity(0);
                actor.applyImpulseInDirection(_JumpLeftAngle, _JumpForce);
                actor.setActorValue("Facing Right?", false);
                
                actor.say("Air Jumping PM", "_customBlock_PreventAirJump", [true]);
                actor.say("Wall Sliding PM", "_customBlock_PreventWallSlide", [true]);
}

}

        if(_Jumped)
{
            _ElapsedTime += 1;
propertyChanged("_ElapsedTime", _ElapsedTime);
            if((_ElapsedTime >= ((.1 * 1000) / getStepSize())))
{
                actor.setActorValue("Is Wall Jumping?", true);
}

            if((_ElapsedTime >= ((.2 * 1000) / getStepSize())))
{
                
                actor.say("Air Jumping PM", "_customBlock_PreventAirJump", [false]);
                actor.say("Wall Sliding PM", "_customBlock_PreventWallSlide", [false]);
}

}

        else
{
            
            actor.say("Air Jumping PM", "_customBlock_PreventAirJump", [false]);
            actor.say("Wall Sliding PM", "_customBlock_PreventWallSlide", [false]);
}

        if(asBoolean(actor.getActorValue("Is Wall Jumping?")))
{
            if(asBoolean(actor.getActorValue("Facing Right?")))
{
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_WallJumpRightAnimation,_AnimationCategory]);
}

            else
{
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_WallJumpLeftAnimation,_AnimationCategory]);
}

}

}
});
    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((event.thisCollidedWithSensor || !(event.thisCollidedWithTile)))
{
            return;
}

        if(event.thisFromLeft)
{
            _CollidingLeft = true;
propertyChanged("_CollidingLeft", _CollidingLeft);
            actor.setActorValue("Is Wall Jumping?", false);
            /* "Custom: Clear Current Anim Category If Same As <Animation Category>" */
            actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
}

        if(event.thisFromRight)
{
            _CollidingRight = true;
propertyChanged("_CollidingRight", _CollidingRight);
            actor.setActorValue("Is Wall Jumping?", false);
            /* "Custom: Clear Current Anim Category If Same As <Animation Category>" */
            actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}