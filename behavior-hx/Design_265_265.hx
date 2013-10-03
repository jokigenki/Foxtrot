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



class Design_265_265 extends ActorScript
{          	
	
public var _IsActive:Bool;

public var _MoveTime:Float;

public var _ActiveChanged:Bool;

public var _EaseType:String;

public var _RotationStart:Float;

public var _RotationTarget:Float;
    public function _customEvent_Activated():Void
{
        var trans =
switch(_EaseType)
{
	case "None":
		Linear.easeNone;
	case "Normal In":
		Quad.easeIn;
	case "Normal Out":
		Quad.easeOut;
	case "Strong In":
		Expo.easeIn;
	case "Strong Out":
		Expo.easeOut;
	default:
		Quad.easeOut;
}

actor.spinTo(_RotationTarget, _MoveTime, trans);
}

    public function _customEvent_Deactivated():Void
{
        var trans =
switch(_EaseType)
{
	case "None":
		Linear.easeNone;
	case "Normal In":
		Quad.easeIn;
	case "Normal Out":
		Quad.easeOut;
	case "Strong In":
		Expo.easeIn;
	case "Strong Out":
		Expo.easeOut;
	default:
		Quad.easeOut;
}

actor.spinTo(_RotationStart, _MoveTime, trans);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Move Time", "_MoveTime");
_MoveTime = 1.0;
nameMap.set("Active Changed", "_ActiveChanged");
_ActiveChanged = false;
nameMap.set("Ease Type", "_EaseType");
_EaseType = "";
nameMap.set("Rotation Start", "_RotationStart");
_RotationStart = 0.0;
nameMap.set("Rotation Target", "_RotationTarget");
_RotationTarget = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _RotationStart = asNumber(Utils.DEG * (actor.getAngle()));
propertyChanged("_RotationStart", _RotationStart);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}