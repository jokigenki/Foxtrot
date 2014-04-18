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

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_61_61_HorizontalOscillationPM extends ActorScript
{          	
	
public var _MotionRegion:Region;

public var _CurrentVelocity:Float;

public var _XSpeed:Float;

public var _IsActive:Bool;

public var _HasSwitchedDirection:Bool;

public var _SFXName:String;
    public function _customEvent_Activated():Void
{
        _IsActive = true;
propertyChanged("_IsActive", _IsActive);
        if(((hasValue(_SFXName) != false) && !(_SFXName == "")))
{
            sayToScene("Sound Manager PM", "_customBlock_StopSceneSoundForActor", [_SFXName,getCurrentSceneName(),actor]);
            sayToScene("Sound Manager PM", "_customBlock_LoopSceneSoundForActor", [_SFXName,getCurrentSceneName(),actor]);
}

}

    public function _customEvent_Deactivated():Void
{
        _IsActive = false;
propertyChanged("_IsActive", _IsActive);
        if(((hasValue(_SFXName) != false) && !(_SFXName == "")))
{
            sayToScene("Sound Manager PM", "_customBlock_StopSceneSoundForActor", [_SFXName,getCurrentSceneName(),actor]);
}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Motion Region", "_MotionRegion");
nameMap.set("Current Velocity", "_CurrentVelocity");
_CurrentVelocity = 0.0;
nameMap.set("X Speed", "_XSpeed");
_XSpeed = 0.0;
nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Has Switched Direction?", "_HasSwitchedDirection");
_HasSwitchedDirection = false;
nameMap.set("SFX Name", "_SFXName");
_SFXName = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _CurrentVelocity = asNumber(_XSpeed);
propertyChanged("_CurrentVelocity", _CurrentVelocity);
        _HasSwitchedDirection = false;
propertyChanged("_HasSwitchedDirection", _HasSwitchedDirection);
        if(_IsActive)
{
            actor.setXVelocity(_CurrentVelocity);
            if(((hasValue(_SFXName) != false) && !(_SFXName == "")))
{
                sayToScene("Sound Manager PM", "_customBlock_LoopSceneSoundForActor", [_SFXName,getCurrentSceneName(),actor]);
}

}

    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(!(_IsActive))
{
            actor.setXVelocity(0);
            return;
}

        if(((actor.getX() < 0) || (actor.getX() > getSceneWidth())))
{
            _CurrentVelocity = asNumber(-(_CurrentVelocity));
propertyChanged("_CurrentVelocity", _CurrentVelocity);
            _HasSwitchedDirection = true;
propertyChanged("_HasSwitchedDirection", _HasSwitchedDirection);
}

        else if(isInRegion(actor, _MotionRegion))
{
            _HasSwitchedDirection = false;
propertyChanged("_HasSwitchedDirection", _HasSwitchedDirection);
}

        else if(!(_HasSwitchedDirection))
{
            _CurrentVelocity = asNumber(-(_CurrentVelocity));
propertyChanged("_CurrentVelocity", _CurrentVelocity);
            _HasSwitchedDirection = true;
propertyChanged("_HasSwitchedDirection", _HasSwitchedDirection);
}

        actor.setXVelocity(_CurrentVelocity);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}