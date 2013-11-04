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



class Design_349_349_GooseHeadMakerPM extends ActorScript
{          	
	
public var _StartAngle:Float;

public var _GenerateTime:Float;

public var _NumberOfSegments:Float;

public var _MaxNumberOfSegments:Float;

public var _CurrentNumberOfSegments:Float;

public var _EndAngle:Float;

public var _AngleIndex:Float;

public var _XOffset:Float;

public var _YOffset:Float;

public var _Pipe:Actor;

public var _Head:Actor;

public var _Pipes:Array<Dynamic>;

public var _XTotal:Float;

public var _YTotal:Float;

public var _HeadOffsetX:Float;

public var _MinNumberOfSegments:Float;

public var _State:String;

public var _HeadOffsetY:Float;

public var _TimeBeforeRemoving:Float;

public var _IsActive:Bool;

public var _OffsetsY:Array<Dynamic>;

public var _OffsetsX:Array<Dynamic>;

public var _HeadRotations:Array<Dynamic>;

public var _NumberOfPipes:Float;

public var _StartOffsetX:Float;

public var _CurrentAngle:Float;

public var _StartYOffset:Float;
    

/* Params are: */
public function _customBlock_Start():Void
{
var __Self:Actor = actor;
        _CurrentNumberOfSegments = asNumber(0);
propertyChanged("_CurrentNumberOfSegments", _CurrentNumberOfSegments);
        _NumberOfSegments = asNumber(randomInt(Math.floor(_MinNumberOfSegments), Math.floor(_MaxNumberOfSegments)));
propertyChanged("_NumberOfSegments", _NumberOfSegments);
        _State = "Making";
propertyChanged("_State", _State);
        _XOffset = asNumber(0);
propertyChanged("_XOffset", _XOffset);
        _YOffset = asNumber(0);
propertyChanged("_YOffset", _YOffset);
        _Pipes = new Array<Dynamic>();
propertyChanged("_Pipes", _Pipes);
        _OffsetsX = new Array<Dynamic>();
propertyChanged("_OffsetsX", _OffsetsX);
        _OffsetsY = new Array<Dynamic>();
propertyChanged("_OffsetsY", _OffsetsY);
        _HeadRotations = new Array<Dynamic>();
propertyChanged("_HeadRotations", _HeadRotations);
        _CurrentAngle = asNumber(_StartAngle);
propertyChanged("_CurrentAngle", _CurrentAngle);
        if((_StartAngle == 0))
{
            _XTotal = asNumber(16);
propertyChanged("_XTotal", _XTotal);
            _YTotal = asNumber(0);
propertyChanged("_YTotal", _YTotal);
}

        else if((_StartAngle == 90))
{
            _XTotal = asNumber(0);
propertyChanged("_XTotal", _XTotal);
            _YTotal = asNumber(16);
propertyChanged("_YTotal", _YTotal);
}

        else if((_StartAngle == 180))
{
            _XTotal = asNumber(-16);
propertyChanged("_XTotal", _XTotal);
            _YTotal = asNumber(0);
propertyChanged("_YTotal", _YTotal);
}

        else if((_StartAngle == 270))
{
            _XTotal = asNumber(0);
propertyChanged("_XTotal", _XTotal);
            _YTotal = asNumber(-16);
propertyChanged("_YTotal", _YTotal);
}

        runPeriodically(1000 * _GenerateTime, function(timeTask:TimedTask):Void {
                    if((_State == "Making"))
{
                        actor.say("Goose Head Maker PM", "_customBlock_Generate");
}

                    else if((_State == "Removing"))
{
                        actor.say("Goose Head Maker PM", "_customBlock_Remove");
}

                    else if((_State == "Waiting"))
{
                        /* "Do nothing" */
}

                    else
{
                        shoutToScene("_customEvent_" + "GooseHeadRemoved");
                        timeTask.repeats = false;
return;
}

}, actor);
}
    

/* Params are:__Self __CurrentAngle __ChangeAngle */
public function _customBlock_ChangeAngle(__CurrentAngle:Float, __ChangeAngle:Float):Float
{
var __Self:Actor = actor;
        __CurrentAngle += __ChangeAngle;
while (__CurrentAngle >= 360)
{
	__CurrentAngle -= 360;
}

while (__CurrentAngle < 0)
{
	__CurrentAngle += 360;
}

return __CurrentAngle;

}
    

/* Params are:__Self */
public function _customBlock_CreateCurve():Actor
{
var __Self:Actor = actor;
        if((_CurrentAngle == _EndAngle))
{
            createRecycledActor(getActorType(662), (actor.getX() + _XTotal), (actor.getY() + _YTotal), Script.FRONT);
            if(((_CurrentAngle == 90) || (_CurrentAngle == 270)))
{
                getLastCreatedActor().setAngle(Utils.RAD * (90));
}

}

        else
{
            if((((_CurrentAngle == 270) && (_EndAngle == 0)) || ((_CurrentAngle == 180) && (_EndAngle == 90))))
{
                createRecycledActor(getActorType(664), (actor.getX() + _XTotal), (actor.getY() + _YTotal), Script.FRONT);
}

            else if((((_CurrentAngle == 270) && (_EndAngle == 180)) || ((_CurrentAngle == 0) && (_EndAngle == 90))))
{
                createRecycledActor(getActorType(680), (actor.getX() + _XTotal), (actor.getY() + _YTotal), Script.FRONT);
}

            else if((((_CurrentAngle == 90) && (_EndAngle == 0)) || ((_CurrentAngle == 180) && (_EndAngle == 270))))
{
                createRecycledActor(getActorType(682), (actor.getX() + _XTotal), (actor.getY() + _YTotal), Script.FRONT);
}

            else if((((_CurrentAngle == 0) && (_EndAngle == 270)) || ((_CurrentAngle == 90) && (_EndAngle == 180))))
{
                createRecycledActor(getActorType(684), (actor.getX() + _XTotal), (actor.getY() + _YTotal), Script.FRONT);
}

}

        getLastCreatedActor().moveToLayer(_Head.getLayerID());
        getLastCreatedActor().sendBackward();
        return getLastCreatedActor();
}
    

/* Params are:__Self */
public function _customBlock_UpdatePositions():Void
{
var __Self:Actor = actor;
        if((randomFloat() < 0.5))
{
            _Head.growTo(100/100, -100/100, 0, Linear.easeNone);
}

        else
{
            _Head.growTo(100/100, 100/100, 0, Linear.easeNone);
}

        actor.say("Goose Head Maker PM", "_customBlock_UpdateOffsets");
        if((_EndAngle == 180))
{
            _HeadOffsetX = asNumber(-13);
propertyChanged("_HeadOffsetX", _HeadOffsetX);
}

        else
{
            _HeadOffsetX = asNumber(-19);
propertyChanged("_HeadOffsetX", _HeadOffsetX);
}

        if((_EndAngle == 270))
{
            _HeadOffsetY = asNumber(-13);
propertyChanged("_HeadOffsetY", _HeadOffsetY);
}

        else
{
            _HeadOffsetY = asNumber(-19);
propertyChanged("_HeadOffsetY", _HeadOffsetY);
}

        _Head.setX(((actor.getX() + _XTotal) + _HeadOffsetX));
        _Head.setY(((actor.getY() + _YTotal) + _HeadOffsetY));
        _Head.setAngle(Utils.RAD * (_EndAngle));
}
    

/* Params are:__Self */
public function _customBlock_UpdateOffsets():Void
{
var __Self:Actor = actor;
        _XOffset = asNumber(0);
propertyChanged("_XOffset", _XOffset);
        _YOffset = asNumber(0);
propertyChanged("_YOffset", _YOffset);
        if((_CurrentAngle == _EndAngle))
{
            if((_CurrentAngle == 0))
{
                _XOffset += 32;
propertyChanged("_XOffset", _XOffset);
}

            else if((_CurrentAngle == 90))
{
                _YOffset += 32;
propertyChanged("_YOffset", _YOffset);
}

            else if((_CurrentAngle == 180))
{
                _XOffset -= 32;
propertyChanged("_XOffset", _XOffset);
}

            else if((_CurrentAngle == 270))
{
                _YOffset -= 32;
propertyChanged("_YOffset", _YOffset);
}

}

        else
{
            if((_EndAngle == 0))
{
                _XOffset += 32;
propertyChanged("_XOffset", _XOffset);
}

            else if((_EndAngle == 90))
{
                _YOffset += 32;
propertyChanged("_YOffset", _YOffset);
}

            else if((_EndAngle == 180))
{
                _XOffset -= 32;
propertyChanged("_XOffset", _XOffset);
}

            else if((_EndAngle == 270))
{
                _YOffset -= 32;
propertyChanged("_YOffset", _YOffset);
}

}

        _XTotal += _XOffset;
propertyChanged("_XTotal", _XTotal);
        _YTotal += _YOffset;
propertyChanged("_YTotal", _YTotal);
}
    

/* Params are: */
public function _customBlock_Generate():Void
{
var __Self:Actor = actor;
        if((hasValue(_Head) == false))
{
            createRecycledActor(getActorType(660), ((actor.getX() + _XTotal) - 19), ((actor.getY() + _YTotal) - 19), Script.FRONT);
            _Head = getLastCreatedActor();
propertyChanged("_Head", _Head);
            _Head.setAngle(Utils.RAD * (_StartAngle));
            _Pipes.push(_Head);
            _OffsetsX.push(_Head.getX());
            _OffsetsY.push(_Head.getY());
            _HeadRotations.push(Utils.DEG * (_Head.getAngle()));
}

        _AngleIndex = asNumber(randomInt(Math.floor(0), Math.floor(2)));
propertyChanged("_AngleIndex", _AngleIndex);
        if((_AngleIndex == 0))
{
            _EndAngle = asNumber(cast((actor.say("Goose Head Maker PM", "_customBlock_ChangeAngle", [_CurrentAngle,-90])), Float));
propertyChanged("_EndAngle", _EndAngle);
}

        else if((_AngleIndex == 1))
{
            _EndAngle = asNumber(cast((actor.say("Goose Head Maker PM", "_customBlock_ChangeAngle", [_CurrentAngle,90])), Float));
propertyChanged("_EndAngle", _EndAngle);
}

        else
{
            _EndAngle = asNumber(_CurrentAngle);
propertyChanged("_EndAngle", _EndAngle);
}

        _Pipe = cast((actor.say("Goose Head Maker PM", "_customBlock_CreateCurve")), Actor);
propertyChanged("_Pipe", _Pipe);
        actor.say("Goose Head Maker PM", "_customBlock_UpdatePositions");
        _CurrentAngle = asNumber(_EndAngle);
propertyChanged("_CurrentAngle", _CurrentAngle);
        _CurrentNumberOfSegments += 1;
propertyChanged("_CurrentNumberOfSegments", _CurrentNumberOfSegments);
        _Pipes.push(_Pipe);
        _OffsetsX.push(_Head.getX());
        _OffsetsY.push(_Head.getY());
        _HeadRotations.push(Utils.DEG * (_Head.getAngle()));
        if((_CurrentNumberOfSegments == _NumberOfSegments))
{
            if(!isPrimitive(_Pipe)) {_Pipe = getDefaultValue(_Pipe);}
            _State = "Waiting";
propertyChanged("_State", _State);
            shoutToScene("_customEvent_" + "GooseHeadComplete");
            runLater(1000 * _TimeBeforeRemoving, function(timeTask:TimedTask):Void {
                        _State = "Removing";
propertyChanged("_State", _State);
}, actor);
}

}
    

/* Params are: */
public function _customBlock_Remove():Void
{
var __Self:Actor = actor;
        if((hasValue(_Pipe) != false))
{
            recycleActor(_Pipe);
}

        _Pipe = _Pipes[Std.int(_CurrentNumberOfSegments)];
propertyChanged("_Pipe", _Pipe);
        _XOffset = asNumber(_OffsetsX[Std.int(_CurrentNumberOfSegments)]);
propertyChanged("_XOffset", _XOffset);
        _YOffset = asNumber(_OffsetsY[Std.int(_CurrentNumberOfSegments)]);
propertyChanged("_YOffset", _YOffset);
        _Head.setX(_XOffset);
        _Head.setY(_YOffset);
        _Head.setAngle(Utils.RAD * (_HeadRotations[Std.int(_CurrentNumberOfSegments)]));
        _CurrentNumberOfSegments -= 1;
propertyChanged("_CurrentNumberOfSegments", _CurrentNumberOfSegments);
        if((_CurrentNumberOfSegments == -1))
{
            recycleActor(_Head);
            if(!isPrimitive(_Head)) {_Head = getDefaultValue(_Head);}
            _State = "Inactive";
propertyChanged("_State", _State);
            _IsActive = false;
propertyChanged("_IsActive", _IsActive);
}

}
    public function _customEvent_Activate():Void
{
        if(_IsActive)
{
            return;
}

        _IsActive = true;
propertyChanged("_IsActive", _IsActive);
        if((_State == "Inactive"))
{
            _State = "Making";
propertyChanged("_State", _State);
            actor.say("Goose Head Maker PM", "_customBlock_Start");
}

}

