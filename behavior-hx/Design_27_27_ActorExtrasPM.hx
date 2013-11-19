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



class Design_27_27_ActorExtrasPM extends ActorScript
{          	
	
public var _CollectableId:String;
    

/* Params are:__ScaledActor */
public static function _customBlock_GetActorXScale(__ScaledActor:Actor):Float
{
        return __ScaledActor.bodyScale.x;
}
    

/* Params are:__ScaledActor */
public static function _customBlock_GetActorYScale(__ScaledActor:Actor):Float
{
        return __ScaledActor.bodyScale.y;
}
    

/* Params are:__FirstActor __SecondActor */
public static function _customBlock_ActorsOverlapOnX(__FirstActor:Actor, __SecondActor:Actor):Bool
{
        var stage1 = __FirstActor.stage;
var stage2 = __SecondActor.stage;
if (stage1 == null || stage2 == null) return false;
var bounds1 = __FirstActor.getBounds(stage1);
var bounds2 = __SecondActor.getBounds(stage2);

if (bounds1.right < bounds2.left) return false;
if (bounds1.left > bounds2.right) return false;

return true;
}
    

/* Params are:__FirstActor __SecondActor */
public static function _customBlock_ActorsOvelapOnY(__FirstActor:Actor, __SecondActor:Actor):Bool
{
        var stage1 = __FirstActor.stage;
var stage2 = __SecondActor.stage;
if (stage1 == null || stage2 == null) return false;
var bounds1 = __FirstActor.getBounds(stage1);
var bounds2 = __SecondActor.getBounds(stage2);

if (bounds1.bottom < bounds2.top) return false;
if (bounds1.top > bounds2.bottom) return false;

return true;
}
    

/* Params are:__Actor */
public static function _customBlock_GetActorLeft(__Actor:Actor):Float
{
        var aParent = __Actor.parent;
if (aParent == null) return 0;
var bounds1 = __Actor.getBounds(aParent);
return bounds1.left /  Engine.SCALE;
}
    

/* Params are:__Actor */
public static function _customBlock_GetActorRight(__Actor:Actor):Float
{
        var aParent = __Actor.parent;
if (aParent == null) return 0;
var bounds1 = __Actor.getBounds(aParent);
return bounds1.right /  Engine.SCALE;
}
    

/* Params are:__Actor */
public static function _customBlock_GetActorTop(__Actor:Actor):Float
{
        var aParent = __Actor.parent;
if (aParent == null) return 0;
var bounds1 = __Actor.getBounds(aParent);
return bounds1.top / Engine.SCALE;
}
    

/* Params are:__Actor */
public static function _customBlock_GetActorBottom(__Actor:Actor):Float
{
        var aParent = __Actor.parent;
if (aParent == null) return 0;
var bounds1 = __Actor.getBounds(aParent);
return bounds1.bottom / Engine.SCALE;
}
    

/* Params are:__Actor */
public static function _customBlock_ActorIsNull(__Actor:Actor):Bool
{
        return __Actor == null;
}
    

/* Params are:__FirstActor __SecondActor */
public static function _customBlock_CalculateDistance(__FirstActor:Actor, __SecondActor:Actor):Float
{
        var xDist = __FirstActor.getXCenter() - __SecondActor.getXCenter();
var yDist = __FirstActor.getYCenter() - __SecondActor.getYCenter();
var dist = Math.sqrt((xDist * xDist) + (yDist * yDist));

return dist;
}
    

/* Params are:__x __y __Actor */
public static function _customBlock_PointInActorBounds(__x:Float, __y:Float, __Actor:Actor):Bool
{
        var aParent = __Actor.parent;
if (aParent == null) return false;
var bounds1 = __Actor.getBounds(aParent);
var screenX = __Actor.getScreenX();
var screenY = __Actor.getScreenY();
return __x >= bounds1.left - screenX &&
	__x <= bounds1.right - screenX && 
	__y >=bounds1.top - screenY &&
	__y <= bounds1.bottom - screenY;
}
    

/* Params are:__Self __animattribute */
public static function _customBlock_SafeSwitchAnimation(__Self:Actor, __animattribute:String):Void
{
        if((__Self.getAnimation() == __animattribute))
{
            return;
}

        __Self.setAnimation("" + __animattribute);
}
    

/* Params are:__Self __animattribute __text */
public static function _customBlock_SafeLoopAnimation(__Self:Actor, __animattribute:String, __text:String):Void
{
        if((__Self.getAnimation() == __animattribute))
{
            return;
}

        if(__Self.hasBehavior("Animation Manager"))
{
            __Self.say("Animation Manager", "_customBlock_LoopAnim", [__animattribute,__text]);
}

        else
{
            __Self.setAnimation("" + __animattribute);
}

}
    

/* Params are:__Self __animattribute */
public static function _customBlock_SafePlayAnimationOnce(__Self:Actor, __animattribute:String):Void
{
        if((__Self.getAnimation() == __animattribute))
{
            return;
}

        __Self.say("Animation Manager", "_customBlock_PlayOnce", [__animattribute]);
}
    

/* Params are:__Values __Actor */
public static function _customBlock_SetActorValues(__Values:Array<Dynamic>, __Actor:Actor):Void
{
        for (item in cast(__Values, Array<Dynamic>))
{
	var attributes;
	var str = "" + item;
	if (str.indexOf(":") == -1)
	{
		attributes = str.split("=");
		scripts.Design_27_27_ActorExtrasPM._customBlock_SetValue(attributes[0],attributes[1],__Actor,null);
	} else {
		var behaviourValues = str.split(":");
		var behaviour = behaviourValues[0];
		attributes = behaviourValues[1].split("=");
		scripts.Design_27_27_ActorExtrasPM._customBlock_SetValue(attributes[0],attributes[1],__Actor,behaviour);
	}
}
}
    

/* Params are:__Key __Value __Actor __BehaviourName */
public static function _customBlock_SetValue(__Key:String, __Value:String, __Actor:Actor, __BehaviourName:String):Void
{
        switch (__Value)
{
	case "true":
		if (__BehaviourName == null) __Actor.setActorValue(__Key, true);
		else __Actor.setValue(__BehaviourName, __Key, true);
	case "false":
		if (__BehaviourName == null) __Actor.setActorValue(__Key, false);
		else __Actor.setValue(__BehaviourName, __Key, false);
	default:
		var fValue = Std.parseFloat(__Value);
		if (Std.string(fValue) == __Value)
		{
			if (__BehaviourName == null) __Actor.setActorValue(__Key, fValue);
			else __Actor.setValue(__BehaviourName, __Key, fValue);
		}
		else 
		{
			if (__BehaviourName == null) __Actor.setActorValue(__Key, __Value);
			else __Actor.setValue(__BehaviourName, __Key, __Value);
		}
}
}
    

/* Params are:__Actor */
public static function _customBlock_GetActorID(__Actor:Actor):Float
{
        return __Actor.ID;
}
    

/* Params are:__Actor */
public static function _customBlock_NameForActor(__Actor:Actor):String
{
        return __Actor.name;
}
    

/* Params are:__Actor */
public static function _customBlock_SceneNameForActor(__Actor:Actor):String
{
        return __Actor.name + " "  + __Actor.ID;
}
    

/* Params are:__Name */
public static function _customBlock_GetActorInScene(__Name:String):Actor
{
        var allActors = Engine.engine.allActors;
for (actorOnScreen in allActors)
{
	if (actorOnScreen != null && !actorOnScreen.dead && !actorOnScreen.recycled)
	{
		if (actorOnScreen.name + " " + actorOnScreen.ID == __Name)
		{
			return actorOnScreen;
		}
	}
}
return null;
}
    

/* Params are:__Actor __AttributeName */
public static function _customBlock_HasAttribute(__Actor:Actor, __AttributeName:String):Bool
{
        var value = __Actor.getActorValue(__AttributeName);
return value != null;
}
    

/* Params are:__Actor __AttributeName __BehaviourName */
public static function _customBlock_ActorBehaviourHasAttribute(__Actor:Actor, __AttributeName:String, __BehaviourName:String):Bool
{
        var script = __Actor.behaviors.cache.get(__BehaviourName).script;
return Reflect.hasField(script, __AttributeName);
}
    

/* Params are:__Actor __KillBehaviour __KillX __KillY */
public static function _customBlock_TriggerKilledInActor(__Actor:Actor, __KillBehaviour:String, __KillX:Float, __KillY:Float):Void
{
        if(__Actor.hasBehavior(__KillBehaviour))
{
            if(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorBehaviourHasAttribute(__Actor,"_KillX",__KillBehaviour)), Bool))
{
                __Actor.setValue(__KillBehaviour, "_KillX", __KillX);
}

            if(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorBehaviourHasAttribute(__Actor,"_KillX",__KillBehaviour)), Bool))
{
                __Actor.setValue(__KillBehaviour, "_KillY", __KillY);
}

            __Actor.say(__KillBehaviour, "_customEvent_" + "Killed");
}

        else if(__Actor.hasBehavior("Default Kill Behaviour PM"))
{
            scripts.Design_27_27_ActorExtrasPM._customBlock_TriggerKilledInActor(__Actor,"Default Kill Behaviour PM",__KillX,__KillY);
}

        else
{
            Engine.engine.recycleActor(__Actor);
}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Collectable Id", "_CollectableId");
_CollectableId = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}