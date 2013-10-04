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



class Design_140_140_KillAfterAnimation extends ActorScript
{          	
	
public var _DyingAnimation:String;

public var _IsDying:Bool;

public var _WasKilled:Bool;
    public function _customEvent_Killed():Void
{
        actor.say("Disable Behaviours On Killed PM", "_customBlock_RunDisableOnKilled");
        _WasKilled = true;
propertyChanged("_WasKilled", _WasKilled);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Dying Animation", "_DyingAnimation");
nameMap.set("Is Dying?", "_IsDying");
_IsDying = false;
nameMap.set("Was Killed?", "_WasKilled");
_WasKilled = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _WasKilled = false;
propertyChanged("_WasKilled", _WasKilled);
        _IsDying = false;
propertyChanged("_IsDying", _IsDying);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((_WasKilled && !(actor.getAnimation() == _DyingAnimation)))
{
            actor.setAnimation("" + _DyingAnimation);
            _IsDying = true;
propertyChanged("_IsDying", _IsDying);
}

        if((_IsDying && (actor.getCurrentFrame() == actor.getNumFrames())))
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