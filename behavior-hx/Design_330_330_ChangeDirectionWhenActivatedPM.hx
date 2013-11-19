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



class Design_330_330_ChangeDirectionWhenActivatedPM extends ActorScript
{          	
	
public var _DirectionBehaviour:String;

public var _ActiveValue:Float;

public var _InactiveValue:Float;
    public function _customEvent_Activated():Void
{
        trace("" + (("" + actor.name) + ("" + " activated")));
        actor.setValue(_DirectionBehaviour, "_Direction", _ActiveValue);
}

    public function _customEvent_Deactivated():Void
{
        trace("" + (("" + actor.name) + ("" + " deactivated")));
        actor.setValue(_DirectionBehaviour, "_Direction", _InactiveValue);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Direction Behaviour", "_DirectionBehaviour");
_DirectionBehaviour = "";
nameMap.set("Active Value", "_ActiveValue");
_ActiveValue = 0.0;
nameMap.set("Inactive Value", "_InactiveValue");
_InactiveValue = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}