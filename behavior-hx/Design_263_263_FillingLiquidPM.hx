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



class Design_263_263_FillingLiquidPM extends ActorScript
{          	
	
public var _LiquidLevel:Float;

public var _MaxLevel:Float;

public var _ClipHeight:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Liquid Level", "_LiquidLevel");
_LiquidLevel = 0.0;
nameMap.set("Max Level", "_MaxLevel");
_MaxLevel = 0.0;
nameMap.set("Clip Height", "_ClipHeight");
_ClipHeight = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        var level = _LiquidLevel < _MaxLevel ? _LiquidLevel : _MaxLevel;
var h = (level / _ClipHeight) * 100;
        actor.growTo(100/100, h/100, 0.1, Linear.easeNone);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}