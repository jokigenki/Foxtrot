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



class SceneEvents_20 extends SceneScript
{          	
	
public var _x1:Float;

public var _y1:Float;

public var _x2:Float;

public var _y2:Float;

public var _x3:Float;

public var _x4:Float;

public var _y3:Float;

public var _y4:Float;

public var _damping:Float;

public var _freq:Float;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("x1", "_x1");
_x1 = 0.0;
nameMap.set("y1", "_y1");
_y1 = 0.0;
nameMap.set("x2", "_x2");
_x2 = 0.0;
nameMap.set("y2", "_y2");
_y2 = 0.0;
nameMap.set("x3", "_x3");
_x3 = 0.0;
nameMap.set("x4", "_x4");
_x4 = 0.0;
nameMap.set("y3", "_y3");
_y3 = 0.0;
nameMap.set("y4", "_y4");
_y4 = 0.0;
nameMap.set("damping", "_damping");
_damping = 0.0;
nameMap.set("freq", "_freq");
_freq = 0.0;

	}
	
	override public function init()
	{
		            if(!(cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected("Egg2_Boss")), Bool)))
{
            recycleActor(getActor(29));
}


	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}