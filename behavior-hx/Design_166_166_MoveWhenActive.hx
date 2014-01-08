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



class Design_166_166_MoveWhenActive extends ActorScript
{          	
	
public var _IsActive:Bool;

public var _XTarget:Float;

public var _YTarget:Float;

public var _XStart:Float;

public var _YStart:Float;

public var _MoveTime:Float;

public var _ActiveChanged:Bool;

public var _EaseType:String;

public var _MoveDelay:Float;

public var _ReturnTime:Float;

public var _MoveTarget:Actor;

public var _XOffset:Float;

public var _YOffset:Float;

public var _ActiveSFXName:String;

public var _InactiveSFXName:String;

public var _InactiveSFXNumber:Float;

public var _ActiveSFXNumber:Float;

public var _WillMove:Bool;

public var _LoopSoundWhilstMoving:Bool;
    public function _customEvent_Activated():Void
{
        if (_MoveTarget == null) return;
        _IsActive = true;
propertyChanged("_IsActive", _IsActive);
        _WillMove = (!(_MoveTarget.getX() == (_XTarget + _XOffset)) || !(_MoveTarget.getY() == (_YTarget + _YOffset)));
propertyChanged("_WillMove", _WillMove);
        if(!(_WillMove))
{
            return;
}

        var trans =
switch(_EaseType)
{
	case "None":
		Linear.easeNone;
	case "Normal In":
		Quad.easeIn;
	case "Normal Out":
		Quad.easeOut;
	case "Strong In":
		Expo.easeIn;
	case "Strong Out":
		Expo.easeOut;
	default:
		Quad.easeOut;
}

if (_MoveDelay > 0)
{
	runLater(1000 * _MoveDelay, function(timeTask:TimedTask):Void
	{
		if (_IsActive) _MoveTarget.moveTo(_XTarget + _XOffset, _YTarget + _YOffset, _MoveTime, trans);
	});
} else {
	_MoveTarget.moveTo(_XTarget + _XOffset, _YTarget + _YOffset, _MoveTime, trans);
}

        if(((hasValue(_ActiveSFXName) != false) && !(("" + _ActiveSFXName) == (""))))
{
            if(_LoopSoundWhilstMoving)
{
                if((_MoveDelay > 0))
{
                    runLater(1000 * _MoveDelay, function(timeTask:TimedTask):Void {
                                sayToScene("Sound Manager PM", "_customBlock_StopSceneSoundForActor", [_ActiveSFXName,getCurrentSceneName(),actor]);
                                sayToScene("Sound Manager PM", "_customBlock_LoopSceneSoundForActor", [_ActiveSFXName,getCurrentSceneName(),actor]);
}, actor);
                    runLater(1000 * (_MoveDelay + _MoveTime), function(timeTask:TimedTask):Void {
                                if(_IsActive)
{
                                    sayToScene("Sound Manager PM", "_customBlock_StopSceneSoundForActor", [_ActiveSFXName,getCurrentSceneName(),actor]);
}

}, actor);
}

                else
{
                    sayToScene("Sound Manager PM", "_customBlock_StopSceneSoundForActor", [_ActiveSFXName,getCurrentSceneName(),actor]);
                    sayToScene("Sound Manager PM", "_customBlock_LoopSceneSoundForActor", [_ActiveSFXName,getCurrentSceneName(),actor]);
                    runLater(1000 * _MoveTime, function(timeTask:TimedTask):Void {
                                if(_IsActive)
{
                                    sayToScene("Sound Manager PM", "_customBlock_StopSceneSoundForActor", [_ActiveSFXName,getCurrentSceneName(),actor]);
}

}, actor);
}

}

            else
{
                sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_ActiveSFXName,_ActiveSFXNumber]);
}

}

}

    public function _customEvent_Deactivated():Void
{
        if (_MoveTarget == null) return;
        _IsActive = false;
propertyChanged("_IsActive", _IsActive);
        _WillMove = (!(_MoveTarget.getX() == _XStart) || !(_MoveTarget.getY() == _YStart));
propertyChanged("_WillMove", _WillMove);
        if(!(_WillMove))
{
            return;
}

        var trans =
switch(_EaseType)
{
	case "None":
		Linear.easeNone;
	case "Normal In":
		Quad.easeIn;
	case "Normal Out":
		Quad.easeOut;
	case "Strong In":
		Expo.easeIn;
	case "Strong Out":
		Expo.easeOut;
	default:
		Quad.easeOut;
}

_MoveTarget.moveTo(_XStart, _YStart, _ReturnTime, trans);
        if(((hasValue(_InactiveSFXName) != false) && !(("" + _InactiveSFXName) == (""))))
{
            if(_LoopSoundWhilstMoving)
{
                sayToScene("Sound Manager PM", "_customBlock_StopSceneSoundForActor", [_InactiveSFXName,getCurrentSceneName(),actor]);
                sayToScene("Sound Manager PM", "_customBlock_LoopSceneSoundForActor", [_InactiveSFXName,getCurrentSceneName(),actor]);
                runLater(1000 * _MoveTime, function(timeTask:TimedTask):Void {
                            if(!(_IsActive))
{
                                sayToScene("Sound Manager PM", "_customBlock_StopSceneSoundForActor", [_InactiveSFXName,getCurrentSceneName(),actor]);
}

}, actor);
}

            else
{
                sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_InactiveSFXName,_InactiveSFXNumber]);
}

}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("X Target", "_XTarget");
_XTarget = 0.0;
nameMap.set("Y Target", "_YTarget");
_YTarget = 0.0;
nameMap.set("X Start", "_XStart");
_XStart = 0.0;
nameMap.set("Y Start", "_YStart");
_YStart = 0.0;
nameMap.set("Move Time", "_MoveTime");
_MoveTime = 1.0;
nameMap.set("Active Changed", "_ActiveChanged");
_ActiveChanged = false;
nameMap.set("Ease Type", "_EaseType");
_EaseType = "";
nameMap.set("Move Delay", "_MoveDelay");
_MoveDelay = 0.0;
nameMap.set("Return Time", "_ReturnTime");
_ReturnTime = 0.0;
nameMap.set("Move Target", "_MoveTarget");
nameMap.set("X Offset", "_XOffset");
_XOffset = 0.0;
nameMap.set("Y Offset", "_YOffset");
_YOffset = 0.0;
nameMap.set("Active SFX Name", "_ActiveSFXName");
_ActiveSFXName = "";
nameMap.set("Inactive SFX Name", "_InactiveSFXName");
_InactiveSFXName = "";
nameMap.set("Actor", "actor");
nameMap.set("Inactive SFX Number", "_InactiveSFXNumber");
_InactiveSFXNumber = 1.0;
nameMap.set("Active SFX Number", "_ActiveSFXNumber");
_ActiveSFXNumber = 1.0;
nameMap.set("Will Move?", "_WillMove");
_WillMove = false;
nameMap.set("Loop Sound Whilst Moving?", "_LoopSoundWhilstMoving");
_LoopSoundWhilstMoving = false;

	}
	
	override public function init()
	{
		            runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    if((_ReturnTime == 0))
{
                        _ReturnTime = asNumber(_MoveTime);
propertyChanged("_ReturnTime", _ReturnTime);
}

                    if(((actor.getGroup() == getActorGroup(6)) && actor.hasBehavior("Rideable Platform PM")))
{
                        _MoveTarget = actor.getValue("Rideable Platform PM", "_Target");
propertyChanged("_MoveTarget", _MoveTarget);
}

                    else if((hasValue(_MoveTarget) == false))
{
                        _MoveTarget = actor;
propertyChanged("_MoveTarget", _MoveTarget);
}

                    _XStart = asNumber(_MoveTarget.getX());
propertyChanged("_XStart", _XStart);
                    _YStart = asNumber(_MoveTarget.getY());
propertyChanged("_YStart", _YStart);
                    _XOffset = asNumber((_MoveTarget.getX() - actor.getX()));
propertyChanged("_XOffset", _XOffset);
                    _YOffset = asNumber((_MoveTarget.getY() - actor.getY()));
propertyChanged("_YOffset", _YOffset);
}, actor);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}