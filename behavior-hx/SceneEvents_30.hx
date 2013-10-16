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



class SceneEvents_30 extends SceneScript
{          	
	
public var _ExitName:String;

public var _LiquidLevel:Float;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";
nameMap.set("Liquid Level", "_LiquidLevel");
_LiquidLevel = 0;

	}
	
	override public function init()
	{
		            _LiquidLevel = asNumber(32);
propertyChanged("_LiquidLevel", _LiquidLevel);
    addActorEntersRegionListener(getRegion(0), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAs(getActor(3), a)){
        getActor(239).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 1, function(timeTask:TimedTask):Void {
                    runPeriodically(1000 * 0.05, function(timeTask:TimedTask):Void {
                                _LiquidLevel -= 1;
propertyChanged("_LiquidLevel", _LiquidLevel);
                                if((_LiquidLevel <= 0))
{
                                    recycleActor(getActor(242));
                                    timeTask.repeats = false;
return;
}

                                getActor(242).setValue("Filling Liquid PM", "_LiquidLevel", _LiquidLevel);
}, null);
}, null);
        runLater(1000 * 3, function(timeTask:TimedTask):Void {
                    getActor(240).say("Activate On Event PM", "_customEvent_" + "Activate");
}, null);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}