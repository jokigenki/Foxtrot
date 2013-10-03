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



class Design_44_44_Ducking extends ActorScript
{          	
	
public var _DuckRightAnimation:String;

public var _DuckLeftAnimation:String;

public var _AnimationCategory:String;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Duck Right Animation", "_DuckRightAnimation");
nameMap.set("Duck Left Animation", "_DuckLeftAnimation");
nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Ducking";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            /* "Inputs:---------------------" */
        /* "\"Facing Right?\" -- <Boolean> Actor Level Attribute, set in \"Walking\" Behavior (required)" */
        /* "Outputs:-------------------" */
        /* "\"Is Ducking?\" -- <Boolean> Actor Level Attribute" */
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Duck"])), Bool))
{
            actor.setActorValue("Is Ducking?", true);
            if(asBoolean(actor.getActorValue("Facing Right?")))
{
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_DuckRightAnimation,_AnimationCategory]);
}

            else
{
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_DuckLeftAnimation,_AnimationCategory]);
}

}

        else
{
            actor.setActorValue("Is Ducking?", false);
            actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}