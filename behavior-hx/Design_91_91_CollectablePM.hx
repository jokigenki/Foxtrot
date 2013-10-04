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
		            if(cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected(_CollectableId)), Bool))
{
            recycleActor(actor);
}

    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled && sameAsAny(getActorGroup(0),event.otherActor.getType(),event.otherActor.getGroup())){
        recycleActor(actor);
        if(!(("" + _CollectableId) == ("")))
{
            scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_CollectItemWithType(_CollectableId,event.thisActor.getType());
            shoutToScene("_customEvent_" + _CollectionEvent);
}

        if(!(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorIsNull(_TargetActor)), Bool)))
{
            _TargetActor.shout("_customEvent_" + _CollectionEvent);
}

        saveGame("mySave", function(success:Bool):Void {

});
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}