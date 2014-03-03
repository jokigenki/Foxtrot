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



class Design_43_43_ControlAdapterPM extends ActorScript
{          	
	
public var _SwitchedOn:Array<Dynamic>;

public var _ActiveControls:Array<Dynamic>;

public var _SwitchedOff:Array<Dynamic>;

public var _OldValue:Bool;
    

/* Params are:__Self __ControlName */
public function _customBlock_ControlIsOn(__ControlName:String):Bool
{
var __Self:Actor = actor;
        return Utils.contains(_ActiveControls, __ControlName);
}
    

/* Params are:__Self __ControlName */
public function _customBlock_ControlSwitchedOn(__ControlName:String):Bool
{
var __Self:Actor = actor;
        return Utils.contains(_SwitchedOn, __ControlName);
}
    

/* Params are:__Self __ControlName */
public function _customBlock_ControlWasSwitchedOff(__ControlName:String):Bool
{
var __Self:Actor = actor;
        return Utils.contains(_SwitchedOff, __ControlName);
}
    

/* Params are:__Self __ControlName __Value */
public function _customBlock_SetIsOn(__ControlName:String, __Value:Bool):Void
{
var __Self:Actor = actor;
        /* "Custom: Is \"Control Name\" on for Self" */
        _OldValue = cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", [__ControlName])), Bool);
propertyChanged("_OldValue", _OldValue);
        if((_OldValue == __Value))
{
            return;
}

        if(__Value)
{
            _ActiveControls.push(__ControlName);
            _SwitchedOn.push(__ControlName);
}

        else
{
            _ActiveControls.remove(__ControlName);
            _SwitchedOff.push(__ControlName);
}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Switched On", "_SwitchedOn");
_SwitchedOn = [];
nameMap.set("Active Controls", "_ActiveControls");
_ActiveControls = [];
nameMap.set("Switched Off", "_SwitchedOff");
_SwitchedOff = [];
nameMap.set("Old Value", "_OldValue");
_OldValue = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((_SwitchedOn.length > 0))
{
            Utils.clear(_SwitchedOn);
}

        if((_SwitchedOff.length > 0))
{
            Utils.clear(_SwitchedOff);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}