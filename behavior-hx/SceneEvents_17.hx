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



class SceneEvents_17 extends SceneScript
{          	
	
public var _ExitName:String;

public var _RunComplete:Bool;
    public function _customEvent_RoosterKilled():Void
{
        createRecycledActor(getActorType(196), 520, 256, Script.BACK);
        getLastCreatedActor().fadeTo(1, 2, Quad.easeOut);
        getActor(13).say("Activate On Event PM", "_customEvent_" + "Activate");
        if(getGameAttribute("Speed Run In Progress"))
{
            _RunComplete = true;
propertyChanged("_RunComplete", _RunComplete);
            for(item in cast(getGameAttribute("Speed Run Collectables"), Array<Dynamic>))
{
                if(!(Utils.contains(getGameAttribute("Collected Speed Run Items"), item)))
{
                    _RunComplete = false;
propertyChanged("_RunComplete", _RunComplete);
                    break;
}

}

            if(_RunComplete)
{
                sayToScene("Speed Run Timer PM", "_customEvent_" + "CompleteSpeedRun");
}

}

}

    public function _customEvent_ReducedHealth():Void
{
        if((asNumber(getActor(8).getValue("Reduce Health PM", "_CurrentHealth")) == 1))
{
            if(getGameAttribute("Is Music On?"))
{
                sayToScene("Sound Manager PM", "_customBlock_LoopMusic", [getSound(627)]);
}

}

}


 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";
nameMap.set("Run Complete?", "_RunComplete");
_RunComplete = false;

	}
	
	override public function init()
	{
		            runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    if(getGameAttribute("Speed Run In Progress"))
{
                        getActor(14).setValue("Inventory Collectable PM", "_CollectableId", "Egg1_Speed");
                        getActor(14).setAnimation("" + ("" + "Egg1_Speed"));
}

}, null);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}