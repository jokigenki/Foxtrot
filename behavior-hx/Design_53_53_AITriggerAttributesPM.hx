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



class Design_53_53_AITriggerAttributesPM extends ActorScript
{          	
	
public var _TriggerId:String;

public var _IncludedActorTypes:Array<Dynamic>;

public var _ExcludedActorTypes:Array<Dynamic>;

public var _TriggerCount:Float;

public var _KillTriggerAfterHits:Float;

public var _HasCollided:Bool;

public var _EventName:String;

public var _IsColliding:Bool;

public var _TargetActor:Actor;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Trigger Id", "_TriggerId");
_TriggerId = "";
nameMap.set("Included Actor Types", "_IncludedActorTypes");
_IncludedActorTypes = [];
nameMap.set("Excluded Actor Types", "_ExcludedActorTypes");
_ExcludedActorTypes = [];
nameMap.set("Trigger Count", "_TriggerCount");
_TriggerCount = 0.0;
nameMap.set("Kill Trigger After Hits", "_KillTriggerAfterHits");
_KillTriggerAfterHits = -1.0;
nameMap.set("Has Collided?", "_HasCollided");
_HasCollided = false;
nameMap.set("Event Name", "_EventName");
_EventName = "";
nameMap.set("Is Colliding?", "_IsColliding");
_IsColliding = false;
nameMap.set("Target Actor", "_TargetActor");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            actor.disableActorDrawing();
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_HasCollided)
{
            if(!(_IsColliding))
{
                _IsColliding = true;
propertyChanged("_IsColliding", _IsColliding);
                _TriggerCount += 1;
propertyChanged("_TriggerCount", _TriggerCount);
                if(!(("" + _EventName) == ("")))
{
                    if(!(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorIsNull(_TargetActor)), Bool)))
{
                        _TargetActor.shout("_customEvent_" + _EventName);
}

                    else
{
                        shoutToScene("_customEvent_" + _EventName);
}

}

                if(((_KillTriggerAfterHits > -1) && (_TriggerCount >= _KillTriggerAfterHits)))
{
                    recycleActor(actor);
}

}

}

        else
{
            _IsColliding = false;
propertyChanged("_IsColliding", _IsColliding);
}

        _HasCollided = false;
propertyChanged("_HasCollided", _HasCollided);
}
});
    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(((_IncludedActorTypes.length > 0) && !(Utils.contains(_IncludedActorTypes, ("" + event.otherActor.getType())))))
{
            return;
}

        if(((_ExcludedActorTypes.length > 0) && Utils.contains(_ExcludedActorTypes, ("" + event.otherActor.getType()))))
{
            return;
}

        _HasCollided = true;
propertyChanged("_HasCollided", _HasCollided);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}