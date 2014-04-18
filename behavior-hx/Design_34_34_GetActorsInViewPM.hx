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



class Design_34_34_GetActorsInViewPM extends ActorScript
{          	
	
public var _ActorsInView:Array<Dynamic>;

public var _TransparentActorTypes:Array<Dynamic>;

public var _SweepAngle:Float;

public var _NumberOfRays:Float;

public var _UpdateEveryNFrames:Float;

public var _RayAngleStart:Float;

public var _RaySpacing:Float;

public var _MaxRange:Float;

public var _FrameCount:Float;
    

/* Params are:__Self */
public function _customBlock_GetViewableActors():Array<Dynamic>
{
var __Self:Actor = actor;
        var allActors:Array<Actor> = new Array<Actor>();
/*
for (index0 in 0...Std.int(_NumberOfRays))
{
	var newActor:Actor = null;
	if (actor.getActorValue("Facing Right?"))
	{
		newActor = cast((actor.say("Get Actors In View", "GetFirstActorOnRay", [(_RayAngleStart + (_RaySpacing * index0)),_MaxRange])), Actor);
	} else {
		newActor = cast((actor.say("Get Actors In View", "GetFirstActorOnRay", [((_RayAngleStart - 180) - (_RaySpacing * index0)),_MaxRange])), Actor);
	}
	if (newActor != null && !Utils.contains(allActors, newActor))
	{
		allActors.push(newActor);
	}
}
*/
return allActors;
}
    

/* Params are:__Self __RayAngle __MaxRange */
public function _customBlock_GetFirstActorOnRay(__RayAngle:Float, __MaxRange:Float):Actor
{
var __Self:Actor = actor;
        /*var rads:Float = __RayAngle * Math.PI / 180;
var x1:Float = actor.getXCenter();
var y1:Float = actor.getYCenter();
var x2:Float = x1 + (Math.cos(rads) * __MaxRange);
var y2:Float = y1 + (Math.sin(rads) * __MaxRange);

var allActors:Array<Actor> = RaycastAPI.rayCastAll(x1,y1,x2,y2);
var viewedActors:Array<Actor> = new Array<Actor>();
for (actor in allActors)
{
	if (!Utils.contains(_TransparentActorTypes, actor.getType()))
	{
		return actor;
	}
}*/
return null;
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actors In View", "_ActorsInView");
_ActorsInView = [];
nameMap.set("Transparent Actor Types", "_TransparentActorTypes");
_TransparentActorTypes = [];
nameMap.set("Sweep Angle", "_SweepAngle");
_SweepAngle = 0.0;
nameMap.set("Number Of Rays", "_NumberOfRays");
_NumberOfRays = 0.0;
nameMap.set("Update Every N Frames", "_UpdateEveryNFrames");
_UpdateEveryNFrames = 0.0;
nameMap.set("Ray Angle Start", "_RayAngleStart");
_RayAngleStart = 0.0;
nameMap.set("Ray Spacing", "_RaySpacing");
_RaySpacing = 0.0;
nameMap.set("Max Range", "_MaxRange");
_MaxRange = 0.0;
nameMap.set("Frame Count", "_FrameCount");
_FrameCount = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if(((_NumberOfRays == 0) || (_SweepAngle == 0)))
{
            _NumberOfRays = asNumber(1);
propertyChanged("_NumberOfRays", _NumberOfRays);
}

        if((_UpdateEveryNFrames == 0))
{
            _UpdateEveryNFrames = asNumber(1);
propertyChanged("_UpdateEveryNFrames", _UpdateEveryNFrames);
}

        _FrameCount = asNumber(1);
propertyChanged("_FrameCount", _FrameCount);
        if((_NumberOfRays > 1))
{
            _RaySpacing = asNumber((_SweepAngle / (_NumberOfRays - 1)));
propertyChanged("_RaySpacing", _RaySpacing);
}

        else
{
            _RaySpacing = asNumber(0);
propertyChanged("_RaySpacing", _RaySpacing);
}

        _RayAngleStart = asNumber(-((_SweepAngle / 2)));
propertyChanged("_RayAngleStart", _RayAngleStart);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _FrameCount += 1;
propertyChanged("_FrameCount", _FrameCount);
        if((_FrameCount == _UpdateEveryNFrames))
{
            _FrameCount = asNumber(0);
propertyChanged("_FrameCount", _FrameCount);
            /* "Custom: Get Viewable Actors for Self" */
            actor.setActorValue("Actors In View", cast((actor.say("Get Actors In View PM", "_customBlock_GetViewableActors")), Array<Dynamic>));
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}