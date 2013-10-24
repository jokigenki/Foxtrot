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



class SceneEvents_17 extends SceneScript
{          	
	
public var _ExitName:String;

public var _RunComplete:Bool;
    public function _customEvent_RoosterKilled():Void
{
        createRecycledActor(getActorType(196), 520, 256, Script.BACK);
        getLastCreatedActor().fadeTo(1, 2, Quad.easeOut);
        createRecycledActor(getActorType(178), 488, 289, Script.BACK);
        getLastCreatedActor().fadeTo(1, 2, Quad.easeOut);
        getLastCreatedActor().setValue("Inventory Collectable PM", "_Collectioneventname", "EggCollected");
        getLastCreatedActor().setValue("Inventory Collectable PM", "_CollectableId", "Egg1_Boss");
        getLastCreatedActor().setAnimation("" + "Egg1_Boss");
        trace("" + getGameAttribute("Speed Run In Progress"));
        if(getGameAttribute("Speed Run In Progress"))
{
            _RunComplete = true;
propertyChanged("_RunComplete", _RunComplete);
            for(item in cast(getGameAttribute("Speed Run Collectables"), Array<Dynamic>))
{
                if(!(Utils.contains(getGameAttribute("Collected Speed Run Items"), item)))
{
                    trace("" + (("" + "Missing: ") + ("" + item)));
                    _RunComplete = false;
propertyChanged("_RunComplete", _RunComplete);
                    break;
}

}

            if(_RunComplete)
{
                trace("" + "SPEED RUN COMPLETE!");
                sayToScene("Speed Run Timer PM", "_customEvent_" + "CompleteSpeedRun");
}

}

}

    public function _customEvent_ReducedHealth():Void
{
        if((asNumber(getActor(8).getValue("Reduce Health PM", "_CurrentHealth")) == 1))
{
            if(getGameAttribute("Music On"))
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
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}