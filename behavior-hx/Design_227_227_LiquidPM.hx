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



class Design_227_227_LiquidPM extends ActorScript
{          	
	
public var _Buoyancy:Float;

public var _Liquidity:Float;

public var _AllowSwimming:Bool;

public var _WasHit:Bool;

public var _IsHit:Bool;

public var _SplashSFXName:String;

public var _SplashSFXNumber:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Buoyancy", "_Buoyancy");
_Buoyancy = 0.0;
nameMap.set("Liquidity", "_Liquidity");
_Liquidity = 0.0;
nameMap.set("Allow Swimming?", "_AllowSwimming");
_AllowSwimming = false;
nameMap.set("Was Hit?", "_WasHit");
_WasHit = false;
nameMap.set("Is Hit?", "_IsHit");
_IsHit = false;
nameMap.set("Splash SFX Name", "_SplashSFXName");
_SplashSFXName = "";
nameMap.set("Splash SFX Number", "_SplashSFXNumber");
_SplashSFXNumber = 1;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_IsHit)
{
            if(!(_WasHit))
{
                sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_SplashSFXName,_SplashSFXNumber]);
                _WasHit = true;
propertyChanged("_WasHit", _WasHit);
}

}

        else
{
            _WasHit = false;
propertyChanged("_WasHit", _WasHit);
}

        _IsHit = false;
propertyChanged("_IsHit", _IsHit);
}
});
    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _IsHit = true;
propertyChanged("_IsHit", _IsHit);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}