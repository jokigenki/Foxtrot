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



class Design_440_440_CheckGameCompleteOnCollectedPM extends ActorScript
{          	
	
public var _LocalCollected:Array<Dynamic>;

public var _TotalEggs:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Local Collected", "_LocalCollected");
_LocalCollected = [];
nameMap.set("Total Eggs", "_TotalEggs");
_TotalEggs = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenKilledListener(actor, function(list:Array<Dynamic>):Void {
if(wrapper.enabled){
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
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}