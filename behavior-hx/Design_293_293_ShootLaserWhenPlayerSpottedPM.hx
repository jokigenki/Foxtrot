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



class Design_293_293_ShootLaserWhenPlayerSpottedPM extends ActorScript
{          	
	
public var _TestAfterNFrames:Float;

public var _Degrees:Float;

public var _cos:Float;

public var _sin:Float;

public var _FrameCount:Float;

public var _IncludedActors:Array<Dynamic>;

public var _KeyLineColour:Int;

public var _BeamThickness:Float;

public var _XOffset:Float;

public var _YOffset:Float;

public var _CollisionX:Float;

public var _CollisionY:Float;

public var _UseKeyLine:Bool;

public var _BeamColours:Array<Dynamic>;

public var _FirstCollisionActor:Actor;

public var _HasCollision:Bool;

public var _BeamTargetY:Float;

public var _BeamTargetX:Float;

public var _IsCharged:Bool;

public var _ChargeTime:Float;

public var _FireAnimationLeft:String;

public var _IsCharging:Bool;

public var _IdleAnimationLeft:String;

public var _FireAnimationRight:String;

public var _IdleAnimationRight:String;

public var _ShootSFX:Sound;

public var _HasFired:Bool;

public var _AlarmSFX:Sound;
            public function updateTarget ()
{
	var targetDistance = 500; 
	var rads = _Degrees * Math.PI / 180;
	_cos = Math.cos(rads);
	_sin = Math.sin(rads);
	_BeamTargetX = _cos * targetDistance;
	_BeamTargetY = _sin * targetDistance;
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Test After N Frames", "_TestAfterNFrames");
_TestAfterNFrames = 5.0;
nameMap.set("Degrees", "_Degrees");
_Degrees = 0.0;
nameMap.set("cos", "_cos");
_cos = 0.0;
nameMap.set("sin", "_sin");
_sin = 0.0;
nameMap.set("Frame Count", "_FrameCount");
_FrameCount = 0.0;
nameMap.set("Included Actors", "_IncludedActors");
_IncludedActors = [];
nameMap.set("Key Line Colour", "_KeyLineColour");
_KeyLineColour = Utils.getColorRGB(0,0,0);
nameMap.set("Beam Thickness", "_BeamThickness");
_BeamThickness = 2.0;
nameMap.set("X Offset", "_XOffset");
_XOffset = 0.0;
nameMap.set("Y Offset", "_YOffset");
_YOffset = 0.0;
nameMap.set("Collision X", "_CollisionX");
_CollisionX = 0.0;
nameMap.set("Collision Y", "_CollisionY");
_CollisionY = 0.0;
nameMap.set("Use Key Line?", "_UseKeyLine");
_UseKeyLine = false;
nameMap.set("Beam Colours", "_BeamColours");
_BeamColours = [];
nameMap.set("Actor", "actor");
nameMap.set("First Collision Actor", "_FirstCollisionActor");
nameMap.set("Has Collision?", "_HasCollision");
_HasCollision = false;
nameMap.set("Beam Target Y", "_BeamTargetY");
_BeamTargetY = 0.0;
nameMap.set("Beam Target X", "_BeamTargetX");
_BeamTargetX = 0.0;
nameMap.set("Is Charged?", "_IsCharged");
_IsCharged = false;
nameMap.set("Charge Time", "_ChargeTime");
_ChargeTime = 0.5;
nameMap.set("Fire Animation Left", "_FireAnimationLeft");
nameMap.set("Is Charging?", "_IsCharging");
_IsCharging = false;
nameMap.set("Idle Animation Left", "_IdleAnimationLeft");
nameMap.set("Fire Animation Right", "_FireAnimationRight");
nameMap.set("Idle Animation Right", "_IdleAnimationRight");
nameMap.set("Shoot SFX", "_ShootSFX");
nameMap.set("Has Fired?", "_HasFired");
_HasFired = false;
nameMap.set("Alarm SFX", "_AlarmSFX");

	}
	
