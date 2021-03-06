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



class Design_128_128_ConveyorPM extends ActorScript
{          	
	
public var _Direction:Float;

public var _FramesPerPixel:Float;

public var _FrameCount:Float;

public var _Offset:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Direction", "_Direction");
_Direction = 0.0;
nameMap.set("Frames Per Pixel", "_FramesPerPixel");
_FramesPerPixel = 0.0;
nameMap.set("Frame Count", "_FrameCount");
_FrameCount = 0.0;
nameMap.set("Offset", "_Offset");
_Offset = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(((_FramesPerPixel <= 1) || (_FrameCount >= _FramesPerPixel)))
{
            _FrameCount = asNumber(0);
propertyChanged("_FrameCount", _FrameCount);
            if(event.thisFromTop)
{
                if(((actor.getXCenter() > cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorRight(actor)), Float)) || (actor.getXCenter() < cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft(actor)), Float))))
{
                    return;
}

                event.otherActor.setX((event.otherActor.getX() + _Offset));
}

}

        else
{
            _FrameCount += 1;
propertyChanged("_FrameCount", _FrameCount);
}

}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((_Direction < 0))
{
            actor.setAnimation("" + "Left");
}

        else
{
            actor.setAnimation("" + "Right");
}

        if((_Direction == 0))
{
            _FramesPerPixel = asNumber(0);
propertyChanged("_FramesPerPixel", _FramesPerPixel);
            return;
}

        _FramesPerPixel = asNumber((1 / Math.abs(_Direction)));
propertyChanged("_FramesPerPixel", _FramesPerPixel);
        if(((_Direction < 1) && (_Direction > 0)))
{
            _Offset = asNumber(1);
propertyChanged("_Offset", _Offset);
}

        else if(((_Direction < 0) && (_Direction > -1)))
{
            _Offset = asNumber(-1);
propertyChanged("_Offset", _Offset);
}

        else
{
            _Offset = asNumber(_Direction);
propertyChanged("_Offset", _Offset);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}