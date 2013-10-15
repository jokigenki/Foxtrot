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



class Design_227_227_LiquidPM extends ActorScript
{          	
	
public var _Buoyancy:Float;

public var _TotalBuoyancy:Float;

public var _Liquidity:Float;

public var _AllowJumping:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Buoyancy", "_Buoyancy");
_Buoyancy = 0.0;
nameMap.set("Total Buoyancy", "_TotalBuoyancy");
_TotalBuoyancy = 0.0;
nameMap.set("Liquidity", "_Liquidity");
_Liquidity = 0.0;
nameMap.set("Allow Jumping?", "_AllowJumping");
_AllowJumping = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _TotalBuoyancy = asNumber(0);
propertyChanged("_TotalBuoyancy", _TotalBuoyancy);
        var liquidDivisor = 1.0;
        var multiplier = 1.0;
        if(event.otherActor.hasBehavior("Buoyant PM"))
{
            _TotalBuoyancy = asNumber((((_Buoyancy + event.otherActor.getValue("Buoyant PM", "_Buoyancy")) / 2) * getGravity().y));
propertyChanged("_TotalBuoyancy", _TotalBuoyancy);
            // adjust for how much of the other actor is in the liquid
var ft = scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop;
var fb = scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorBottom;
var fl = scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft;
var fr = scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorRight;

var topExposed = ft(event.thisActor) - ft(event.otherActor);
var botExposed = fb(event.otherActor) - fb(event.thisActor);
var leftExposed = fl(event.thisActor) - fl(event.otherActor);
var rightExposed = fr(event.otherActor) - fr(event.thisActor);

var a = 0;
var b = 0;
if (topExposed > 0) a += Std.int(topExposed);
if (botExposed > 0) a += Std.int(botExposed);
if (leftExposed > 0) b += Std.int(leftExposed);
if (rightExposed > 0) b += Std.int(rightExposed);

var h = event.otherActor.getHeight();
var w = event.otherActor.getWidth();
multiplier = ((w * h) - ((a * b) + ((h - a) * b) + ((w - b) * a))) / (w * h);

_TotalBuoyancy *= multiplier;
liquidDivisor = _Liquidity + ((1 - _Liquidity) * multiplier);
}

        if((_TotalBuoyancy < 0))
{
            event.otherActor.push(0, 1, -(_TotalBuoyancy));
}

        else if((_TotalBuoyancy > 0))
{
            event.otherActor.push(0, -1, _TotalBuoyancy);
}

        event.otherActor.setXVelocity((event.otherActor.getXVelocity() * liquidDivisor));
        event.otherActor.setYVelocity((event.otherActor.getYVelocity() * liquidDivisor));
        if(_AllowJumping)
{
            event.otherActor.setActorValue("In Liquid?", true);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}