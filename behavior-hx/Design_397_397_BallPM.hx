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



class Design_397_397_BallPM extends ActorScript
{          	
	
public var _StartVelocityMinimumX:Float;

public var _StartVelocityMaximumX:Float;

public var _StartVelocityMinimumY:Float;

public var _StartVelocityMaximumY:Float;

public var _ReadyToBounce:Bool;

public var _VelocityX:Float;

public var _VelocityY:Float;

public var _PositionX:Float;

public var _PositionY:Float;

public var _MaximumXSpeed:Float;

public var _MaximumYSpeed:Float;

public var _IsActive:Bool;

public var _LeftBound:Float;

public var _RightBound:Float;

public var _TopBound:Float;

public var _LowerRightBound:Float;

public var _LowerLeftBound:Float;

public var _BottomBound:Float;

public var _LowerTopBound:Float;

public var _NSounds:Float;

public var _BounceSoundName:String;
    public function _customEvent_Activate():Void
{
        _IsActive = true;
propertyChanged("_IsActive", _IsActive);
        _VelocityX = asNumber(((randomFloat() * (_StartVelocityMaximumX - _StartVelocityMinimumX)) + _StartVelocityMinimumX));
propertyChanged("_VelocityX", _VelocityX);
        _VelocityY = asNumber(((randomFloat() * (_StartVelocityMaximumY - _StartVelocityMinimumY)) + _StartVelocityMinimumY));
propertyChanged("_VelocityY", _VelocityY);
        _PositionX = asNumber(actor.getX());
propertyChanged("_PositionX", _PositionX);
        _PositionY = asNumber(actor.getY());
propertyChanged("_PositionY", _PositionY);
}

    public function _customEvent_Deactivate():Void
{
        _IsActive = false;
propertyChanged("_IsActive", _IsActive);
}

    

/* Params are: */
public function _customBlock_IsInLeftBound():Bool
{
var __Self:Actor = actor;
        if(((actor.getX() < _LowerLeftBound) && (actor.getY() > _LowerTopBound)))
{
            return false;
}

        if((actor.getX() < _LeftBound))
{
            return false;
}

        return true;
}
    

/* Params are: */
public function _customBlock_IsInRightBound():Bool
{
var __Self:Actor = actor;
        if(((actor.getX() > _LowerRightBound) && (actor.getY() > _LowerTopBound)))
{
            return false;
}

        if((actor.getX() > _RightBound))
{
            return false;
}

        return true;
}
    

/* Params are: */
public function _customBlock_IsInTopBounds():Bool
{
var __Self:Actor = actor;
        if((actor.getY() < _TopBound))
{
            return false;
}

        return true;
}
    

/* Params are: */
public function _customBlock_IsInBottomBounds():Bool
{
var __Self:Actor = actor;
        if((actor.getY() > _BottomBound))
{
            return false;
}

        if(((actor.getX() < _LowerLeftBound) && (actor.getY() > _LowerTopBound)))
{
            return false;
}

        if(((actor.getX() > _LowerRightBound) && (actor.getY() > _LowerTopBound)))
{
            return false;
}

        return true;
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Start Velocity Minimum X", "_StartVelocityMinimumX");
_StartVelocityMinimumX = 0.0;
nameMap.set("Start Velocity Maximum X", "_StartVelocityMaximumX");
_StartVelocityMaximumX = 0.0;
nameMap.set("Start Velocity Minimum Y", "_StartVelocityMinimumY");
_StartVelocityMinimumY = 0.0;
nameMap.set("Start Velocity Maximum Y", "_StartVelocityMaximumY");
_StartVelocityMaximumY = 0.0;
nameMap.set("Ready To Bounce?", "_ReadyToBounce");
_ReadyToBounce = true;
nameMap.set("Velocity X", "_VelocityX");
_VelocityX = 0.0;
nameMap.set("Velocity Y", "_VelocityY");
_VelocityY = 0.0;
nameMap.set("Position X", "_PositionX");
_PositionX = 0.0;
nameMap.set("Position Y", "_PositionY");
_PositionY = 0.0;
nameMap.set("Maximum X Speed", "_MaximumXSpeed");
_MaximumXSpeed = 0.0;
nameMap.set("Maximum Y Speed", "_MaximumYSpeed");
_MaximumYSpeed = 0.0;
nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Left Bound", "_LeftBound");
_LeftBound = 0.0;
nameMap.set("Right Bound", "_RightBound");
_RightBound = 0.0;
nameMap.set("Actor", "actor");
nameMap.set("Top Bound", "_TopBound");
_TopBound = 0.0;
nameMap.set("Lower Right Bound", "_LowerRightBound");
_LowerRightBound = 0.0;
nameMap.set("Lower Left Bound", "_LowerLeftBound");
_LowerLeftBound = 0.0;
nameMap.set("Bottom Bound", "_BottomBound");
_BottomBound = 0.0;
nameMap.set("Lower Top Bound", "_LowerTopBound");
_LowerTopBound = 0.0;
nameMap.set("N Sounds", "_NSounds");
_NSounds = 1.0;
nameMap.set("Bounce Sound Name", "_BounceSoundName");
_BounceSoundName = "";

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((_IsActive && (!(event.thisCollidedWithTerrain) && !(event.thisCollidedWithTile))))
{
            if(_ReadyToBounce)
{
                sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_BounceSoundName,_NSounds]);
                _ReadyToBounce = false;
propertyChanged("_ReadyToBounce", _ReadyToBounce);
                if((event.otherFromTop || event.otherFromBottom))
{
                    runLater(1000 * 0.02, function(timeTask:TimedTask):Void {
                                _VelocityY = asNumber((_VelocityY * -1));
propertyChanged("_VelocityY", _VelocityY);
}, actor);
}

                else if((event.otherFromLeft || event.otherFromRight))
{
                    runLater(1000 * 0.02, function(timeTask:TimedTask):Void {
                                _VelocityX = asNumber((_VelocityX * -1));
propertyChanged("_VelocityX", _VelocityX);
}, actor);
}

                if(((event.otherActor.getType() == getActorType(759)) || (event.otherActor.getType() == getActorType(772))))
{
                    recycleActor(event.otherActor);
}

                runLater(1000 * 0.05, function(timeTask:TimedTask):Void {
                            if(actor.isAlive())
{
                                _ReadyToBounce = true;
propertyChanged("_ReadyToBounce", _ReadyToBounce);
}

}, actor);
}

