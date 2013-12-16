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



class Design_372_372_BurnOutPM extends ActorScript
{          	
	
public var _IsKilled:Bool;

public var _RightAnimation:String;

public var _LeftAnimation:String;

public var _SFX:Sound;
    public function _customEvent_Killed():Void
{
        if(_IsKilled)
{
            return;
}

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

        sayToScene("Sound Manager PM", "_customBlock_PlaySound", [_SFX]);
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
		nameMap.set("Is Killed?", "_IsKilled");
_IsKilled = false;
nameMap.set("Right Animation", "_RightAnimation");
nameMap.set("Left Animation", "_LeftAnimation");
nameMap.set("SFX", "_SFX");
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