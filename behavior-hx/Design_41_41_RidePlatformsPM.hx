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



class Design_41_41_RidePlatformsPM extends ActorScript
{          	
	
public var _IsOnPlatform:Bool;

public var _Platform:Actor;

public var _XPositionOnPlatform:Float;

public var _YPositionOnPlatform:Float;

public var _WasOnPlatform:Bool;

public var _PlatformGroup:Group;

public var _HitTerrain:Bool;
    

/* Params are: __PreventValue */
public function _customBlock_SetAnimationPrevention(__PreventValue:Bool):Void
{
var __Self:Actor = actor;
        if(actor.hasBehavior("Falling"))
{
            actor.setValue("PM Falling", "_PreventFalling", __PreventValue);
}

        if(actor.hasBehavior("Landing"))
{
            actor.setValue("PM Landing", "_PreventLanding", __PreventValue);
}

}
    

/* Params are: */
public function _customBlock_UpdatePositionOnPlatform():Void
{
var __Self:Actor = actor;
        _XPositionOnPlatform = asNumber((_Platform.getX() - actor.getX()));
propertyChanged("_XPositionOnPlatform", _XPositionOnPlatform);
        _YPositionOnPlatform = asNumber((_Platform.getY() - actor.getY()));
propertyChanged("_YPositionOnPlatform", _YPositionOnPlatform);
}
    

/* Params are: */
public function _customBlock_UpdatePlayerPosition():Void
{
var __Self:Actor = actor;
        actor.setX((_Platform.getX() - _XPositionOnPlatform));
        actor.setY(((_Platform.getY() - _YPositionOnPlatform) + 1));
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Is On Platform?", "_IsOnPlatform");
_IsOnPlatform = false;
nameMap.set("Platform", "_Platform");
nameMap.set("X Position On Platform", "_XPositionOnPlatform");
_XPositionOnPlatform = 0.0;
nameMap.set("Y Position On Platform", "_YPositionOnPlatform");
_YPositionOnPlatform = 0.0;
nameMap.set("Was On Platform?", "_WasOnPlatform");
_WasOnPlatform = false;
nameMap.set("Platform Group", "_PlatformGroup");
nameMap.set("Hit Terrain?", "_HitTerrain");
_HitTerrain = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((event.thisCollidedWithTerrain || event.thisCollidedWithTile))
{
            _HitTerrain = true;
propertyChanged("_HitTerrain", _HitTerrain);
            _IsOnPlatform = false;
propertyChanged("_IsOnPlatform", _IsOnPlatform);
            _WasOnPlatform = false;
propertyChanged("_WasOnPlatform", _WasOnPlatform);
}

        else if((event.otherActor.getGroup() == _PlatformGroup))
{
            if(event.otherFromTop)
{
                if(((actor.getXCenter() > cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorRight(event.otherActor)), Float)) || (actor.getXCenter() < cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft(event.otherActor)), Float))))
{
                    return;
}

                _IsOnPlatform = true;
propertyChanged("_IsOnPlatform", _IsOnPlatform);
                _Platform = event.otherActor;
propertyChanged("_Platform", _Platform);
                if(!(_WasOnPlatform))
{
                    /* "Custom: update position on platform" */
                    actor.say("Ride Platforms PM", "_customBlock_UpdatePositionOnPlatform");
}

                _WasOnPlatform = true;
propertyChanged("_WasOnPlatform", _WasOnPlatform);
                actor.setActorValue("On Platform?", true);
}

}

}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        /* "Custom: Is \"Jump\" on for Self" */
        if(!(_HitTerrain))
{
            if(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Jump"])), Bool))
{
                _IsOnPlatform = false;
propertyChanged("_IsOnPlatform", _IsOnPlatform);
                _WasOnPlatform = false;
propertyChanged("_WasOnPlatform", _WasOnPlatform);
                /* "set prevent animations to <false>" */
                actor.say("Ride Platforms PM", "_customBlock_SetAnimationPrevention", [false]);
                return;
}

            if(_IsOnPlatform)
{
                actor.setActorValue("On Ground?", true);
                /* "Custom: Is \"Left\" on for Self, Is \"Right\" on for Self" */
                if((!(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Left"])), Bool)) && !(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Right"])), Bool))))
{
                    /* "Custom: update player position, set prevent animations to <true>" */
                    actor.say("Ride Platforms PM", "_customBlock_UpdatePlayerPosition");
                    actor.say("Ride Platforms PM", "_customBlock_SetAnimationPrevention", [true]);
}

                else if(_WasOnPlatform)
{
                    /* "Custom: update position on platform" */
                    actor.say("Ride Platforms PM", "_customBlock_UpdatePositionOnPlatform");
}

}

            else
{
                if(_WasOnPlatform)
{
                    /* "Custom: update player position" */
                    actor.setActorValue("On Ground?", false);
                    actor.say("Ride Platforms PM", "_customBlock_UpdatePlayerPosition");
                    runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                                if(!(_IsOnPlatform))
{
                                    _WasOnPlatform = false;
propertyChanged("_WasOnPlatform", _WasOnPlatform);
                                    /* "Custom: set prevent animations to <false>" */
                                    actor.say("Ride Platforms PM", "_customBlock_SetAnimationPrevention", [false]);
                                    actor.setActorValue("On Platform?", false);
}

}, actor);
}

}

}

        _HitTerrain = false;
propertyChanged("_HitTerrain", _HitTerrain);
        _IsOnPlatform = false;
propertyChanged("_IsOnPlatform", _IsOnPlatform);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}