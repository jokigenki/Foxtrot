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



class Design_409_409_ChuckStuffPM extends ActorScript
{          	
	
public var _StuffToChuck:Array<Dynamic>;

public var _ActorTypeNameToChuck:String;

public var _ThrowXMin:Float;

public var _ThrowXMax:Float;

public var _ThrowYMin:Float;

public var _ThrowYMax:Float;

public var _ThrowForce:Float;

public var _ChuckAnim:String;

public var _IsAnimating:Bool;

public var _IdleAnim:String;

public var _ChuckDelay:Float;
    public function _customEvent_Deactivated():Void
{
        if((_ChuckDelay > 0))
{
            runLater(1000 * _ChuckDelay, function(timeTask:TimedTask):Void {
                        actor.say("Chuck Stuff PM", "_customBlock_Chuck");
}, actor);
}

        else
{
            actor.say("Chuck Stuff PM", "_customBlock_Chuck");
}

}

    

/* Params are: */
public function _customBlock_Chuck():Void
{
var __Self:Actor = actor;
        _ActorTypeNameToChuck = (scripts.Design_207_207_StencylExtrasPM._customBlock_GetRandomItemFromList(_StuffToChuck));
propertyChanged("_ActorTypeNameToChuck", _ActorTypeNameToChuck);
        createRecycledActor(getActorTypeByName("" + _ActorTypeNameToChuck), actor.getXCenter(), (actor.getYCenter() + 10), Script.FRONT);
        getLastCreatedActor().applyImpulse(randomInt(Math.floor(_ThrowXMin), Math.floor(_ThrowXMax)), randomInt(Math.floor(_ThrowYMin), Math.floor(_ThrowYMax)), _ThrowForce);
        if(!(actor.getAnimation() == _ChuckAnim))
{
            _IsAnimating = true;
propertyChanged("_IsAnimating", _IsAnimating);
            actor.setAnimation("" + _ChuckAnim);
}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Stuff To Chuck", "_StuffToChuck");
_StuffToChuck = [];
nameMap.set("Actor Type Name To Chuck", "_ActorTypeNameToChuck");
_ActorTypeNameToChuck = "";
nameMap.set("Throw X Min", "_ThrowXMin");
_ThrowXMin = 0.0;
nameMap.set("Throw X Max", "_ThrowXMax");
_ThrowXMax = 0.0;
nameMap.set("Throw Y Min", "_ThrowYMin");
_ThrowYMin = 0.0;
nameMap.set("Throw Y Max", "_ThrowYMax");
_ThrowYMax = 0.0;
nameMap.set("Throw Force", "_ThrowForce");
_ThrowForce = 0.0;
nameMap.set("Chuck Anim", "_ChuckAnim");
nameMap.set("Is Animating?", "_IsAnimating");
_IsAnimating = false;
nameMap.set("Idle Anim", "_IdleAnim");
nameMap.set("Chuck Delay", "_ChuckDelay");
_ChuckDelay = 0.5;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((_IsAnimating && !(actor.isAnimationPlaying())))
{
            _IsAnimating = false;
propertyChanged("_IsAnimating", _IsAnimating);
            actor.setAnimation("" + _IdleAnim);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}