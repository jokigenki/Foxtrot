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



class Design_147_147_BumpOut extends ActorScript
{          	
	
public var _DeadAnimationLeft:String;

public var _DeadAnimationNeutral:String;

public var _DeadAnimationRight:String;

public var _KillX:Float;

public var _KillY:Float;

public var _KillForce:Float;

public var _ChosenAnimation:String;

public var _SFX:Sound;
    public function _customEvent_Killed():Void
{
        if(isTransitioning())
{
            return;
}

        sayToScene("Sound Manager PM", "_customBlock_PlaySound", [_SFX]);
        actor.say("Disable Behaviours On Killed PM", "_customBlock_RunDisableOnKilled");
        if((_KillX < 0))
{
            _ChosenAnimation = _DeadAnimationLeft;
propertyChanged("_ChosenAnimation", _ChosenAnimation);
}

        else if((_KillX > 0))
{
            _ChosenAnimation = _DeadAnimationRight;
propertyChanged("_ChosenAnimation", _ChosenAnimation);
}

        else
{
            _ChosenAnimation = _DeadAnimationNeutral;
propertyChanged("_ChosenAnimation", _ChosenAnimation);
}

        actor.setXVelocity(0);
        actor.setYVelocity(0);
        actor.applyImpulse(_KillX, _KillY, _KillForce);
        if(actor.hasBehavior("Animation Manager"))
{
            actor.say("Animation Manager", "_customBlock_PlayOnce", [_ChosenAnimation]);
}

        else
{
            actor.setAnimation("" + _ChosenAnimation);
}

        actor.fadeTo(0 / 100, 2, Expo.easeOut);
        runLater(1000 * 2, function(timeTask:TimedTask):Void {
                    recycleActor(actor);
                    if(actor.isBehaviorEnabled("Reload On Death PM"))
{
                        actor.say("Reload On Death PM", "_customEvent_" + "Reload");
}

}, actor);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Dead Animation Left", "_DeadAnimationLeft");
nameMap.set("Dead Animation Neutral", "_DeadAnimationNeutral");
nameMap.set("Dead Animation Right", "_DeadAnimationRight");
nameMap.set("Kill X", "_KillX");
_KillX = 0.0;
nameMap.set("Kill Y", "_KillY");
_KillY = 0.0;
nameMap.set("Kill Force", "_KillForce");
_KillForce = 0.0;
nameMap.set("Chosen Animation", "_ChosenAnimation");
nameMap.set("SFX", "_SFX");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}