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



class Design_256_256_SkeletonOutPM extends ActorScript
{          	
	
public var _RightAnimation:String;

public var _LeftAnimation:String;

public var _IsKilled:Bool;
    public function _customEvent_Killed():Void
{
        _IsKilled = true;
propertyChanged("_IsKilled", _IsKilled);
        actor.say("Disable Behaviours On Killed PM", "_customBlock_RunDisableOnKilled");
        if((actor.getActorValue("Facing Right?") == true))
{
            actor.say("Animation Manager", "_customBlock_PlayOnce", [_RightAnimation]);
}

        else
{
            actor.say("Animation Manager", "_customBlock_PlayOnce", [_LeftAnimation]);
}

}

            public function animationHasFinished ():Bool
{
	return _IsKilled &&
		(!actor.isAnimationPlaying() ||
		(actor.getAnimation() != _LeftAnimation &&
		actor.getAnimation() != _RightAnimation));
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Right Animation", "_RightAnimation");
nameMap.set("Left Animation", "_LeftAnimation");
nameMap.set("Is Killed?", "_IsKilled");
_IsKilled = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(animationHasFinished ())
{
            recycleActor(actor);
            if(actor.isBehaviorEnabled("Reload On Death PM"))
{
                actor.say("Reload On Death PM", "_customEvent_" + "Reload");
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}