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



class Design_422_422_MakeSoundWhenHitPM extends ActorScript
{          	
	
public var _HasHit:Bool;

public var _WasHit:Bool;

public var _SFXName:String;

public var _SFXNumber:Float;

public var _HitLeftSound:Bool;

public var _HitRightSound:Bool;

public var _HitTopSound:Bool;

public var _HitBottomSound:Bool;

public var _ScaleSoundByVelocity:Bool;

public var _MaximumVelocityForScale:Float;

public var _HitVelocity:Float;

public var _Volume:Float;

public var _MinimumVelocityForSound:Float;

public var _StoredXSpeed:Float;

public var _StoredYSpeed:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Has Hit?", "_HasHit");
_HasHit = false;
nameMap.set("Was Hit?", "_WasHit");
_WasHit = false;
nameMap.set("SFX Name", "_SFXName");
_SFXName = "";
nameMap.set("SFX Number", "_SFXNumber");
_SFXNumber = 1.0;
nameMap.set("Hit Left Sound?", "_HitLeftSound");
_HitLeftSound = true;
nameMap.set("Hit Right Sound?", "_HitRightSound");
_HitRightSound = true;
nameMap.set("Hit Top Sound?", "_HitTopSound");
_HitTopSound = true;
nameMap.set("Hit Bottom Sound?", "_HitBottomSound");
_HitBottomSound = true;
nameMap.set("Scale Sound By Velocity?", "_ScaleSoundByVelocity");
_ScaleSoundByVelocity = false;
nameMap.set("Maximum Velocity For Scale", "_MaximumVelocityForScale");
_MaximumVelocityForScale = 10.0;
nameMap.set("Hit Velocity", "_HitVelocity");
_HitVelocity = 0.0;
nameMap.set("Volume", "_Volume");
_Volume = 0.0;
nameMap.set("Minimum Velocity For Sound", "_MinimumVelocityForSound");
_MinimumVelocityForSound = -10.0;
nameMap.set("Stored X Speed", "_StoredXSpeed");
_StoredXSpeed = 0.0;
nameMap.set("Stored Y Speed", "_StoredYSpeed");
_StoredYSpeed = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((event.thisFromTop && _HitTopSound))
{
            _WasHit = true;
propertyChanged("_WasHit", _WasHit);
}

        if((event.thisFromLeft && _HitLeftSound))
{
            _WasHit = true;
propertyChanged("_WasHit", _WasHit);
}

        if((event.thisFromBottom && _HitBottomSound))
{
            _WasHit = true;
propertyChanged("_WasHit", _WasHit);
}

        if((event.thisFromRight && _HitRightSound))
{
            _WasHit = true;
propertyChanged("_WasHit", _WasHit);
}

}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _StoredXSpeed = asNumber((Math.abs(actor.getXVelocity()) - _StoredXSpeed));
propertyChanged("_StoredXSpeed", _StoredXSpeed);
        _StoredYSpeed = asNumber((Math.abs(actor.getYVelocity()) - _StoredYSpeed));
propertyChanged("_StoredYSpeed", _StoredYSpeed);
        if((_StoredXSpeed > _StoredYSpeed))
{
            _HitVelocity = asNumber((_StoredXSpeed * 100));
propertyChanged("_HitVelocity", _HitVelocity);
}

        else
{
            _HitVelocity = asNumber((_StoredYSpeed * 100));
propertyChanged("_HitVelocity", _HitVelocity);
}

        if(_WasHit)
{
            if((!(_HasHit) && (_HitVelocity > _MinimumVelocityForSound)))
{
                if(_ScaleSoundByVelocity)
{
                    _Volume = asNumber(((_HitVelocity / _MaximumVelocityForScale) * 100));
propertyChanged("_Volume", _Volume);
                    if((_Volume > 100))
{
                        _Volume = asNumber(100);
propertyChanged("_Volume", _Volume);
}

                    if((_Volume > 0))
{
                        sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundAtVolume", [_SFXName,_SFXNumber,_Volume]);
                        _HasHit = true;
propertyChanged("_HasHit", _HasHit);
}

}

                else
{
                    sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_SFXName,_SFXNumber]);
                    _HasHit = true;
propertyChanged("_HasHit", _HasHit);
}

}

}

        else
{
            _HasHit = false;
propertyChanged("_HasHit", _HasHit);
}

        _WasHit = false;
propertyChanged("_WasHit", _WasHit);
        _StoredXSpeed = asNumber(Math.abs(actor.getXVelocity()));
propertyChanged("_StoredXSpeed", _StoredXSpeed);
        _StoredYSpeed = asNumber(Math.abs(actor.getYVelocity()));
propertyChanged("_StoredYSpeed", _StoredYSpeed);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}