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



class Design_19_19_SplitScreenButtonPM extends SceneScript
{          	
	
public var _LeftPressed:Bool;

public var _RightPressed:Bool;

public var _ActorToControl:Actor;

public var _LeftTouchID:Float;

public var _RightTouchID:Float;

public var _LeftWasFirstPressed:Bool;

public var _JumpFudgeCoefficient:Float;

public var _CurrentFudge:Float;

public var _HasJumped:Bool;

public var _LastXTouch:Float;

public var _LeftTouchStartX:Float;

public var _RightTouchStartX:Float;

public var _RightTouchStartY:Float;

public var _LeftTouchStartY:Float;

public var _DragX:Float;

public var _Mode:String;
    

/* Params are:*/
public function _customBlock_SplitUpdate():Void
{
        if((Math.abs(_ActorToControl.getXVelocity()) < 1))
{
            _JumpFudgeCoefficient = asNumber(10);
propertyChanged("_JumpFudgeCoefficient", _JumpFudgeCoefficient);
}

        else
{
            _JumpFudgeCoefficient = asNumber((10 / Math.abs(_ActorToControl.getXVelocity())));
propertyChanged("_JumpFudgeCoefficient", _JumpFudgeCoefficient);
            if((_JumpFudgeCoefficient > 10))
{
                _JumpFudgeCoefficient = asNumber(10);
propertyChanged("_JumpFudgeCoefficient", _JumpFudgeCoefficient);
}

}

        if((_LeftPressed && _RightPressed))
{
            /* "Custom: <Actor To Control> Can Jump?" */
            if(!(_ActorToControl.getActorValue("Prevent Jumping")))
{
                /* "Custom: Set \"Jump\" to <true> for <Actor To Control>" */
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",true]);
                if(((_JumpFudgeCoefficient == 0) || (_CurrentFudge >= _JumpFudgeCoefficient)))
{
                    _ActorToControl.setActorValue("Vertical Jump", false);
                    if(_LeftWasFirstPressed)
{
                        /* "Custom: Set \"Left\" to <true> for <Actor To Control>" */
                        _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",true]);
}

                    else
{
                        /* "Custom: Set \"Right\" to <true> for <Actor To Control>" */
                        _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",true]);
}

                    if(!(asBoolean(_ActorToControl.getActorValue("On Ground?"))))
{
                        _HasJumped = true;
propertyChanged("_HasJumped", _HasJumped);
}

}

                else
{
                    _ActorToControl.setActorValue("Vertical Jump", true);
                    /* "Custom: Set \"Left\" to <false> for <Actor To Control>" */
                    _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",false]);
                    /* "Custom: Set \"Right\" to <false> for <Actor To Control>" */
                    _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",false]);
}

}

            else
{
                /* "Custom: Set \"UseObject\" to <true> for <Actor To Control>" */
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["UseObject",true]);
}

}

        else
{
            _ActorToControl.setActorValue("Vertical Jump", false);
            _CurrentFudge += 1;
propertyChanged("_CurrentFudge", _CurrentFudge);
            /* "Custom: Set \"Jump\" to <false> for <Actor To Control>" */
            _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",false]);
            _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["UseObject",false]);
            if(_LeftPressed)
{
                /* "Custom: Set \"Left\" to <true> for <Actor To Control>" */
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",true]);
                /* "Custom: Set \"Right\" to <false> for <Actor To Control>" */
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",false]);
}

            else if(_RightPressed)
{
                /* "Custom: Set \"Right\" to <true> for <Actor To Control>" */
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",true]);
                /* "Custom: Set \"Left\" to <false> for <Actor To Control>" */
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",false]);
}

            else
{
                /* "Custom: Set \"Left\" to <false> for <Actor To Control>" */
                /* "Custom: Set \"Right\" to <false> for <Actor To Control>" */
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",false]);
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",false]);
                _CurrentFudge = asNumber(0);
propertyChanged("_CurrentFudge", _CurrentFudge);
}

}

        if((_HasJumped && asBoolean(_ActorToControl.getActorValue("On Ground?"))))
{
            _CurrentFudge = asNumber(0);
propertyChanged("_CurrentFudge", _CurrentFudge);
            _HasJumped = false;
propertyChanged("_HasJumped", _HasJumped);
            _ActorToControl.setActorValue("Vertical Jump", false);
}

}
    

