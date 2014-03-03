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



class Design_47_47_SlowdownPM extends ActorScript
{          	
	
public var _GroundSlowdown:Float;

public var _AirSlowdown:Float;

public var _DuckingSlowdown:Float;

public var _MovingAirSlowdown:Float;

public var _MovingGroundSlowdown:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Ground Slowdown", "_GroundSlowdown");
_GroundSlowdown = 0.9;
nameMap.set("Air Slowdown", "_AirSlowdown");
_AirSlowdown = 0.99;
nameMap.set("Ducking Slowdown", "_DuckingSlowdown");
_DuckingSlowdown = 0.975;
nameMap.set("Moving Air Slowdown", "_MovingAirSlowdown");
_MovingAirSlowdown = 0.975;
nameMap.set("Moving Ground Slowdown", "_MovingGroundSlowdown");
_MovingGroundSlowdown = 0.9;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            /* "Inputs: ----------------------" */
        /* "\"On Ground?\" -- <Boolean> Actor Level Attribute, from \"On Ground\" Behavior" */
        /* "\"Is Ducking?\" -- <Boolean> Actor Level Attribute, from \"Ducking\" Behavior" */
        /* "\"Is Slope Sliding?\" -- <Boolean> Actor Level Attribute, from \"Slope Detection\" Behavior" */
        /* "Outputs: ---------------------" */
        /* "None" */
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(asBoolean(actor.getActorValue("Is Slope Sliding?")))
{
            return;
}

        if((asBoolean(actor.getActorValue("Is Ducking?")) && asBoolean(actor.getActorValue("On Ground?"))))
{
            actor.setXVelocity((actor.getXVelocity() * _DuckingSlowdown));
            return;
}

        /* "Custom: Is \"Right\" on for Self, Is \"Left\" on for Self" */
        if(((!(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Right"])), Bool)) && !(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Left"])), Bool))) && !(asBoolean(actor.getActorValue("Is Ducking?")))))
{
            if(asBoolean(actor.getActorValue("On Ground?")))
{
                actor.setXVelocity((actor.getXVelocity() * _GroundSlowdown));
}

            else
{
                actor.setXVelocity((actor.getXVelocity() * _AirSlowdown));
}

}

        else
{
            if(asBoolean(actor.getActorValue("On Ground?")))
{
                /* "Custom: Slow Down Self To Max Speed Using Rate <Moving Ground Slowdown>" */
                
}

            else
{
                actor.setXVelocity((actor.getXVelocity() * _MovingAirSlowdown));
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}