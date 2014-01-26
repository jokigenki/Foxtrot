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



class SceneEvents_30 extends SceneScript
{          	
	
public var _ExitName:String;

public var _LiquidLevel:Float;
    public function _customEvent_InWater():Void
{
        if(getGameAttribute("Is Music On?"))
{
            sayToScene("Sound Manager PM", "_customBlock_LoopMusic", [getSound(961)]);
}

}

    public function _customEvent_OutOfWater():Void
{
        if(getGameAttribute("Is Music On?"))
{
            sayToScene("Sound Manager PM", "_customBlock_LoopMusic", [getSound(756)]);
}

}


 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";
nameMap.set("Liquid Level", "_LiquidLevel");
_LiquidLevel = 0.0;

	}
	
	override public function init()
	{
		            _LiquidLevel = asNumber(32);
propertyChanged("_LiquidLevel", _LiquidLevel);
        runLater(1000 * 0.2, function(timeTask:TimedTask):Void {
                    sayToScene("Sound Manager PM", "_customBlock_LoopSceneSound", ["Fire Loop SFX",getCurrentSceneName()]);
}, null);
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