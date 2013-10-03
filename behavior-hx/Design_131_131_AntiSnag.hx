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



class Design_131_131_AntiSnag extends ActorScript
{          	
	
public var _AntisnagValue:Float;

public var _HitActor:Bool;

public var _HitTile:Bool;

public var _TileCollisionX:Float;

public var _ActorCollisionX:Float;

public var _IncludedActors:Array<Dynamic>;

public var _ActorCollisionY:Float;

public var _TileCollisionY:Float;

public var _Hit2ndActor:Bool;

public var _1stActor:Actor;

public var _2ndActor:Actor;
    

/* Params are: */
public function _customBlock_HasHitTwo():Bool
{
var __Self:Actor = actor;
        return (_HitActor && _HitTile) ||
	  (_HitActor && _Hit2ndActor);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Antisnag Value", "_AntisnagValue");
_AntisnagValue = 0.0;
nameMap.set("Hit Actor", "_HitActor");
_HitActor = false;
nameMap.set("Hit Tile", "_HitTile");
_HitTile = false;
nameMap.set("Tile Collision X", "_TileCollisionX");
_TileCollisionX = 0.0;
nameMap.set("Actor Collision X", "_ActorCollisionX");
_ActorCollisionX = 0.0;
nameMap.set("Included Actors", "_IncludedActors");
_IncludedActors = [];
nameMap.set("Actor Collision Y", "_ActorCollisionY");
_ActorCollisionY = 0.0;
nameMap.set("Tile Collision Y", "_TileCollisionY");
_TileCollisionY = 0.0;
nameMap.set("Hit 2nd Actor", "_Hit2ndActor");
_Hit2ndActor = false;
nameMap.set("1st Actor", "_1stActor");
nameMap.set("2nd Actor", "_2ndActor");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if((_AntisnagValue == 0))
{
            _AntisnagValue = asNumber(1);
propertyChanged("_AntisnagValue", _AntisnagValue);
}

    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(event.thisCollidedWithActor)
{
            if(!(Utils.contains(_IncludedActors, ("" + event.otherActor.getType()))))
{
                return;
}

            for(point in event.points)
{
                _ActorCollisionX = asNumber(Math.round(Engine.toPixelUnits(point.x)));
propertyChanged("_ActorCollisionX", _ActorCollisionX);
                _ActorCollisionY = asNumber(Math.round(Engine.toPixelUnits(point.y)));
propertyChanged("_ActorCollisionY", _ActorCollisionY);
}

            if((_HitActor == false))
{
                _HitActor = true;
propertyChanged("_HitActor", _HitActor);
}

            else
{
                _Hit2ndActor = true;
propertyChanged("_Hit2ndActor", _Hit2ndActor);
}

}

        if(event.thisCollidedWithTile)
{
            for(point in event.points)
{
                _TileCollisionX = asNumber(Math.round(Engine.toPixelUnits(point.x)));
propertyChanged("_TileCollisionX", _TileCollisionX);
                _TileCollisionY = asNumber(Math.round(Engine.toPixelUnits(point.y)));
propertyChanged("_TileCollisionY", _TileCollisionY);
}

            _HitTile = true;
propertyChanged("_HitTile", _HitTile);
}

        if(cast((actor.say("AntiSnag", "_customBlock_HasHitTwo")), Bool))
{
            if(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Left"])), Bool))
{
                event.thisActor.setX((event.thisActor.getX() - _AntisnagValue));
}

            else if(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Right"])), Bool))
{
                event.thisActor.setX((event.thisActor.getX() + _AntisnagValue));
}

            if((actor.getYVelocity() < 0))
{
                event.thisActor.setY((event.thisActor.getY() - _AntisnagValue));
}

            else if((actor.getYVelocity() > 0))
{
                event.thisActor.setY((event.thisActor.getY() + _AntisnagValue));
}

}

}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _1stActor = null;
_2ndActor = null;
propertyChanged("_1stActor", _1stActor);
propertyChanged("_2ndActor", _2ndActor);
_HitActor = false;
_Hit2ndActor = false;
_HitTile = false;
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}