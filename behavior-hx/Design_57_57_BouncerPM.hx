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



class Design_57_57_BouncerPM extends ActorScript
{          	
	
public var _BounceForce:Float;

public var _JumpMultiplier:Float;

public var _ExcludedActors:Array<Dynamic>;

public var _MinBounce:Float;

 
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
                event.otherActor.push(0, -1, (_BounceForce * 100));
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