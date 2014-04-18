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



class Design_172_172_KillOnHitWithVelocityPM extends ActorScript
{          	
	
public var _RightHitKillVelocity:Float;

public var _LeftHitKillVelocity:Float;

public var _TopHitKillVelocity:Float;

public var _BottomHitKillVelocity:Float;

public var _KillBehaviour:String;

public var _ImmuneToActorTypes:Array<Dynamic>;
    

/* Params are: __HitSpeed __TestSpeed */
public function _customBlock_ResolveHit(__HitSpeed:Float, __TestSpeed:Float):Void
{
var __Self:Actor = actor;
        if(((__TestSpeed < 0) || (Math.abs(__HitSpeed) < 1)))
{
            return;
}

        if((Math.abs(__HitSpeed) > __TestSpeed))
{
            if(actor.hasBehavior(_KillBehaviour))
{
                actor.say(_KillBehaviour, "_customEvent_" + "Killed");
}

            else if(actor.hasBehavior("Default Kill Behaviour PM"))
{
                actor.say("Default Kill Behaviour PM", "_customEvent_" + "Killed");
}

            else
{
                recycleActor(actor);
                if(actor.isBehaviorEnabled("Reload On Death PM"))
{
                    actor.say("Reload On Death PM", "_customEvent_" + "Reload");
}

}

}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Right Hit Kill Velocity", "_RightHitKillVelocity");
_RightHitKillVelocity = 0.0;
nameMap.set("Left Hit Kill Velocity", "_LeftHitKillVelocity");
_LeftHitKillVelocity = 0.0;
nameMap.set("Top Hit Kill Velocity", "_TopHitKillVelocity");
_TopHitKillVelocity = 0.0;
nameMap.set("Bottom Hit Kill Velocity", "_BottomHitKillVelocity");
_BottomHitKillVelocity = 0.0;
nameMap.set("Kill Behaviour", "_KillBehaviour");
_KillBehaviour = "";
nameMap.set("Immune To Actor Types", "_ImmuneToActorTypes");
_ImmuneToActorTypes = [];
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(Utils.contains(_ImmuneToActorTypes, ("" + event.otherActor.getType())))
{
            return;
}

        if(event.thisFromTop)
{
            actor.say("Kill On Hit With Velocity PM", "_customBlock_ResolveHit", [actor.getYVelocity(),_TopHitKillVelocity]);
}

        else if(event.thisFromBottom)
{
            actor.say("Kill On Hit With Velocity PM", "_customBlock_ResolveHit", [actor.getYVelocity(),_BottomHitKillVelocity]);
}

        else if(event.thisFromLeft)
{
            actor.say("Kill On Hit With Velocity PM", "_customBlock_ResolveHit", [actor.getXVelocity(),_LeftHitKillVelocity]);
}

        else if(event.thisFromRight)
{
            actor.say("Kill On Hit With Velocity PM", "_customBlock_ResolveHit", [actor.getXVelocity(),_RightHitKillVelocity]);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}