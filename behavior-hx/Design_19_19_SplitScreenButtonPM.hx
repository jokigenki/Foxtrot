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

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Back;
import com.eclecticdesignstudio.motion.easing.Cubic;
import com.eclecticdesignstudio.motion.easing.Elastic;
import com.eclecticdesignstudio.motion.easing.Expo;
import com.eclecticdesignstudio.motion.easing.Linear;
import com.eclecticdesignstudio.motion.easing.Quad;
import com.eclecticdesignstudio.motion.easing.Quart;
import com.eclecticdesignstudio.motion.easing.Quint;
import com.eclecticdesignstudio.motion.easing.Sine;



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

	}
	
	override public function init()
	{
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
    addMultiTouchEndListener(function(event:TouchEvent, list:Array<Dynamic>):Void {
if(wrapper.enabled){
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

}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((_LeftPressed && _RightPressed))
{
            /* "Custom: <Actor To Control> Can Jump?" */
            if(cast((_ActorToControl.say("Jumping PM", "_customBlock_GetPreventJumping")), Bool))
{
                /* "Custom: Set \"Jump\" to <true> for <Actor To Control>" */
                _ActorToControl.say("Control Adapter PM", "_customBlock_SetIsOn", ["Jump",true]);
                if(((_JumpFudgeCoefficient == 0) || (_CurrentFudge >= _JumpFudgeCoefficient)))
{
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
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}