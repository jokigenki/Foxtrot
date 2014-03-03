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



class Design_25_25_GroundPoundPM extends ActorScript
{          	
	
public var _CanPound:Bool;

public var _DownKeyRequired:Bool;

public var _Force:Float;

public var _PoundRightAnimation:String;

public var _PoundLeftAnimation:String;

public var _OldX:Float;

public var _AnimationCategory:String;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Can Pound?", "_CanPound");
_CanPound = false;
nameMap.set("Down Key Required?", "_DownKeyRequired");
_DownKeyRequired = true;
nameMap.set("Force", "_Force");
_Force = 0.0;
nameMap.set("Pound Right Animation", "_PoundRightAnimation");
nameMap.set("Pound Left Animation", "_PoundLeftAnimation");
nameMap.set("Old X", "_OldX");
_OldX = 0.0;
nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Ground Pounding";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            /* "Inputs: ----------------------" */
        /* "\"On Ground?\" -- <Boolean> Actor Level Attribute, from \"On Ground\" Behavior (required)" */
        /* "\"Is Jumping?\" -- <Boolean> Actor Level Attribute, from \"PM Jumping\" Behavior (required)" */
        /* "\"Facing Right?\" -- <Boolean> Actor Level Attribute, from \"PM Walking\" Behavior (required)" */
        /* "\"Is Wall Sliding?\" -- <Boolean> Actor Level Attribute, from \"PM Wall Sliding\" Behavior (NOT required)" */
        /* "Outputs: ---------------------" */
        /* "\"Is Ground Pounding\" -- <Boolean> Actor Level Attribute" */
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(asBoolean(actor.getActorValue("Is Wall Sliding?")))
{
            actor.setActorValue("Is Ground Pounding?", false);
            /* "Custom: Clear Current Anim Category If Same As <Animation Category>" */
            actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
            _CanPound = false;
propertyChanged("_CanPound", _CanPound);
            return;
}

        if((!(asBoolean(actor.getActorValue("Is Jumping?"))) || asBoolean(actor.getActorValue("On Ground?"))))
{
            if((asBoolean(actor.getActorValue("Is Ground Pounding?")) && asBoolean(actor.getActorValue("On Ground?"))))
{
                startShakingScreen(1 / 100, 0.2);
}

            _CanPound = false;
propertyChanged("_CanPound", _CanPound);
            actor.setActorValue("Is Ground Pounding?", false);
            /* "Custom: Clear Current Anim Category If Same As <Animation Category>" */
            actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
            return;
}

        /* "Custom: \"GroundPound\" was switched on for Self" */
        if(cast((actor.say("Control Adapter PM", "_customBlock_ControlSwitchedOn", ["GroundPound"])), Bool))
{
            /* "Custom: Is \"Down\" on for Self" */
            if((_DownKeyRequired && !(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Down"])), Bool))))
{
                return;
}

            _CanPound = false;
propertyChanged("_CanPound", _CanPound);
            actor.setActorValue("Is Ground Pounding?", true);
            actor.applyImpulse(0, 1, _Force);
}

        if(asBoolean(actor.getActorValue("Is Ground Pounding?")))
{
            actor.setXVelocity(0);
            actor.setX(_OldX);
            if(asBoolean(actor.getActorValue("Facing Right?")))
{
                /* "Loop <Pound Right Animation> for Self Using <Animation Category>" */
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_PoundRightAnimation,_AnimationCategory]);
}

            else
{
                /* "Loop <Pound Left Animation> for Self Using <Animation Category>" */
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_PoundLeftAnimation,_AnimationCategory]);
}

}

        _OldX = asNumber(actor.getX());
propertyChanged("_OldX", _OldX);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}