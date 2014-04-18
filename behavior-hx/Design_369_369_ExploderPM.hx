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



class Design_369_369_ExploderPM extends ActorScript
{          	
	
public var _DistanceFromExplosion:Float;

public var _XDistanceFromExplosion:Float;

public var _YDistanceFromExplosion:Float;

public var _ExplodeRadius:Float;

public var _OtherExplodeRadius:Float;

public var _ExplodeDelay:Float;

public var _ImmuneToTypes:Array<Dynamic>;

public var _ExplodesOthers:Bool;

public var _CanExplode:Bool;
    

/* Params are:__Self __ExplodingActor */
public function _customBlock_CanExplode(__ExplodingActor:Actor):Bool
{
var __Self:Actor = actor;
        if((__ExplodingActor == actor))
{
            return false;
}

        if(!(_CanExplode))
{
            return false;
}

        if(!(__ExplodingActor.hasBehavior("Exploder PM")))
{
            return false;
}

        if(!(__ExplodingActor.getValue("Exploder PM", "_ExplodesOthers")))
{
            return false;
}

        if(((hasValue(_ImmuneToTypes) != false) && Utils.contains(_ImmuneToTypes, __ExplodingActor.getType())))
{
            return false;
}

        return true;
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Distance From Explosion", "_DistanceFromExplosion");
_DistanceFromExplosion = 0.0;
nameMap.set("X Distance From Explosion", "_XDistanceFromExplosion");
_XDistanceFromExplosion = 0.0;
nameMap.set("Y Distance From Explosion", "_YDistanceFromExplosion");
_YDistanceFromExplosion = 0.0;
nameMap.set("Explode Radius", "_ExplodeRadius");
_ExplodeRadius = 0.0;
nameMap.set("Other Explode Radius", "_OtherExplodeRadius");
_OtherExplodeRadius = 0.0;
nameMap.set("Explode Delay", "_ExplodeDelay");
_ExplodeDelay = 0.25;
nameMap.set("Immune To Types", "_ImmuneToTypes");
_ImmuneToTypes = [];
nameMap.set("Explodes Others?", "_ExplodesOthers");
_ExplodesOthers = true;
nameMap.set("Can Explode?", "_CanExplode");
_CanExplode = true;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenTypeGroupKilledListener(getActorGroup(12), function(eventActor:Actor, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(cast((actor.say("Exploder PM", "_customBlock_CanExplode", [eventActor])), Bool))
{
            _XDistanceFromExplosion = asNumber((actor.getXCenter() - eventActor.getXCenter()));
propertyChanged("_XDistanceFromExplosion", _XDistanceFromExplosion);
            _YDistanceFromExplosion = asNumber((actor.getYCenter() - eventActor.getYCenter()));
propertyChanged("_YDistanceFromExplosion", _YDistanceFromExplosion);
            _DistanceFromExplosion = asNumber(((_XDistanceFromExplosion * _XDistanceFromExplosion) + (_YDistanceFromExplosion * _YDistanceFromExplosion)));
propertyChanged("_DistanceFromExplosion", _DistanceFromExplosion);
            _OtherExplodeRadius = asNumber(eventActor.getValue("Exploder PM", "_ExplodeRadius"));
propertyChanged("_OtherExplodeRadius", _OtherExplodeRadius);
            if((_DistanceFromExplosion < ((_OtherExplodeRadius + _ExplodeRadius) * (_OtherExplodeRadius + _ExplodeRadius))))
{
                if((_ExplodeDelay > 0))
{
                    runLater(1000 * _ExplodeDelay, function(timeTask:TimedTask):Void {
                                actor.say("Default Kill Behaviour PM", "_customEvent_" + "Killed");
}, actor);
}

                else
{
                    actor.say("Default Kill Behaviour PM", "_customEvent_" + "Killed");
}

}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}