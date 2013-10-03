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



class Design_33_33_TurnAroundOnTriggerPM extends ActorScript
{          	
	
public var _LastCollidedTrigger:Actor;

public var _IsColliding:Bool;

public var _NewCollider:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Last Collided Trigger", "_LastCollidedTrigger");
nameMap.set("Is Colliding?", "_IsColliding");
_IsColliding = false;
nameMap.set("New Collider?", "_NewCollider");
_NewCollider = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled && sameAsAny(getActorType(230), event.otherActor.getType(),event.otherActor.getGroup())){
        _IsColliding = true;
propertyChanged("_IsColliding", _IsColliding);
        _NewCollider = true;
propertyChanged("_NewCollider", _NewCollider);
        if((event.otherActor == _LastCollidedTrigger))
{
            _NewCollider = false;
propertyChanged("_NewCollider", _NewCollider);
            return;
}

        _LastCollidedTrigger = event.otherActor;
propertyChanged("_LastCollidedTrigger", _LastCollidedTrigger);
}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_IsColliding)
{
            if((_NewCollider && (_LastCollidedTrigger.getValue("AI Trigger Attributes PM", "_TriggerId") == "Turn Around")))
{
                /* "Custom: Is \"Left\" on for Self" */
                if(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Left"])), Bool))
{
                    /* "Custom: Set \"Right\" to <true> for Self" */
                    actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",true]);
                    /* "Custom: Set \"Left\" to <false> for Self" */
                    actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",false]);
}

                /* "Custom: Is \"Right\" on for Self" */
                else if(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Right"])), Bool))
{
                    /* "Custom: Set \"Left\" to <true> for Self" */
                    actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",true]);
                    /* "Custom: Set \"Right\" to <false> for Self" */
                    actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",false]);
}

}

}

        else
{
            _LastCollidedTrigger = actor;
propertyChanged("_LastCollidedTrigger", _LastCollidedTrigger);
}

        _IsColliding = false;
propertyChanged("_IsColliding", _IsColliding);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}