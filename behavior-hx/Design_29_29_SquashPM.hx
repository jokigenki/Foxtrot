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



class Design_29_29_SquashPM extends ActorScript
{          	
	
public var _KillBehaviour:String;

public var _HitTopY:Float;

public var _HitBottomY:Float;

public var _HitLeftX:Float;

public var _HitRightX:Float;

public var _HitTop:Bool;

public var _HitBottom:Bool;

public var _HitRight:Bool;

public var _HitLeft:Bool;

public var _HorizontalSquashThreshold:Float;

public var _VerticalSquashThreshold:Float;

public var _IsSquashing:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Kill Behaviour", "_KillBehaviour");
_KillBehaviour = "";
nameMap.set("Hit Top Y", "_HitTopY");
_HitTopY = 0.0;
nameMap.set("Hit Bottom Y", "_HitBottomY");
_HitBottomY = 0.0;
nameMap.set("Hit Left X", "_HitLeftX");
_HitLeftX = 0.0;
nameMap.set("Hit Right X", "_HitRightX");
_HitRightX = 0.0;
nameMap.set("Hit Top?", "_HitTop");
_HitTop = false;
nameMap.set("Actor", "actor");
nameMap.set("Hit Bottom?", "_HitBottom");
_HitBottom = false;
nameMap.set("Hit Right?", "_HitRight");
_HitRight = false;
nameMap.set("Hit Left?", "_HitLeft");
_HitLeft = false;
nameMap.set("Horizontal Squash Threshold", "_HorizontalSquashThreshold");
_HorizontalSquashThreshold = 0.0;
nameMap.set("Vertical Squash Threshold", "_VerticalSquashThreshold");
_VerticalSquashThreshold = 0.0;
nameMap.set("Is Squashing?", "_IsSquashing");
_IsSquashing = false;

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        var isActor = event.thisCollidedWithActor;
        if((!(isActor) || event.otherActor.hasBehavior("Squasher PM")))
{
            var i = 0;
            if((!(isActor) || asBoolean(event.otherActor.getValue("Squasher PM", "_SquashVertically"))))
{
                if(event.thisFromTop)
{
                    _HitTop = true;
propertyChanged("_HitTop", _HitTop);
                    if(isActor)
{
                        _HitTopY = asNumber(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorBottom(event.otherActor)), Float));
propertyChanged("_HitTopY", _HitTopY);
}

                    else
{
                        for(point in event.points)
{
                            _HitTopY = asNumber(Math.round(Engine.toPixelUnits(point.y)));
propertyChanged("_HitTopY", _HitTopY);
}

}

}

                if(event.thisFromBottom)
{
                    _HitBottom = true;
propertyChanged("_HitBottom", _HitBottom);
                    if(isActor)
{
                        _HitBottomY = asNumber(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop(event.otherActor)), Float));
propertyChanged("_HitBottomY", _HitBottomY);
}

                    else
{
                        for(point in event.points)
{
                            _HitBottomY = asNumber(Math.round(Engine.toPixelUnits(point.y)));
propertyChanged("_HitBottomY", _HitBottomY);
}

}

}

}

            if((!(isActor) || asBoolean(event.otherActor.getValue("Squasher PM", "_SquashHorizontally"))))
{
                if(event.thisFromLeft)
{
                    _HitLeft = true;
propertyChanged("_HitLeft", _HitLeft);
                    if(isActor)
{
                        _HitLeftX = asNumber(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorRight(event.otherActor)), Float));
propertyChanged("_HitLeftX", _HitLeftX);
}

                    else
{
                        for(point in event.points)
{
                            _HitLeftX = asNumber(Math.round(Engine.toPixelUnits(point.x)));
propertyChanged("_HitLeftX", _HitLeftX);
}

}

}

                if(event.thisFromRight)
{
                    _HitRight = true;
propertyChanged("_HitRight", _HitRight);
                    if(isActor)
{
                        _HitRightX = asNumber(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft(event.otherActor)), Float));
propertyChanged("_HitRightX", _HitRightX);
}

                    else
{
                        for(point in event.points)
{
                            _HitRightX = asNumber(Math.round(Engine.toPixelUnits(point.x)));
propertyChanged("_HitRightX", _HitRightX);
}

}

}

}

}

}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((_HitTop && _HitBottom))
{
            _IsSquashing = true;
propertyChanged("_IsSquashing", _IsSquashing);
            if(((_HitBottomY - _HitTopY) < ((actor.getHeight()) - _VerticalSquashThreshold)))
{
                scripts.Design_27_27_ActorExtrasPM._customBlock_TriggerKilledInActor(actor,_KillBehaviour,randomInt(Math.floor(-1), Math.floor(1)),-2);
}

}

        if((_HitLeft && _HitRight))
{
            _IsSquashing = true;
propertyChanged("_IsSquashing", _IsSquashing);
            if(((_HitRightX - _HitLeftX) < ((actor.getWidth()) - _HorizontalSquashThreshold)))
{
                scripts.Design_27_27_ActorExtrasPM._customBlock_TriggerKilledInActor(actor,_KillBehaviour,randomInt(Math.floor(-1), Math.floor(1)),-2);
}

}

        _HitBottom = false;
propertyChanged("_HitBottom", _HitBottom);
        _HitTop = false;
propertyChanged("_HitTop", _HitTop);
        _HitLeft = false;
propertyChanged("_HitLeft", _HitLeft);
        _HitRight = false;
propertyChanged("_HitRight", _HitRight);
        _IsSquashing = false;
propertyChanged("_IsSquashing", _IsSquashing);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}