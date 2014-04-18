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



class Design_259_259_ParticleEmitterPM extends ActorScript
{          	
	
public var _IsActive:Bool;

public var _NumberofParticles:Float;

public var _ParticleType:ActorType;

public var _ParticleSpacingTime:Float;

public var _InitialParticleDelay:Float;

public var _ParticleCount:Float;

public var _DirectionMin:Float;

public var _DirectionMax:Float;

public var _ForceMin:Float;

public var _ForceMax:Float;
    public function _customEvent_Activated():Void
{
        if(!(_IsActive))
{
            _IsActive = true;
propertyChanged("_IsActive", _IsActive);
}

}

    public function _customEvent_Deactivated():Void
{
        _IsActive = false;
propertyChanged("_IsActive", _IsActive);
}

    

/* Params are:__Self __Value */
public function _customBlock_ChangeParticleCount(__Value:Float):Void
{
var __Self:Actor = actor;
        _ParticleCount = asNumber((_ParticleCount + __Value));
propertyChanged("_ParticleCount", _ParticleCount);
}
    

/* Params are:__Self */
public function _customBlock_ResetParticleCount():Void
{
var __Self:Actor = actor;
        _ParticleCount = asNumber(0);
propertyChanged("_ParticleCount", _ParticleCount);
}
    

/* Params are:__Self */
public function _customBlock_CreateNewParticle():Void
{
var __Self:Actor = actor;
        createRecycledActor(_ParticleType, __Self.getX(), __Self.getY(), Script.FRONT);
        getLastCreatedActor().moveToLayer(__Self.getLayerID());
        getLastCreatedActor().applyImpulseInDirection(randomInt(Math.floor(_DirectionMin), Math.floor(_DirectionMax)), randomInt(Math.floor(_ForceMin), Math.floor(_ForceMax)));
        _ParticleCount += 1;
propertyChanged("_ParticleCount", _ParticleCount);
}
    

/* Params are:__Self */
public function _customBlock_GetParticleCount():Float
{
var __Self:Actor = actor;
        return _ParticleCount;
}
    

/* Params are:__Self */
public function _customBlock_StartParticles():Void
{
var __Self:Actor = actor;
        if(!(_IsActive))
{
            return;
}

        __Self.say("Particle Emitter PM", "_customBlock_CreateNewParticle");
        runPeriodically(1000 * _ParticleSpacingTime, function(timeTask:TimedTask):Void {
                    if((_ParticleCount >= _NumberofParticles))
{
                        timeTask.repeats = false;
return;
}

                    __Self.say("Particle Emitter PM", "_customBlock_CreateNewParticle");
}, actor);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Number of Particles", "_NumberofParticles");
_NumberofParticles = 0.0;
nameMap.set("Particle Type", "_ParticleType");
nameMap.set("Particle Spacing Time", "_ParticleSpacingTime");
_ParticleSpacingTime = 0.05;
nameMap.set("Initial Particle Delay", "_InitialParticleDelay");
_InitialParticleDelay = 0.0;
nameMap.set("Particle Count", "_ParticleCount");
_ParticleCount = 0.0;
nameMap.set("Direction Min", "_DirectionMin");
_DirectionMin = 0.0;
nameMap.set("Direction Max", "_DirectionMax");
_DirectionMax = 0.0;
nameMap.set("Force Min", "_ForceMin");
_ForceMin = 0.0;
nameMap.set("Force Max", "_ForceMax");
_ForceMax = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _ParticleCount = asNumber(0);
propertyChanged("_ParticleCount", _ParticleCount);
        if(_IsActive)
{
            if((_InitialParticleDelay == 0))
{
                actor.say("Particle Emitter PM", "_customBlock_StartParticles");
}

            else
{
                runLater(1000 * _InitialParticleDelay, function(timeTask:TimedTask):Void {
                            actor.say("Particle Emitter PM", "_customBlock_StartParticles");
}, actor);
}

}

    addPropertyChangeListener("_IsActive", null, function(property:Dynamic, list:Array<Dynamic>):Void {
if(wrapper.enabled && cast(property, Bool) == true){
        if((_InitialParticleDelay == 0))
{
            actor.say("Particle Emitter PM", "_customBlock_StartParticles");
}

        else
{
            runLater(1000 * _InitialParticleDelay, function(timeTask:TimedTask):Void {
                        actor.say("Particle Emitter PM", "_customBlock_StartParticles");
}, actor);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}