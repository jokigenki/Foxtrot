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



class Design_56_56_PivotPM extends ActorScript
{          	
	
public var _IsActive:Bool;

public var _EngineForce:Float;

public var _LiftType:ActorType;

public var _Lifts:Array<Dynamic>;

public var _NumberOfLifts:Float;

public var _LiftAngleGap:Float;

public var _Radius:Float;

public var _AngleOffset:Float;

public var _Lift:Actor;

public var _XPos:Float;

public var _YPos:Float;

public var _Count:Float;

public var _Angle:Float;
    

/* Params are:__Self */
public function _customBlock_PrecalcPositions():Void
{
var __Self:Actor = actor;

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Engine Force", "_EngineForce");
_EngineForce = 0.0;
nameMap.set("Lift Type", "_LiftType");
_LiftType = getActorType(616);
nameMap.set("Lifts", "_Lifts");
_Lifts = [];
nameMap.set("Number Of Lifts", "_NumberOfLifts");
_NumberOfLifts = 4.0;
nameMap.set("Lift Angle Gap", "_LiftAngleGap");
_LiftAngleGap = 0.0;
nameMap.set("Radius", "_Radius");
_Radius = 0.0;
nameMap.set("Angle Offset", "_AngleOffset");
_AngleOffset = 0.0;
nameMap.set("Lift", "_Lift");
nameMap.set("X Pos", "_XPos");
_XPos = 0.0;
nameMap.set("Y Pos", "_YPos");
_YPos = 0.0;
nameMap.set("Count", "_Count");
_Count = 0.0;
nameMap.set("Angle", "_Angle");
_Angle = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            actor.disableActorDrawing();
        _Lifts = new Array<Dynamic>();
propertyChanged("_Lifts", _Lifts);
        _LiftAngleGap = asNumber(((Math.PI * 2) / _NumberOfLifts));
propertyChanged("_LiftAngleGap", _LiftAngleGap);
        for(index0 in 0...Std.int(_NumberOfLifts))
{
            _Angle = asNumber(((_LiftAngleGap * index0) + Utils.RAD * (_AngleOffset)));
propertyChanged("_Angle", _Angle);
            _XPos = asNumber((Math.sin(_Angle) * _Radius));
propertyChanged("_XPos", _XPos);
            _YPos = asNumber((Math.cos(_Angle) * _Radius));
propertyChanged("_YPos", _YPos);
            createRecycledActor(_LiftType, (actor.getXCenter() + _XPos), (actor.getYCenter() + _YPos), Script.FRONT);
            _Lift = getLastCreatedActor();
propertyChanged("_Lift", _Lift);
            _Lift.setX((_Lift.getX() - _Lift.getWidth()/2));
            _Lift.setY((_Lift.getY() - _Lift.getHeight()/2));
            _Lift.moveToLayer(actor.getLayerID());
            _Lifts.push(_Lift);
}

        _Count = asNumber(0);
propertyChanged("_Count", _Count);
        for(item in cast(_Lifts, Array<Dynamic>))
{
            _Angle = asNumber(((_LiftAngleGap * _Count) + Utils.RAD * (_AngleOffset)));
propertyChanged("_Angle", _Angle);
            item.setValue("Windmill Arm PM", "_Radius", _Radius);
            item.setValue("Windmill Arm PM", "_StartAngle", _Angle);
            item.setValue("Windmill Arm PM", "_Pivot", actor);
            _Count += 1;
propertyChanged("_Count", _Count);
}

    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_IsActive)
{
            actor.setAngularVelocity(Utils.RAD * (_EngineForce));
}

        else
{
            actor.setAngularVelocity(Utils.RAD * (0));
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}