	override public function init()
	{
		            updateTarget();
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((asBoolean(actor.getActorValue("Facing Right?")) && !(_Degrees == 0)))
{
            _XOffset = asNumber(30);
propertyChanged("_XOffset", _XOffset);
            _Degrees = asNumber(0);
propertyChanged("_Degrees", _Degrees);
            updateTarget();
}

        else if((!(asBoolean(actor.getActorValue("Facing Right?"))) && !(_Degrees == 180)))
{
            _XOffset = asNumber(2);
propertyChanged("_XOffset", _XOffset);
            _Degrees = asNumber(180);
propertyChanged("_Degrees", _Degrees);
            updateTarget();
}

        if((_FrameCount > _TestAfterNFrames))
{
            var currentDistX = 0.0;
var currentDistY = 0.0;
var currentDist = 1000000.0;

_HasCollision = false;
_FrameCount = 0;
var startX = actor.getX() + _XOffset;
var startY = actor.getY() + _YOffset;
var targetX = startX + _BeamTargetX;
var targetY = startY + _BeamTargetY;
var results:Array<Dynamic> = RaycastAPI.rayCast(startX, startY, targetX, targetY);

_FirstCollisionActor = null;
for (i in 0...results.length)
{
	var item:Array<Dynamic> = results[i];
	var collisionActor:Actor = item[1];
	if (collisionActor.hasBehavior("Transparent PM") == true) continue;
	//TODO: Reflection
	
	_HasCollision = true;
	var distX = actor.getX() - item[2];
	var distY = actor.getY() - item[3];
	var dist = (distX * distX) + (distY * distY);
	if (dist < currentDist)
	{
		currentDist = dist;
		_FirstCollisionActor = collisionActor;
		_CollisionX = item[2] - actor.getX();
		_CollisionY = item[3] - actor.getY();
	}
}

if (_FirstCollisionActor != null)
{
	var actorType = _FirstCollisionActor.getType();
	if (actorType == null || !Utils.contains(_IncludedActors, actorType))
	{
		_HasCollision = false;
		_FirstCollisionActor = null;
		return;
	}

	if (_IsCharged)
	{
		if (_FirstCollisionActor.hasBehavior("Meltable PM") == true)
		{
			_FirstCollisionActor.say("Meltable PM", "_customEvent_Melt");
		}
		else if (_FirstCollisionActor.hasBehavior("Killable By Laser PM") == true)
		{
			_FirstCollisionActor.say("Killable By Laser PM","_customEvent_Killed");
		}
	}
}
}

        else
{
            _FrameCount += 1;
propertyChanged("_FrameCount", _FrameCount);
}

        if(_HasCollision)
{
            if(!(_IsCharging))
{
                sayToScene("Sound Manager PM", "_customBlock_PlaySound", [_AlarmSFX]);
}

            _IsCharging = true;
propertyChanged("_IsCharging", _IsCharging);
            actor.say("Animation Manager", "_customBlock_ClearCat");
            if((actor.getActorValue("Facing Right?") == false))
{
                scripts.Design_27_27_ActorExtrasPM._customBlock_SafeLoopAnimation(actor,_FireAnimationLeft,"Firing");
}

            else
{
                scripts.Design_27_27_ActorExtrasPM._customBlock_SafeLoopAnimation(actor,_FireAnimationRight,"Firing");
}

            runLater(1000 * _ChargeTime, function(timeTask:TimedTask):Void {
                        if((_HasCollision && !(_HasFired)))
{
                            _HasFired = true;
propertyChanged("_HasFired", _HasFired);
                            _IsCharged = true;
propertyChanged("_IsCharged", _IsCharged);
                            actor.say("Walking PM", "_customBlock_PreventWalk", [true]);
                            sayToScene("Sound Manager PM", "_customBlock_PlaySound", [_ShootSFX]);
}

}, actor);
}

        else
{
            _HasFired = false;
propertyChanged("_HasFired", _HasFired);
            actor.say("Walking PM", "_customBlock_PreventWalk", [false]);
            _IsCharged = false;
propertyChanged("_IsCharged", _IsCharged);
            _IsCharging = false;
propertyChanged("_IsCharging", _IsCharging);
            actor.say("Animation Manager", "_customBlock_ClearCat");
            if((actor.getActorValue("Facing Right?") == false))
{
                scripts.Design_27_27_ActorExtrasPM._customBlock_SafeLoopAnimation(actor,_IdleAnimationLeft,"Walking");
}

            else
{
                scripts.Design_27_27_ActorExtrasPM._customBlock_SafeLoopAnimation(actor,_IdleAnimationRight,"Walking");
}

}

}
});
    addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_IsCharged)
{
            if(_UseKeyLine)
{
                g.strokeColor = _KeyLineColour;
                g.strokeSize = Std.int((_BeamThickness + 1));
                g.drawLine(_XOffset, _YOffset, _CollisionX, _CollisionY);
}

            g.strokeColor = cast((scripts.Design_207_207_StencylExtrasPM._customBlock_GetRandomColour(_BeamColours)), Int);
            g.strokeSize = Std.int(_BeamThickness);
            g.drawLine(_XOffset, _YOffset, _CollisionX, _CollisionY);
            for(index0 in 0...Std.int(5))
{
                if((randomFloat() < 0.25))
{
                    g.fillColor = _KeyLineColour;
}

                else
{
                    g.fillColor = cast((scripts.Design_207_207_StencylExtrasPM._customBlock_GetRandomColour(_BeamColours)), Int);
}

                g.fillRect((_CollisionX + randomInt(Math.floor(-3), Math.floor(3))), (_CollisionY + randomInt(Math.floor(-3), Math.floor(3))), 2, 2);
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}