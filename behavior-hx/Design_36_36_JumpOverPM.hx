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



class Design_36_36_JumpOverPM extends ActorScript
{          	
	
public var _MaxHeight:Float;

public var _StartJump:Bool;

public var _JumpTime:Float;

public var _LastCollidedTrigger:Actor;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Max Height", "_MaxHeight");
_MaxHeight = 0.0;
nameMap.set("Start Jump?", "_StartJump");
_StartJump = false;
nameMap.set("Jump Time", "_JumpTime");
_JumpTime = 0.0;
nameMap.set("Last Collided Trigger", "_LastCollidedTrigger");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled && sameAsAny(getActorType(230), event.otherActor.getType(),event.otherActor.getGroup())){
        if((event.otherActor.getValue("AI Trigger Attributes PM", "_TriggerId") == "Jump Over"))
{
            /* "Custom: Is \"Jump\" on for <this actor> " */
            if(cast((event.thisActor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Jump"])), Bool))
{
                return;
}

            if((event.otherFromRight && !(event.otherActor.getValue("AI Trigger Attributes PM", "_TriggerOnRight"))))
{
                return;
}

            if((event.otherFromLeft && !(event.otherActor.getValue("AI Trigger Attributes PM", "_TriggerOnLeft"))))
{
                return;
}

            if((event.otherFromTop && !(event.otherActor.getValue("AI Trigger Attributes PM", "_TriggerOnTop"))))
{
                return;
}

            if((event.otherFromBottom && !(event.otherActor.getValue("AI Trigger Attributes PM", "_TriggerOnBottom"))))
{
                return;
}

            if(!(asBoolean(event.thisActor.getActorValue("On Ground?"))))
{
                return;
}

            /* "Custom: Get bottom for <this actor>, Get top for <other actor>" */
            if(((cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorBottom(event.thisActor)), Float) - cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop(event.otherActor)), Float)) > _MaxHeight))
{
                return;
}

            /* "Custom: Set \"Jump\" to <true> for Self" */
            actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",true]);
            runLater(1000 * (_JumpTime * event.otherActor.getValue("AI Trigger Attributes PM", "_TriggerValue")), function(timeTask:TimedTask):Void {
                        /* "Custom: Set \"Jump\" to <false> for Self" */
                        actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",false]);
}, actor);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}