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



class Design_39_39_EdgeTeeterPM extends ActorScript
{          	
	
public var _HitGround:Bool;

public var _Teeterdistance:Float;

public var _IsTeeteringLeft:Bool;

public var _IsTeeteringRight:Bool;

public var _TeeterLeftAnimation:String;

public var _TeeterRightAnimation:String;

public var _AnimationCategory:String;

public var _HasTeeteredLeft:Bool;

public var _HasTeeteredRight:Bool;

public var _MinimumTeeterSpeed:Float;

public var _RightGroup:Group;

public var _LeftGroup:Group;
    

/* Params are:__Self __groundactor */
public function _customBlock_IsTeeteringLeft(__groundactor:Actor):Bool
{
var __Self:Actor = actor;
        if((_Teeterdistance <= 0))
{
            return false;
}

        if((__Self.getXVelocity() >= -(_MinimumTeeterSpeed)))
{
            return false;
}

        if((__Self.getXCenter() < __groundactor.getX()))
{
            return false;
}

        if((__Self.getXCenter() > (__groundactor.getX() + _Teeterdistance)))
{
            return false;
}

        return true;
}
    

/* Params are:__Self __groundactor */
public function _customBlock_IsTeeteringRight(__groundactor:Actor):Bool
{
var __Self:Actor = actor;
        if((_Teeterdistance <= 0))
{
            return false;
}

        if((actor.getXVelocity() <= _MinimumTeeterSpeed))
{
            return false;
}

        if((actor.getXCenter() > (__groundactor.getX() + (__groundactor.getWidth()))))
{
            return false;
}

        if((actor.getXCenter() < ((__groundactor.getX() + (__groundactor.getWidth())) - _Teeterdistance)))
{
            return false;
}

        return true;
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Hit Ground?", "_HitGround");
_HitGround = false;
nameMap.set("Teeter distance", "_Teeterdistance");
_Teeterdistance = 0.0;
nameMap.set("Is Teetering Left?", "_IsTeeteringLeft");
_IsTeeteringLeft = false;
nameMap.set("Is Teetering Right?", "_IsTeeteringRight");
_IsTeeteringRight = false;
nameMap.set("Teeter Left Animation", "_TeeterLeftAnimation");
nameMap.set("Teeter Right Animation", "_TeeterRightAnimation");
nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Walking";
nameMap.set("Has Teetered Left?", "_HasTeeteredLeft");
_HasTeeteredLeft = false;
nameMap.set("Has Teetered Right?", "_HasTeeteredRight");
_HasTeeteredRight = false;
nameMap.set("Minimum Teeter Speed", "_MinimumTeeterSpeed");
_MinimumTeeterSpeed = 0.0;
nameMap.set("Actor", "actor");
nameMap.set("Right Group", "_RightGroup");
nameMap.set("Left Group", "_LeftGroup");

	}
	
	override public function init()
	{
		            /* "Inputs:" */
        /* "\"On Ground?\" -- <Boolean> Actor Level Attribute, from \"On Ground\" Behavior (required)" */
        /* "Outputs:" */
        /* "\"Has Teetered Left?\" -- <Boolean> Actor Level Attribute" */
        /* "\"Has Teetered Right?\" -- <Boolean> Actor Level Attribute" */
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _HasTeeteredLeft = actor.getActorValue("Has Teetered Left?");
propertyChanged("_HasTeeteredLeft", _HasTeeteredLeft);
        _HasTeeteredRight = actor.getActorValue("Has Teetered Right?");
propertyChanged("_HasTeeteredRight", _HasTeeteredRight);
        if(((_HasTeeteredLeft == false) && _IsTeeteringLeft))
{
            /* "Custom: Play <Teeter Left Animation> Once for Self" */
            actor.say("Animation Manager", "_customBlock_PlayOnce", [_TeeterLeftAnimation]);
            actor.setActorValue("Has Teetered Left?", true);
}

        else if(((_HasTeeteredRight == false) && _IsTeeteringRight))
{
            /* "Custom: Play <Teeter Right Animation> Once for Self" */
            actor.say("Animation Manager", "_customBlock_PlayOnce", [_TeeterRightAnimation]);
            actor.setActorValue("Has Teetered Right?", true);
}

        _IsTeeteringLeft = false;
propertyChanged("_IsTeeteringLeft", _IsTeeteringLeft);
        _IsTeeteringRight = false;
propertyChanged("_IsTeeteringRight", _IsTeeteringRight);
        /* "is the player has moved after the teeter, clear the actor values so it can be set again" */
        if((_HasTeeteredLeft && ((actor.getXVelocity() > 0) || !(actor.getYVelocity() == 0))))
{
            actor.setActorValue("Has Teetered Left?", false);
}

        if((_HasTeeteredRight && ((actor.getXVelocity() < 0) || !(actor.getYVelocity() == 0))))
{
            actor.setActorValue("Has Teetered Right?", false);
}

        /* "prevent the player moving while the animation plays" */
        if(((actor.getAnimation() == _TeeterLeftAnimation) || (actor.getAnimation() == _TeeterRightAnimation)))
{
            actor.setXVelocity(0);
}

}
});
    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((actor.getActorValue("On Ground?") == false))
{
            return;
}

        /* "If the player's y speed is not 0, then don't teeter - they might be jumping, or sliding" */
        if(!(actor.getYVelocity() == 0))
{
            return;
}

        if((event.otherActor.getGroup() == _LeftGroup))
{
            /* "Custom: <this actor> is teetering on left of <other actor>" */
            if(cast((event.thisActor.say("Edge Teeter PM", "_customBlock_IsTeeteringLeft", [event.otherActor])), Bool))
{
                _IsTeeteringLeft = true;
propertyChanged("_IsTeeteringLeft", _IsTeeteringLeft);
}

}

        if((event.otherActor.getGroup() == _RightGroup))
{
            /* "Custom: <this actor> is teetering on right of <other actor>" */
            if(cast((event.thisActor.say("Edge Teeter PM", "_customBlock_IsTeeteringRight", [event.otherActor])), Bool))
{
                _IsTeeteringRight = true;
propertyChanged("_IsTeeteringRight", _IsTeeteringRight);
}

}

        if((_IsTeeteringLeft == _IsTeeteringRight))
{
            _IsTeeteringLeft = false;
propertyChanged("_IsTeeteringLeft", _IsTeeteringLeft);
            _IsTeeteringRight = false;
propertyChanged("_IsTeeteringRight", _IsTeeteringRight);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}