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
import nme.display.BitmapData;
import nme.display.Bitmap;
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



class Design_33_33_TurnAroundOnTriggerPM extends ActorScript
{          	
	
public var _Direction:String;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Direction", "_Direction");
_Direction = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled && sameAsAny(getActorType(646), event.otherActor.getType(),event.otherActor.getGroup())){
        _Direction = event.otherActor.getValue("Turn Trigger PM", "_TurnDirection");
propertyChanged("_Direction", _Direction);
        if((actor.getActorValue("Facing Right?") && (_Direction == "Left")))
{
            /* "Custom: Set \"Left\" to <true> for Self" */
            actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",true]);
            /* "Custom: Set \"Right\" to <false> for Self" */
            actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",false]);
}

        else if((!(actor.getActorValue("Facing Right?")) && (_Direction == "Right")))
{
            /* "Custom: Set \"Right\" to <true> for Self" */
            actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",true]);
            /* "Custom: Set \"Left\" to <false> for Self" */
            actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",false]);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}