/* Params are:*/
public function _customBlock_ButtonUpdate():Void
{
        if(_LeftPressed)
{
            if(((_LeftTouchStartX - _DragX) > 5))
{
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",true]);
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",false]);
}

            else if(((_LeftTouchStartX - _DragX) < -5))
{
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",false]);
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",true]);
}

            else
{
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",false]);
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",false]);
}

}

        else
{
            _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",false]);
            _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",false]);
}

        if(_RightPressed)
{
            if(!(_ActorToControl.getActorValue("Prevent Jumping")))
{
                /* "Custom: Set \"Jump\" to <true> for <Actor To Control>" */
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",true]);
}

            else
{
                /* "Custom: Set \"UseObject\" to <true> for <Actor To Control>" */
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["UseObject",true]);
}

}

        else
{
            _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",false]);
            _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["UseObject",false]);
}

}

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Left Pressed?", "_LeftPressed");
_LeftPressed = false;
nameMap.set("Right Pressed?", "_RightPressed");
_RightPressed = false;
nameMap.set("Actor To Control", "_ActorToControl");
nameMap.set("Left Touch ID", "_LeftTouchID");
_LeftTouchID = 0.0;
nameMap.set("Right Touch ID", "_RightTouchID");
_RightTouchID = 0.0;
nameMap.set("Left Was First Pressed?", "_LeftWasFirstPressed");
_LeftWasFirstPressed = false;
nameMap.set("Jump Fudge Coefficient", "_JumpFudgeCoefficient");
_JumpFudgeCoefficient = 0.0;
nameMap.set("Current Fudge", "_CurrentFudge");
_CurrentFudge = 0.0;
nameMap.set("Has Jumped?", "_HasJumped");
_HasJumped = false;
nameMap.set("Last X Touch", "_LastXTouch");
_LastXTouch = 0.0;
nameMap.set("Left Touch Start X", "_LeftTouchStartX");
_LeftTouchStartX = 0.0;
nameMap.set("Right Touch Start X", "_RightTouchStartX");
_RightTouchStartX = 0.0;
nameMap.set("Right Touch Start Y", "_RightTouchStartY");
_RightTouchStartY = 0.0;
nameMap.set("Left Touch Start Y", "_LeftTouchStartY");
_LeftTouchStartY = 0.0;
nameMap.set("Drag X", "_DragX");
_DragX = 0;
nameMap.set("Mode", "_Mode");
_Mode = "";

	}
	
	override public function init()
	{
		            _Mode = getGameAttribute("ControlMode");
propertyChanged("_Mode", _Mode);
        _LeftTouchID = asNumber(-1);
propertyChanged("_LeftTouchID", _LeftTouchID);
        _RightTouchID = asNumber(-1);
propertyChanged("_RightTouchID", _RightTouchID);
        _CurrentFudge = asNumber(0);
propertyChanged("_CurrentFudge", _CurrentFudge);
        if(!(#if mobile true #else false #end))
{
            disableThisBehavior();
}

        _LastXTouch = asNumber(0);
propertyChanged("_LastXTouch", _LastXTouch);
    addMultiTouchStartListener(function(event:TouchEvent, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _LastXTouch = asNumber((event.stageX - Engine.screenOffsetX) / (Engine.screenScaleX * Engine.SCALE));
propertyChanged("_LastXTouch", _LastXTouch);
        if(((event.stageX - Engine.screenOffsetX) / (Engine.screenScaleX * Engine.SCALE) < (getScreenWidth() / 2)))
{
            _DragX = asNumber((event.stageX - Engine.screenOffsetX) / (Engine.screenScaleX * Engine.SCALE));
propertyChanged("_DragX", _DragX);
            _LeftTouchStartX = asNumber((event.stageX - Engine.screenOffsetX) / (Engine.screenScaleX * Engine.SCALE));
propertyChanged("_LeftTouchStartX", _LeftTouchStartX);
            _LeftTouchStartY = asNumber((event.stageY - Engine.screenOffsetY) / (Engine.screenScaleY * Engine.SCALE));
propertyChanged("_LeftTouchStartY", _LeftTouchStartY);
            if((_LeftTouchID == -1))
{
                _LeftTouchID = asNumber((event.touchPointID));
propertyChanged("_LeftTouchID", _LeftTouchID);
}

            _LeftPressed = true;
propertyChanged("_LeftPressed", _LeftPressed);
            if(!(_RightPressed))
{
                _LeftWasFirstPressed = true;
propertyChanged("_LeftWasFirstPressed", _LeftWasFirstPressed);
}

}

        else
{
            _RightTouchStartX = asNumber((event.stageX - Engine.screenOffsetX) / (Engine.screenScaleX * Engine.SCALE));
propertyChanged("_RightTouchStartX", _RightTouchStartX);
            _RightTouchStartY = asNumber((event.stageY - Engine.screenOffsetY) / (Engine.screenScaleY * Engine.SCALE));
propertyChanged("_RightTouchStartY", _RightTouchStartY);
            if((_RightTouchID == -1))
{
                _RightTouchID = asNumber((event.touchPointID));
propertyChanged("_RightTouchID", _RightTouchID);
}

            _RightPressed = true;
propertyChanged("_RightPressed", _RightPressed);
            if(!(_LeftPressed))
{
                _LeftWasFirstPressed = false;
propertyChanged("_LeftWasFirstPressed", _LeftWasFirstPressed);
}

}

}
});
    addMultiTouchMoveListener(function(event:TouchEvent, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((((event.stageX - Engine.screenOffsetX) / (Engine.screenScaleX * Engine.SCALE) < (getScreenWidth() / 2)) && (_Mode == "Button")))
{
            _DragX = asNumber((event.stageX - Engine.screenOffsetX) / (Engine.screenScaleX * Engine.SCALE));
propertyChanged("_DragX", _DragX);
}

}
});
    addMultiTouchEndListener(function(event:TouchEvent, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(((event.touchPointID) == _LeftTouchID))
{
            _LeftTouchID = asNumber(-1);
propertyChanged("_LeftTouchID", _LeftTouchID);
            _LeftPressed = false;
propertyChanged("_LeftPressed", _LeftPressed);
            if(_RightPressed)
{
                _LeftWasFirstPressed = false;
propertyChanged("_LeftWasFirstPressed", _LeftWasFirstPressed);
}

}

        if(((event.touchPointID) == _RightTouchID))
{
            _RightTouchID = asNumber(-1);
propertyChanged("_RightTouchID", _RightTouchID);
            _RightPressed = false;
propertyChanged("_RightPressed", _RightPressed);
            if(_LeftPressed)
{
                _LeftWasFirstPressed = true;
propertyChanged("_LeftWasFirstPressed", _LeftWasFirstPressed);
}

}

}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((_Mode == "Split"))
{
            sayToScene("Split Screen Button PM", "_customBlock_SplitUpdate");
}

        else if((_Mode == "Button"))
{
            sayToScene("Split Screen Button PM", "_customBlock_ButtonUpdate");
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}