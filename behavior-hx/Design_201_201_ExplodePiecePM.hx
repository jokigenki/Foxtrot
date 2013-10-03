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



class Design_201_201_ExplodePiecePM extends ActorScript
{          	
	
public var _XDirection:Float;

public var _MaxXDirection:Float;

public var _MinXDirection:Float;

public var _YDirection:Float;

public var _MaxYDirection:Float;

public var _MinYDirection:Float;

public var _ExplodeForce:Float;

public var _FadeTime:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("X Direction", "_XDirection");
_XDirection = 0.0;
nameMap.set("Max X Direction", "_MaxXDirection");
_MaxXDirection = 0.0;
nameMap.set("Min X Direction", "_MinXDirection");
_MinXDirection = 0.0;
nameMap.set("Y Direction", "_YDirection");
_YDirection = 0.0;
nameMap.set("Max Y Direction", "_MaxYDirection");
_MaxYDirection = 0.0;
nameMap.set("Min Y Direction", "_MinYDirection");
_MinYDirection = 0.0;
nameMap.set("Explode Force", "_ExplodeForce");
_ExplodeForce = 0.0;
nameMap.set("Fade Time", "_FadeTime");
_FadeTime = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _XDirection = asNumber(((randomFloat() * (_MaxXDirection - _MinXDirection)) + _MinXDirection));
propertyChanged("_XDirection", _XDirection);
        _YDirection = asNumber(((randomFloat() * (_MaxYDirection - _MinYDirection)) + _MinYDirection));
propertyChanged("_YDirection", _YDirection);
        actor.applyImpulse(_XDirection, _YDirection, _ExplodeForce);
        actor.fadeTo(0, _FadeTime, Quad.easeOut);
        runLater(1000 * _FadeTime, function(timeTask:TimedTask):Void {
                    recycleActor(actor);
}, actor);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}