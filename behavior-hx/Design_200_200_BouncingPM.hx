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



class Design_200_200_BouncingPM extends ActorScript
{          	
	
public var _IsActive:Bool;

public var _JumpTime:Float;

public var _SFXNumber:Float;

public var _SFXName:String;
    public function _customEvent_Activated():Void
{
        _IsActive = true;
propertyChanged("_IsActive", _IsActive);
}

    public function _customEvent_Deactivated():Void
{
        _IsActive = false;
propertyChanged("_IsActive", _IsActive);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Jump Time", "_JumpTime");
_JumpTime = 0.25;
nameMap.set("SFX Number", "_SFXNumber");
_SFXNumber = 1;
nameMap.set("SFX Name", "_SFXName");
_SFXName = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_IsActive)
{
            if((asBoolean(actor.getActorValue("On Ground?")) && !(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Jump"])), Bool))))
{
                sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_SFXName,_SFXNumber]);
                actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",true]);
                runLater(1000 * _JumpTime, function(timeTask:TimedTask):Void {
                            actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",false]);
}, actor);
}

}

        else
{
            actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",false]);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}