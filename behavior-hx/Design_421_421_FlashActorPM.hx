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



class Design_421_421_FlashActorPM extends ActorScript
{          	
	
public var _NumberOfFlashes:Float;

public var _LengthOfGap:Float;

public var _LengthOfFlash:Float;

public var _FlashCount:Float;

public var _IsActive:Bool;

public var _FlashStrength:Float;
    public function _customEvent_Flash():Void
{
        trace("" + "FLASH!");
        _IsActive = true;
propertyChanged("_IsActive", _IsActive);
        _FlashCount = asNumber(0);
propertyChanged("_FlashCount", _FlashCount);
        actor.say("Flash Actor PM", "_customBlock_AddFlash");
}

    

/* Params are:__Self */
public function _customBlock_AddFlash():Void
{
var __Self:Actor = actor;
        __Self.setFilter([createBrightnessFilter(_FlashStrength)]);
        runLater(1000 * _LengthOfFlash, function(timeTask:TimedTask):Void {
                    __Self.say("Flash Actor PM", "_customBlock_RemoveFlash");
}, actor);
}
    

/* Params are:__Self */
public function _customBlock_RemoveFlash():Void
{
var __Self:Actor = actor;
        __Self.clearFilters();
        _FlashCount += 1;
propertyChanged("_FlashCount", _FlashCount);
        if(((_FlashCount < _NumberOfFlashes) && _IsActive))
{
            runLater(1000 * _LengthOfGap, function(timeTask:TimedTask):Void {
                        __Self.say("Flash Actor PM", "_customBlock_AddFlash");
}, actor);
}

        else
{
            _IsActive = false;
propertyChanged("_IsActive", _IsActive);
}

}
    public function _customEvent_Activated():Void
{
        _FlashCount = asNumber(0);
propertyChanged("_FlashCount", _FlashCount);
        actor.say("Flash Actor PM", "_customBlock_AddFlash");
}

    public function _customEvent_Deactivated():Void
{
        _IsActive = false;
propertyChanged("_IsActive", _IsActive);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Number Of Flashes", "_NumberOfFlashes");
_NumberOfFlashes = 3.0;
nameMap.set("Length Of Gap", "_LengthOfGap");
_LengthOfGap = 0.1;
nameMap.set("Length Of Flash", "_LengthOfFlash");
_LengthOfFlash = 0.1;
nameMap.set("Flash Count", "_FlashCount");
_FlashCount = 0.0;
nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Flash Strength (%)", "_FlashStrength");
_FlashStrength = 50.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}