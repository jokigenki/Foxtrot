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



class ActorEvents_996 extends ActorScript
{          	
	
public var _ActorToControl:Actor;

public var _TouchId:Float;
    

/* Params are:__Self __X __Y */
public function _customBlock_TouchIsInside(__X:Float, __Y:Float):Bool
{
var __Self:Actor = actor;
        if(((__X >= actor.getX()) && (__X <= (actor.getX() + (actor.getWidth())))))
{
            if(((__Y >= actor.getY()) && (__Y <= (actor.getY() + (actor.getHeight())))))
{
                return true;
}

}

        return false;
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor To Control", "_ActorToControl");
nameMap.set("Touch Id", "_TouchId");
_TouchId = 0.0;

	}
	
	override public function init()
	{
		    addMultiTouchStartListener(function(event:TouchEvent, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _ActorToControl = actor.getActorValue("ActorToControl");
propertyChanged("_ActorToControl", _ActorToControl);
        if((hasValue(_ActorToControl) != false))
{
            if(cast((actor.say("ActorEvents_996", "_customBlock_TouchIsInside", [(event.stageX - Engine.screenOffsetX) / (Engine.screenScaleX * Engine.SCALE),(event.stageY - Engine.screenOffsetY) / (Engine.screenScaleY * Engine.SCALE)])), Bool))
{
                _TouchId = asNumber((event.touchPointID));
propertyChanged("_TouchId", _TouchId);
                if(!(_ActorToControl.getActorValue("Prevent Jumping")))
{
                    /* "Custom: Set \"Jump\" to <true> for <Actor To Control>" */
                    _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",true]);
}

                else
{
                    /* "Custom: Set \"UseObject\" to <true> for <Actor To Control>" */
                    _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["UseObject",true]);
}

}

}

}
});
    addMultiTouchMoveListener(function(event:TouchEvent, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((hasValue(_ActorToControl) != false))
{
            if(cast((actor.say("ActorEvents_996", "_customBlock_TouchIsInside", [(event.stageX - Engine.screenOffsetX) / (Engine.screenScaleX * Engine.SCALE),(event.stageY - Engine.screenOffsetY) / (Engine.screenScaleY * Engine.SCALE)])), Bool))
{
                _TouchId = asNumber((event.touchPointID));
propertyChanged("_TouchId", _TouchId);
                if(!(_ActorToControl.getActorValue("Prevent Jumping")))
{
                    /* "Custom: Set \"Jump\" to <true> for <Actor To Control>" */
                    _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",true]);
}

                else
{
                    /* "Custom: Set \"UseObject\" to <true> for <Actor To Control>" */
                    _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["UseObject",true]);
}

}

            else
{
                if(((event.touchPointID) == _TouchId))
{
                    _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",false]);
                    _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["UseObject",false]);
                    _TouchId = asNumber(-1);
propertyChanged("_TouchId", _TouchId);
}

}

}

}
});
    addMultiTouchEndListener(function(event:TouchEvent, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((hasValue(_ActorToControl) != false))
{
            if(((event.touchPointID) == _TouchId))
{
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",false]);
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["UseObject",false]);
                _TouchId = asNumber(-1);
propertyChanged("_TouchId", _TouchId);
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}