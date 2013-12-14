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



class Design_57_57_BouncerPM extends ActorScript
{          	
	
public var _BounceForce:Float;

public var _JumpMultiplier:Float;

public var _ExcludedActors:Array<Dynamic>;

public var _MinBounce:Float;

public var _SFXName:String;

public var _SFXNumber:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Bounce Force", "_BounceForce");
_BounceForce = 0.0;
nameMap.set("Jump Multiplier", "_JumpMultiplier");
_JumpMultiplier = 0.0;
nameMap.set("Excluded Actors", "_ExcludedActors");
_ExcludedActors = [];
nameMap.set("Min Bounce", "_MinBounce");
_MinBounce = 0.0;
nameMap.set("SFX Name", "_SFXName");
_SFXName = "";
nameMap.set("SFX Number", "_SFXNumber");
_SFXNumber = 1.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(Utils.contains(_ExcludedActors, ("" + event.otherActor.getType())))
{
            return;
}

        if(event.thisFromTop)
{
            if(event.otherActor.hasBehavior("Control Adapter PM"))
{
                if(((_JumpMultiplier > 0) && cast((event.otherActor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Jump"])), Bool)))
{
                    _BounceForce = asNumber(_JumpMultiplier);
propertyChanged("_BounceForce", _BounceForce);
}

}

            if((_BounceForce < _MinBounce))
{
                _BounceForce = asNumber(_MinBounce);
propertyChanged("_BounceForce", _BounceForce);
}

            if((_BounceForce > 0))
{
                sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_SFXName,_SFXNumber]);
                event.otherActor.push(0, -1, (_BounceForce * 100));
                if(event.otherActor.hasBehavior("Jumping PM"))
{
                    event.otherActor.say("Animation Manager", "_customBlock_ClearCat");
                    if(asBoolean(event.otherActor.getActorValue("Facing Right?")))
{
                        event.otherActor.say("Animation Manager", "_customBlock_LoopAnim", [event.otherActor.getValue("Jumping PM", "_JumpRightAnimation"),event.otherActor.getValue("Jumping PM", "_AnimationCategory")]);
}

                    else
{
                        event.otherActor.say("Animation Manager", "_customBlock_LoopAnim", [event.otherActor.getValue("Jumping PM", "_JumpLeftAnimation"),event.otherActor.getValue("Jumping PM", "_AnimationCategory")]);
}

}

}

            _BounceForce = asNumber(0);
propertyChanged("_BounceForce", _BounceForce);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}