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



class Design_51_51_WindmillArmPM extends ActorScript
{          	
	
public var _XOffset:Float;

public var _YOffset:Float;

public var _Radius:Float;

public var _Pivot:Actor;

public var _TargetX:Float;

public var _TargetY:Float;

public var _MoveTarget:Actor;

public var _WasInitialised:Bool;

public var _StartAngle:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("X Offset", "_XOffset");
_XOffset = 0.0;
nameMap.set("Y Offset", "_YOffset");
_YOffset = 0.0;
nameMap.set("Radius", "_Radius");
_Radius = 0.0;
nameMap.set("Pivot", "_Pivot");
nameMap.set("Target X", "_TargetX");
_TargetX = 0.0;
nameMap.set("Target Y", "_TargetY");
_TargetY = 0.0;
nameMap.set("Move Target", "_MoveTarget");
nameMap.set("Was Initialised?", "_WasInitialised");
_WasInitialised = false;
nameMap.set("Start Angle", "_StartAngle");
_StartAngle = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((hasValue(_MoveTarget) != false))
{
            _TargetX = asNumber((_Pivot.getXCenter() + (Math.sin((Utils.RAD * (Utils.DEG * (_Pivot.getAngle())) + _StartAngle)) * _Radius)));
propertyChanged("_TargetX", _TargetX);
            _TargetY = asNumber((_Pivot.getYCenter() + (Math.cos((Utils.RAD * (Utils.DEG * (_Pivot.getAngle())) + _StartAngle)) * _Radius)));
propertyChanged("_TargetY", _TargetY);
            _MoveTarget.setX(_TargetX);
            _MoveTarget.setY(_TargetY);
}

        else if((hasValue(_Pivot) != false))
{
            if(!(_WasInitialised))
{
                _WasInitialised = true;
propertyChanged("_WasInitialised", _WasInitialised);
                runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                            /* "Custom: distance between <Pivot> and Self" */
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

}, actor);
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}