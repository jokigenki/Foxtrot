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
            public function updateTarget ()
{
	var rads = _Degrees * Math.PI / 180;
	_cos = Math.cos(rads);
	_sin = Math.sin(rads);
	_BeamTargetX = _cos * 500;
	_BeamTargetY = _sin * 500;
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Test After N Frames", "_TestAfterNFrames");
_TestAfterNFrames = 5;
nameMap.set("Degrees", "_Degrees");
_Degrees = 0;
nameMap.set("cos", "_cos");
_cos = 0;
nameMap.set("sin", "_sin");
_sin = 0;
nameMap.set("Frame Count", "_FrameCount");
_FrameCount = 0;
nameMap.set("Included Actors", "_IncludedActors");
nameMap.set("Key Line Colour", "_KeyLineColour");
_KeyLineColour = Utils.getColorRGB(0,0,0);
nameMap.set("Beam Thickness", "_BeamThickness");
_BeamThickness = 2;
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
_BeamTargetY = 0;
nameMap.set("Beam Target X", "_BeamTargetX");
_BeamTargetX = 0;

	}
	
	override public function init()
	{
		            updateTarget();
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(((actor.getActorValue("Facing Right?") == true) && !(_Degrees == 0)))
{
            _Degrees = asNumber(0);
propertyChanged("_Degrees", _Degrees);
            updateTarget();
}

        else if(((actor.getActorValue("Facing Right?") == false) && !(_Degrees == 180)))
{
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
var preventWalking = false;

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

	preventWalking = true;
	if (_FirstCollisionActor.hasBehavior("Meltable PM") == true)
	{
		_FirstCollisionActor.say("Meltable PM", "_customEvent_Melt");
	}
	else if (_FirstCollisionActor.hasBehavior("Killable By Laser PM") == true)
	{
		_FirstCollisionActor.say("Killable By Laser PM","_customEvent_Killed");
	}
}
            actor.say("Walking PM", "_customBlock_PreventWalk", [preventWalking]);
}

        else
{
            _FrameCount += 1;
propertyChanged("_FrameCount", _FrameCount);
}

}
});
    addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_HasCollision)
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