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



class Design_91_91_CollectablePM extends ActorScript
{          	
	
public var _CollectionEvent:String;

public var _TargetActor:Actor;

public var _CollectableId:String;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Collection Event", "_CollectionEvent");
_CollectionEvent = "";
nameMap.set("Target Actor", "_TargetActor");
nameMap.set("Collectable Id", "_CollectableId");
_CollectableId = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if((!(actor.hasBehavior("Display On Collected PM")) && cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected(_CollectableId)), Bool)))
{
            recycleActor(actor);
}

    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled && sameAsAny(getActorGroup(0),event.otherActor.getType(),event.otherActor.getGroup())){
        if(!(cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected(_CollectableId)), Bool)))
{
            if(!(("" + _CollectableId) == ("")))
{
                scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_CollectItemWithType(_CollectableId,event.thisActor.getType());
                shoutToScene("_customEvent_" + _CollectionEvent);
}

            if(!(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorIsNull(_TargetActor)), Bool)))
{
                _TargetActor.shout("_customEvent_" + _CollectionEvent);
}

            if(actor.hasBehavior("Display On Collected PM"))
{
                actor.say("Display On Collected PM", "_customBlock_DisplayOnCollect");
}

            saveGame("mySave", function(success:Bool):Void {

});
            recycleActor(actor);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}