            if(event.otherActor.hasBehavior("Position relative to actor PM"))
{
                _VelocityX = asNumber((_VelocityX + (event.otherActor.getValue("Position relative to actor PM", "_TargetActor").getXVelocity() / -20)));
propertyChanged("_VelocityX", _VelocityX);
}

            if((_VelocityX > _MaximumXSpeed))
{
                _VelocityX = asNumber(_MaximumXSpeed);
propertyChanged("_VelocityX", _VelocityX);
}

            else if((_VelocityX < -(_MaximumXSpeed)))
{
                _VelocityX = asNumber(-(_MaximumXSpeed));
propertyChanged("_VelocityX", _VelocityX);
}

            if((_VelocityY > _MaximumYSpeed))
{
                _VelocityY = asNumber(_MaximumYSpeed);
propertyChanged("_VelocityY", _VelocityY);
}

            else if((_VelocityY < -(_MaximumYSpeed)))
{
                _VelocityY = asNumber(-(_MaximumYSpeed));
propertyChanged("_VelocityY", _VelocityY);
}

}

}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_IsActive)
{
            if(!(cast((actor.say("Ball PM", "_customBlock_IsInLeftBound")), Bool)))
{
                if((_VelocityX < 0))
{
                    sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_BounceSoundName,_NSounds]);
                    _VelocityX = asNumber(-(_VelocityX));
propertyChanged("_VelocityX", _VelocityX);
}

}

            if(!(cast((actor.say("Ball PM", "_customBlock_IsInRightBound")), Bool)))
{
                if((_VelocityX > 0))
{
                    sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_BounceSoundName,_NSounds]);
                    _VelocityX = asNumber(-(_VelocityX));
propertyChanged("_VelocityX", _VelocityX);
}

}

            if(!(cast((actor.say("Ball PM", "_customBlock_IsInTopBounds")), Bool)))
{
                if((_VelocityY < 0))
{
                    sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_BounceSoundName,_NSounds]);
                    _VelocityY = asNumber(-(_VelocityY));
propertyChanged("_VelocityY", _VelocityY);
}

}

            if(!(cast((actor.say("Ball PM", "_customBlock_IsInBottomBounds")), Bool)))
{
                if((_VelocityY > 0))
{
                    sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_BounceSoundName,_NSounds]);
                    _VelocityY = asNumber(-(_VelocityY));
propertyChanged("_VelocityY", _VelocityY);
}

}

            _PositionX += _VelocityX;
propertyChanged("_PositionX", _PositionX);
            _PositionY += _VelocityY;
propertyChanged("_PositionY", _PositionY);
            actor.setX(_PositionX);
            actor.setY(_PositionY);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}