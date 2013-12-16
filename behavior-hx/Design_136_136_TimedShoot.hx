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



class Design_136_136_TimedShoot extends ActorScript
{          	
	
public var _InitialDelay:Float;

public var _TimeBetweenShots:Float;

public var _ProjectileType:ActorType;

public var _OriginX:Float;

public var _OriginY:Float;

public var _FireForce:Float;

public var _DirX:Float;

public var _DirY:Float;

public var _IsActive:Bool;

public var _IdleAnimation:String;

public var _ShootAnimation:String;

public var _ResetToIdle:Bool;

public var _ProjectileDelayAfterShootAnimationStarts:Float;

public var _SFXName:String;

public var _SFXCount:Float;
    public function _customEvent_ShootProjectile():Void
{
        if(!(_IsActive))
{
            return;
}

        if(!(actor.getAnimation() == _ShootAnimation))
{
            actor.setAnimation("" + _ShootAnimation);
}

        if((_ProjectileDelayAfterShootAnimationStarts > 0))
{
            runLater(1000 * _ProjectileDelayAfterShootAnimationStarts, function(timeTask:TimedTask):Void {
                        actor.say("Timed Shoot PM", "_customEvent_" + "CreateProjectile");
}, actor);
}

        else
{
            actor.say("Timed Shoot PM", "_customEvent_" + "CreateProjectile");
}

        runLater(1000 * _TimeBetweenShots, function(timeTask:TimedTask):Void {
                    actor.shout("_customEvent_" + "ShootProjectile");
}, actor);
}

    public function _customEvent_CreateProjectile():Void
{
        sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_SFXName,_SFXCount]);
        createRecycledActor(_ProjectileType, (actor.getX() + _OriginX), (actor.getY() + _OriginY), Script.BACK);
        if((_DirX > 0))
{
            getLastCreatedActor().setAnimation("" + ("" + "right"));
}

        else
{
            getLastCreatedActor().setAnimation("" + ("" + "left"));
}

        getLastCreatedActor().push(_DirX, _DirY, _FireForce);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Initial Delay", "_InitialDelay");
_InitialDelay = 0.0;
nameMap.set("Time Between Shots", "_TimeBetweenShots");
_TimeBetweenShots = 0.0;
nameMap.set("Projectile Type", "_ProjectileType");
nameMap.set("Origin X", "_OriginX");
_OriginX = 0.0;
nameMap.set("Origin Y", "_OriginY");
_OriginY = 0.0;
nameMap.set("Fire Force", "_FireForce");
_FireForce = 0.0;
nameMap.set("Dir X", "_DirX");
_DirX = 0.0;
nameMap.set("Dir Y", "_DirY");
_DirY = 0.0;
nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Idle Animation", "_IdleAnimation");
nameMap.set("Shoot Animation", "_ShootAnimation");
nameMap.set("ResetToIdle", "_ResetToIdle");
_ResetToIdle = false;
nameMap.set("Projectile Delay After Shoot Animation Starts", "_ProjectileDelayAfterShootAnimationStarts");
_ProjectileDelayAfterShootAnimationStarts = 0.0;
nameMap.set("SFX Name", "_SFXName");
_SFXName = "";
nameMap.set("Actor", "actor");
nameMap.set("SFX Count", "_SFXCount");
_SFXCount = 1.0;

	}
	
	override public function init()
	{
		            if((_InitialDelay > 0))
{
            runLater(1000 * _InitialDelay, function(timeTask:TimedTask):Void {
                        actor.shout("_customEvent_" + "ShootProjectile");
}, actor);
}

        else
{
            actor.shout("_customEvent_" + "ShootProjectile");
}

    addPropertyChangeListener("_IsActive", null, function(property:Dynamic, list:Array<Dynamic>):Void {
if(wrapper.enabled && cast(property, Bool) == true){
        runLater(1000 * _TimeBetweenShots, function(timeTask:TimedTask):Void {
                    actor.shout("_customEvent_" + "ShootProjectile");
}, actor);
}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_ResetToIdle)
{
            actor.setAnimation("" + _IdleAnimation);
            _ResetToIdle = false;
propertyChanged("_ResetToIdle", _ResetToIdle);
}

        if((actor.getAnimation() == _ShootAnimation))
{
            if((actor.getCurrentFrame() == (actor.getNumFrames() - 1)))
{
                _ResetToIdle = true;
propertyChanged("_ResetToIdle", _ResetToIdle);
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}