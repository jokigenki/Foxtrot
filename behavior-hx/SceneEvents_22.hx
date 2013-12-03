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



class SceneEvents_22 extends SceneScript
{          	
	
public var _ExitName:String;

public var _BottomCrushersOn:Bool;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";
nameMap.set("Bottom Crushers On?", "_BottomCrushersOn");
_BottomCrushersOn = false;

	}
	
	override public function init()
	{
		            stopSoundOnChannel(Std.int(1));
        if((!(getGameAttribute("Speed Run In Progress")) || cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected("FactoryBossKey")), Bool)))
{
            recycleActor(getActor(184));
            recycleActor(getActor(185));
}

        _BottomCrushersOn = false;
propertyChanged("_BottomCrushersOn", _BottomCrushersOn);
    addActorEntersRegionListener(getRegion(1), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAs(getActor(3), a)){
        getActor(162).say("Activate On Event PM", "_customEvent_" + "Activate");
        getActor(179).say("Activate On Event PM", "_customEvent_" + "Activate");
}
});
    addActorEntersRegionListener(getRegion(4), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAs(getActor(3), a)){
        if(!(_BottomCrushersOn))
{
            _BottomCrushersOn = true;
propertyChanged("_BottomCrushersOn", _BottomCrushersOn);
            for(actorOfType in getActorsOfType(getActorType(421)))
{
if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
                if(asBoolean(actorOfType.getValue("Timed Activation PM", "_IsActive")))
{
                    actorOfType.say("Timed Activation PM", "_customEvent_" + "Deactivate");
}

                else
{
                    actorOfType.say("Timed Activation PM", "_customEvent_" + "Activate");
}

}
}

            for(actorOfType in getActorsOfType(getActorType(427)))
{
if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
                if(asBoolean(actorOfType.getValue("Timed Activation PM", "_IsActive")))
{
                    actorOfType.say("Timed Activation PM", "_customEvent_" + "Deactivate");
}

                else
{
                    actorOfType.say("Timed Activation PM", "_customEvent_" + "Activate");
}

}
}

}

}
});
    addActorExitsRegionListener(getRegion(4), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAs(getActor(3), a)){
        if(_BottomCrushersOn)
{
            _BottomCrushersOn = false;
propertyChanged("_BottomCrushersOn", _BottomCrushersOn);
            for(actorOfType in getActorsOfType(getActorType(421)))
{
if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
                if(asBoolean(actorOfType.getValue("Timed Activation PM", "_IsActive")))
{
                    actorOfType.say("Timed Activation PM", "_customEvent_" + "Deactivate");
}

                else
{
                    actorOfType.say("Timed Activation PM", "_customEvent_" + "Activate");
}

}
}

            for(actorOfType in getActorsOfType(getActorType(427)))
{
if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
                if(asBoolean(actorOfType.getValue("Timed Activation PM", "_IsActive")))
{
                    actorOfType.say("Timed Activation PM", "_customEvent_" + "Deactivate");
}

                else
{
                    actorOfType.say("Timed Activation PM", "_customEvent_" + "Activate");
}

}
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}