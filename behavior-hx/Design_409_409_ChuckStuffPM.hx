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



class Design_409_409_ChuckStuffPM extends ActorScript
{          	
	
public var _StuffToChuck:Array<Dynamic>;

public var _ActorTypeNameToChuck:String;

public var _ThrowXMin:Float;

public var _ThrowXMax:Float;

public var _ThrowYMin:Float;

public var _ThrowYMax:Float;

public var _ThrowForce:Float;
    public function _customEvent_Deactivated():Void
{
        _ActorTypeNameToChuck = (scripts.Design_207_207_StencylExtrasPM._customBlock_GetRandomItemFromList(_StuffToChuck));
propertyChanged("_ActorTypeNameToChuck", _ActorTypeNameToChuck);
        createRecycledActor(getActorTypeByName("" + _ActorTypeNameToChuck), actor.getXCenter(), actor.getYCenter(), Script.FRONT);
        actor.applyImpulse(randomInt(Math.floor(_ThrowXMin), Math.floor(_ThrowXMax)), randomInt(Math.floor(_ThrowYMin), Math.floor(_ThrowYMax)), _ThrowForce);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Stuff To Chuck", "_StuffToChuck");
_StuffToChuck = [];
nameMap.set("Actor Type Name To Chuck", "_ActorTypeNameToChuck");
_ActorTypeNameToChuck = "";
nameMap.set("Throw X Min", "_ThrowXMin");
_ThrowXMin = 0.0;
nameMap.set("Throw X Max", "_ThrowXMax");
_ThrowXMax = 0.0;
nameMap.set("Throw Y Min", "_ThrowYMin");
_ThrowYMin = 0.0;
nameMap.set("Throw Y Max", "_ThrowYMax");
_ThrowYMax = 0.0;
nameMap.set("Throw Force", "_ThrowForce");
_ThrowForce = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}