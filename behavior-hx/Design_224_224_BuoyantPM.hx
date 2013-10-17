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



class Design_224_224_BuoyantPM extends ActorScript
{          	
	
public var _Buoyancy:Float;

public var _TotalBuoyancy:Float;

public var _Liquidity:Float;

public var _OtherBuoyancy:Float;

public var _HasHit:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Buoyancy", "_Buoyancy");
_Buoyancy = 0.0;
nameMap.set("Total Buoyancy", "_TotalBuoyancy");
_TotalBuoyancy = 0.0;
nameMap.set("Liquidity", "_Liquidity");
_Liquidity = 0.0;
nameMap.set("Other Buoyancy", "_OtherBuoyancy");
_OtherBuoyancy = 0.0;
nameMap.set("Has Hit?", "_HasHit");
_HasHit = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        actor.setActorValue("In Liquid?", _HasHit);
        _HasHit = false;
propertyChanged("_HasHit", _HasHit);
}
});
    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(!(event.otherActor.hasBehavior("Liquid PM")))
{
            return;
}

        var liquidDivisor = 1.0;
        var multiplier = 1.0;
        _OtherBuoyancy = asNumber(asNumber(event.otherActor.getValue("Liquid PM", "_Buoyancy")));
propertyChanged("_OtherBuoyancy", _OtherBuoyancy);
        _Liquidity = asNumber(asNumber(event.otherActor.getValue("Liquid PM", "_Liquidity")));
propertyChanged("_Liquidity", _Liquidity);
        _TotalBuoyancy = asNumber((((_OtherBuoyancy + _Buoyancy) / 2) * getGravity().y));
propertyChanged("_TotalBuoyancy", _TotalBuoyancy);
        // adjust for how much of the other actor is in the liquid
var ft = scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop;
var fb = scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorBottom;
var fl = scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft;
var fr = scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorRight;

var topExposed = ft(event.otherActor) - ft(event.thisActor);
var botExposed = fb(event.thisActor) - fb(event.otherActor);
var leftExposed = fl(event.otherActor) - fl(event.thisActor);
var rightExposed = fr(event.thisActor) - fr(event.otherActor);

var a = 0;
var b = 0;
if (topExposed > 0) a += Std.int(topExposed);
if (botExposed > 0) a += Std.int(botExposed);
if (leftExposed > 0) b += Std.int(leftExposed);
if (rightExposed > 0) b += Std.int(rightExposed);

var h = event.thisActor.getHeight();
var w = event.thisActor.getWidth();
multiplier = ((w * h) - ((a * b) + ((h - a) * b) + ((w - b) * a))) / (w * h);

_TotalBuoyancy *= multiplier;
liquidDivisor = _Liquidity + ((1 - _Liquidity) * multiplier);
        if((_TotalBuoyancy < 0))
{
            actor.push(0, 1, -(_TotalBuoyancy));
}

        else if((_TotalBuoyancy > 0))
{
            actor.push(0, -1, _TotalBuoyancy);
}

        actor.setXVelocity(((actor.getXVelocity() * liquidDivisor) * 0.95));
        actor.setYVelocity((actor.getYVelocity() * liquidDivisor));
        if(event.otherActor.getValue("Liquid PM", "_AllowSwimming"))
{
            _HasHit = true;
propertyChanged("_HasHit", _HasHit);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}