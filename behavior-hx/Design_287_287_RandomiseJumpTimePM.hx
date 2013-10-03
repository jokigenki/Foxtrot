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



class Design_287_287_RandomiseJumpTimePM extends ActorScript
{          	
	
public var _RandomiseAfterTime:Float;

public var _RandomMax:Float;

public var _RandomMin:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Randomise After Time", "_RandomiseAfterTime");
_RandomiseAfterTime = 0.0;
nameMap.set("Random Max", "_RandomMax");
_RandomMax = 0.0;
nameMap.set("Random Min", "_RandomMin");
_RandomMin = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            runLater(1000 * _RandomiseAfterTime, function(timeTask:TimedTask):Void {
                    actor.setValue("Bouncing PM", "_JumpTime", ((randomFloat() * (_RandomMax - _RandomMin)) + _RandomMin));
}, actor);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}