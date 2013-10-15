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



class Design_64_64_CollectablePM extends ActorScript
{          	
	
public var _CollectionEventName:String;

public var _CollectableId:String;
    

/* Params are:__Self */
public function _customBlock_KillIfCollected():Bool
{
var __Self:Actor = actor;
        if(cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected(_CollectableId)), Bool))
{
            __Self.disableBehavior("Display On Collected PM");
            recycleActor(__Self);
            return true;
}

        return false;
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Collection Event Name", "_CollectionEventName");
_CollectionEventName = "";
nameMap.set("Collectable Id", "_CollectableId");
_CollectableId = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if(cast((actor.say("Inventory Collectable PM", "_customBlock_KillIfCollected")), Bool))
{

}

    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled && sameAsAny(getActorGroup(0),event.otherActor.getType(),event.otherActor.getGroup())){
        if(event.otherActor.hasBehavior("Collector PM"))
{
            if(!(("" + _CollectableId) == ("")))
{
                scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_CollectItemWithType(_CollectableId,event.thisActor.getType());
                actor.shout("_customEvent_" + _CollectionEventName);
}

            recycleActor(actor);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}