    public function _customEvent_Deactivate():Void
{
        _IsActive = false;
propertyChanged("_IsActive", _IsActive);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Start Angle", "_StartAngle");
_StartAngle = 0.0;
nameMap.set("Generate Time", "_GenerateTime");
_GenerateTime = 0.5;
nameMap.set("Number Of Segments", "_NumberOfSegments");
_NumberOfSegments = 0.0;
nameMap.set("Max Number Of Segments", "_MaxNumberOfSegments");
_MaxNumberOfSegments = 5.0;
nameMap.set("Current Number Of Segments", "_CurrentNumberOfSegments");
_CurrentNumberOfSegments = 0.0;
nameMap.set("End Angle", "_EndAngle");
_EndAngle = 0.0;
nameMap.set("Angle Index", "_AngleIndex");
_AngleIndex = 0.0;
nameMap.set("X Offset", "_XOffset");
_XOffset = 0.0;
nameMap.set("Y Offset", "_YOffset");
_YOffset = 0.0;
nameMap.set("Pipe", "_Pipe");
nameMap.set("Head", "_Head");
nameMap.set("Pipes", "_Pipes");
_Pipes = [];
nameMap.set("X Total", "_XTotal");
_XTotal = 0.0;
nameMap.set("Actor", "actor");
nameMap.set("Y Total", "_YTotal");
_YTotal = 0.0;
nameMap.set("Head Offset X", "_HeadOffsetX");
_HeadOffsetX = 0.0;
nameMap.set("Min Number Of Segments", "_MinNumberOfSegments");
_MinNumberOfSegments = 3.0;
nameMap.set("State", "_State");
_State = "";
nameMap.set("Head Offset Y", "_HeadOffsetY");
_HeadOffsetY = 0.0;
nameMap.set("Time Before Removing", "_TimeBeforeRemoving");
_TimeBeforeRemoving = 2.0;
nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Offsets Y", "_OffsetsY");
_OffsetsY = [];
nameMap.set("Offsets X", "_OffsetsX");
_OffsetsX = [];
nameMap.set("Head Rotations", "_HeadRotations");
_HeadRotations = [];
nameMap.set("Number Of Pipes", "_NumberOfPipes");
_NumberOfPipes = 0.0;
nameMap.set("Start Offset X", "_StartOffsetX");
_StartOffsetX = 0.0;
nameMap.set("Current Angle", "_CurrentAngle");
_CurrentAngle = 0.0;
nameMap.set("Start Y Offset", "_StartYOffset");
_StartYOffset = 0.0;

	}
	
	override public function init()
	{
		            _State = "Inactive";
propertyChanged("_State", _State);
        if(_IsActive)
{
            actor.say("Goose Head Maker PM", "_customBlock_Start");
}

    addWhenKilledListener(actor, function(list:Array<Dynamic>):Void {
if(wrapper.enabled){
        for(item in cast(_Pipes, Array<Dynamic>))
{
            item.say("Bump Out PM", "_customEvent_" + "Killed");
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}