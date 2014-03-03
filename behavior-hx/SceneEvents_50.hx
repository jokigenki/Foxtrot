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
import nme.display.BitmapData;
import nme.display.Bitmap;
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



class SceneEvents_50 extends SceneScript
{          	
	
public var _TotalEggs:Float;

public var _LocalCollected:Array<Dynamic>;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Total Eggs", "_TotalEggs");
_TotalEggs = 0.0;
nameMap.set("Local Collected", "_LocalCollected");
_LocalCollected = [];

	}
	
	override public function init()
	{
		            _TotalEggs = asNumber(0);
propertyChanged("_TotalEggs", _TotalEggs);
        _LocalCollected = getGameAttribute("Collected Items");
propertyChanged("_LocalCollected", _LocalCollected);
        for(item in cast(_LocalCollected, Array<Dynamic>))
{
            if((("" + item).indexOf("Egg") > -1))
{
                _TotalEggs += 1;
propertyChanged("_TotalEggs", _TotalEggs);
}

}

        trace("" + (("" + "Total Eggs: ") + ("" + _TotalEggs)));
        setGameAttribute("Game Complete", (_TotalEggs >= 25));
        if(getGameAttribute("Game Complete"))
{
            getActor(3).disableActorDrawing();
            setGameAttribute("BossFinishText", "You've got ALL THE EGGS!?!|You're AMAZING!|Well done you.");
}

        else
{
            getActor(3).enableActorDrawing();
            setGameAttribute("BossFinishText", "You beat the boss!|But there are more|eggs to collect...");
}

        setGameAttribute("Last Destination", "_Home|_Home|A|A");
        runLater(1000 * 8, function(timeTask:TimedTask):Void {
                    shoutToScene("_customEvent_" + "SwitchScene");
}, null);
        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    sayToScene("Typewriter Text PM", "_customBlock_SetText", [getGameAttribute("BossFinishText")]);
}, null);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}