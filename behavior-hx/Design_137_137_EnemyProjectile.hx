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



class Design_137_137_EnemyProjectile extends ActorScript
{          	
	
public var _ExcludedActorTypes:Array<Dynamic>;

public var _KillBehaviour:String;

public var _KillX:Float;

public var _KillY:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Excluded Actor Types", "_ExcludedActorTypes");
_ExcludedActorTypes = [];
nameMap.set("Kill Behaviour", "_KillBehaviour");
_KillBehaviour = "";
nameMap.set("Kill X", "_KillX");
_KillX = 0.0;
nameMap.set("Kill Y", "_KillY");
_KillY = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(!(("" + _KillBehaviour) == ("")))
{
            for(point in event.points)
{
                _KillX = asNumber(Math.round(Engine.toPixelUnits(point.normalX)));
propertyChanged("_KillX", _KillX);
                _KillY = asNumber(Math.round(Engine.toPixelUnits(point.normalY)));
propertyChanged("_KillY", _KillY);
}

            scripts.Design_27_27_ActorExtrasPM._customBlock_TriggerKilledInActor(event.thisActor,_KillBehaviour,_KillX,_KillY);
}

        else
{
            if(isTransitioning())
{
                return;
}

            recycleActor(event.thisActor);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}