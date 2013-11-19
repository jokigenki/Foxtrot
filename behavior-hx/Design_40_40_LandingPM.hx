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



class Design_40_40_LandingPM extends ActorScript
{          	
	
public var _TopOfFall:Float;

public var _NormalLandingLeft:String;

public var _NormalLandingRight:String;

public var _BigLandingLeft:String;

public var _BigLandingRight:String;

public var _BigLandingThreshold:Float;

public var _WasFalling:Bool;

public var _OldY:Float;

public var _NewY:Float;

public var _MadeBigLanding:Bool;

public var _FrameCount:Float;

public var _MadeLanding:Bool;

public var _Landingfriction:Float;

public var _Normalfriction:Float;

public var _PreventLanding:Bool;

public var _BigLandingFriction:Float;
    

/* Params are: */
public function _customBlock_CheckLandingMovement():Void
{
var __Self:Actor = actor;
        if(_MadeLanding)
{
            /* "Custom: Is in landing animation" */
            if(cast((actor.say("Landing PM", "_customBlock_InLandingAnimation")), Bool))
{
                actor.setFriction(_Landingfriction);
}

            /* "Custom: Is in big landing animation" */
            else if(cast((actor.say("Landing PM", "_customBlock_IsInBigLandingAnimation")), Bool))
{
                actor.setFriction(_BigLandingFriction);
}

            else
{
                _MadeLanding = false;
propertyChanged("_MadeLanding", _MadeLanding);
                actor.setFriction(_Normalfriction);
}

}

}
    

/* Params are: */
public function _customBlock_InLandingAnimation():Bool
{
var __Self:Actor = actor;
        return ((actor.getAnimation() == _NormalLandingLeft) || (actor.getAnimation() == _NormalLandingRight));
}
    

/* Params are: */
public function _customBlock_IsInBigLandingAnimation():Bool
{
var __Self:Actor = actor;
        return ((actor.getAnimation() == _BigLandingLeft) || (actor.getAnimation() == _BigLandingRight));
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Top Of Fall", "_TopOfFall");
_TopOfFall = 0.0;
nameMap.set("Normal Landing Left", "_NormalLandingLeft");
nameMap.set("Normal Landing Right", "_NormalLandingRight");
nameMap.set("Big Landing Left", "_BigLandingLeft");
nameMap.set("Big Landing Right", "_BigLandingRight");
nameMap.set("Big Landing Threshold", "_BigLandingThreshold");
_BigLandingThreshold = 0.0;
nameMap.set("Was Falling?", "_WasFalling");
_WasFalling = false;
nameMap.set("Old Y", "_OldY");
_OldY = 0.0;
nameMap.set("New Y", "_NewY");
_NewY = 0.0;
nameMap.set("Made Big Landing?", "_MadeBigLanding");
_MadeBigLanding = false;
nameMap.set("FrameCount", "_FrameCount");
_FrameCount = 0.0;
nameMap.set("Made Landing?", "_MadeLanding");
_MadeLanding = false;
nameMap.set("Actor", "actor");
nameMap.set("Landing friction", "_Landingfriction");
_Landingfriction = 0.0;
nameMap.set("Normal friction", "_Normalfriction");
_Normalfriction = 0.0;
nameMap.set("Prevent Landing?", "_PreventLanding");
_PreventLanding = false;
nameMap.set("Big Landing Friction", "_BigLandingFriction");
_BigLandingFriction = 0.0;

	}
	
	override public function init()
	{
		            /* "Inputs:" */
        /* "\"Facing Right?\" -- <Boolean> Actor Level Attribute, from \"Walking\" Behavior (required)" */
        /* "Outputs:" */
        /* "none" */
        _FrameCount = asNumber(0);
propertyChanged("_FrameCount", _FrameCount);
        _OldY = asNumber(0);
propertyChanged("_OldY", _OldY);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_PreventLanding)
{
            return;
}

        /* "Custom: Check landing movement" */
        /* "check every other frame to prevent false positives" */
        if((_FrameCount == 0))
{
            _FrameCount = asNumber(1);
propertyChanged("_FrameCount", _FrameCount);
            return;
}

        _FrameCount = asNumber(0);
propertyChanged("_FrameCount", _FrameCount);
        _NewY = asNumber(actor.getY());
propertyChanged("_NewY", _NewY);
        if((_NewY > _OldY))
{
            if((_NewY < _TopOfFall))
{
                _TopOfFall = asNumber(_NewY);
propertyChanged("_TopOfFall", _TopOfFall);
}

            _WasFalling = true;
propertyChanged("_WasFalling", _WasFalling);
}

        else if(((_NewY == _OldY) && _WasFalling))
{
            _MadeLanding = true;
propertyChanged("_MadeLanding", _MadeLanding);
            _WasFalling = false;
propertyChanged("_WasFalling", _WasFalling);
            if((_BigLandingThreshold > 0))
{
                _MadeBigLanding = ((_NewY - _TopOfFall) >= _BigLandingThreshold);
propertyChanged("_MadeBigLanding", _MadeBigLanding);
}

            if(actor.getActorValue("Facing Right?"))
{
                if(_MadeBigLanding)
{
                    /* "Custom: Play <Big Landing Right> Once for Self" */
                    actor.say("Animation Manager", "_customBlock_PlayOnce", [_BigLandingRight]);
}

                else
{
                    /* "Custom: Play <Normal Landing Right> Once for Self" */
                    actor.say("Animation Manager", "_customBlock_PlayOnce", [_NormalLandingRight]);
}

}

            else
{
                if(_MadeBigLanding)
{
                    /* "Custom: Play <Big Landing Left> Once for Self" */
                    actor.say("Animation Manager", "_customBlock_PlayOnce", [_BigLandingLeft]);
}

                else
{
                    /* "Custom: Play <Normal Landing Left> Once for Self" */
                    actor.say("Animation Manager", "_customBlock_PlayOnce", [_NormalLandingLeft]);
}

}

            _TopOfFall = asNumber(1000000);
propertyChanged("_TopOfFall", _TopOfFall);
}

        else if((_WasFalling == true))
{
            _WasFalling = false;
propertyChanged("_WasFalling", _WasFalling);
            _TopOfFall = asNumber(1000000);
propertyChanged("_TopOfFall", _TopOfFall);
}

        _OldY = asNumber(_NewY);
propertyChanged("_OldY", _OldY);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}