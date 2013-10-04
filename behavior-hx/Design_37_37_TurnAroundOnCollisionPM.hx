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



class Design_37_37_TurnAroundOnCollisionPM extends ActorScript
{          	
	
public var _ExcludedActors:Array<Dynamic>;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Excluded Actors", "_ExcludedActors");
_ExcludedActors = [];
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(event.thisCollidedWithSensor)
{
            return;
}

        if((!(asBoolean(event.thisActor.getActorValue("On Ground?"))) || Utils.contains(_ExcludedActors, ("" + event.otherActor.getType()))))
{
            return;
}

        /* "Custom: Is \"Left\" on for Self" */
        if((event.otherFromRight && cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Left"])), Bool)))
{
            /* "Custom: Set \"Right\" to <true> for Self" */
            /* "Custom: Set \"Left\" to <false> for Self" */
            actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",true]);
            actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",false]);
}

        /* "Custom: Is \"Right\" on for Self" */
        else if((event.otherFromLeft && cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Right"])), Bool)))
{
            /* "Custom: Set \"Left\" to <true> for Self" */
            actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",true]);
            /* "Custom: Set \"Right\" to <false> for Self" */
            actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",false]);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}