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



class Design_139_139_HeadStompPM extends ActorScript
{          	
	
public var _KillBehaviour:String;

public var _KillSelfAfterStomp:Bool;
    

/* Params are: __Stomped */
public function _customBlock_Stomp(__Stomped:Actor):Void
{
var __Self:Actor = actor;
        if(__Stomped.hasBehavior("Stompable PM"))
{
            if(cast((__Stomped.say("Stompable PM", "_customBlock_CanBeStompedByActor", [actor])), Bool))
{
                scripts.Design_27_27_ActorExtrasPM._customBlock_TriggerKilledInActor(__Stomped,_KillBehaviour,randomInt(Math.floor(-1), Math.floor(1)),-2);
                if(_KillSelfAfterStomp)
{
                    scripts.Design_27_27_ActorExtrasPM._customBlock_TriggerKilledInActor(actor,"Default Kill Behaviour PM",0,-1);
}

}

}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Kill Behaviour", "_KillBehaviour");
_KillBehaviour = "";
nameMap.set("Kill Self After Stomp", "_KillSelfAfterStomp");
_KillSelfAfterStomp = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled && sameAsAny(getActorGroup(8),event.otherActor.getType(),event.otherActor.getGroup())){
        if(event.otherFromTop)
{
            actor.say("Head Stomp PM", "_customBlock_Stomp", [event.otherActor]);
}

}
});
    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled && sameAsAny(getActorGroup(11),event.otherActor.getType(),event.otherActor.getGroup())){
        if(event.otherFromTop)
{
            actor.say("Head Stomp PM", "_customBlock_Stomp", [event.otherActor]);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}