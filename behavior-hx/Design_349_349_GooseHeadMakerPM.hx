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

public var _StartXPosition:Float;

public var _StartYOffset:Float;

public var _MovementX:Float;

public var _StartYPosition:Float;

public var _ReadyToGenerate:Bool;

public var _ReadyToRemove:Bool;

public var _MovementY:Float;

public var _ReactivateAfterTime:Float;

public var _LastPieceWasBend:Bool;

public var _IsFlipped:Bool;
    

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
            _XTotal = asNumber(8);
propertyChanged("_XTotal", _XTotal);
            _YTotal = asNumber(0);
propertyChanged("_YTotal", _YTotal);
}

        else if((_StartAngle == 90))
{
            _XTotal = asNumber(0);
propertyChanged("_XTotal", _XTotal);
            _YTotal = asNumber(8);
propertyChanged("_YTotal", _YTotal);
}

        else if((_StartAngle == 180))
{
            _XTotal = asNumber(-8);
propertyChanged("_XTotal", _XTotal);
            _YTotal = asNumber(0);
propertyChanged("_YTotal", _YTotal);
}

        else if((_StartAngle == 270))
{
            _XTotal = asNumber(0);
propertyChanged("_XTotal", _XTotal);
            _YTotal = asNumber(-8);
propertyChanged("_YTotal", _YTotal);
}

        runPeriodically(1000 * _GenerateTime, function(timeTask:TimedTask):Void {
                    if((_State == "Making"))
{
                        _ReadyToGenerate = true;
propertyChanged("_ReadyToGenerate", _ReadyToGenerate);
}

                    else if((_State == "Removing"))
{
                        _ReadyToRemove = true;
propertyChanged("_ReadyToRemove", _ReadyToRemove);
}

                    else if((_State == "Waiting"))
{
                        /* "Do nothing" */
}

                    else
{
                        actor.say("Goose Head Maker PM", "_customBlock_TriggerEvent", ["GooseHeadRemoved"]);
                        if((_ReactivateAfterTime > -1))
{
                            if((_ReactivateAfterTime == 0))
{
                                _IsActive = true;
propertyChanged("_IsActive", _IsActive);
                                actor.say("Goose Head Maker PM", "_customBlock_Start");
}

                            else
{
                                runLater(1000 * _ReactivateAfterTime, function(timeTask:TimedTask):Void {
                                            _IsActive = true;
propertyChanged("_IsActive", _IsActive);
                                            actor.say("Goose Head Maker PM", "_customBlock_Start");
}, actor);
}

}

                        timeTask.repeats = false;
return;
}

}, actor);
}
    

/* Params are:__Self __CurrentAngle __ChangeAngle */
public function _customBlock_ChangeAngle(__CurrentAngle:Float, __ChangeAngle:Float):Float
{
var __Self:Actor = actor;
        var prevAngle = __CurrentAngle;
__CurrentAngle += __ChangeAngle;
while (__CurrentAngle >= 360)
{
	__CurrentAngle -= 360;
}

while (__CurrentAngle < 0)
{
	__CurrentAngle += 360;
}

if (__CurrentAngle == 90 && _YTotal >= -16)
{
	if (prevAngle == 0 || prevAngle == 180)
	{
		if (Math.random() < 0.5) __CurrentAngle = prevAngle;
		else __CurrentAngle = 270;
	}
	else {
		if (Math.random() < 0.5) __CurrentAngle = 0;
		else __CurrentAngle = 180;
	}
}
return __CurrentAngle;

}
    

/* Params are:__Self */
public function _customBlock_CreateCurve():Actor
{
var __Self:Actor = actor;
        if((_CurrentAngle == _EndAngle))
{
            if(((_CurrentAngle == 90) || (_CurrentAngle == 270)))
{
                createRecycledActor(getActorType(752), (actor.getX() + _XTotal), (actor.getY() + _YTotal), Script.FRONT);
}

            else
{
                createRecycledActor(getActorType(662), (actor.getX() + _XTotal), (actor.getY() + _YTotal), Script.FRONT);
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
        return getLastCreatedActor();
}
    

/* Params are:__Self */
public function _customBlock_UpdatePositions():Void
{
var __Self:Actor = actor;
        actor.say("Goose Head Maker PM", "_customBlock_UpdateOffsets");
        if((_EndAngle == 0))
{
            _HeadOffsetX = asNumber(-19);
propertyChanged("_HeadOffsetX", _HeadOffsetX);
            if(_IsFlipped)
{
                _HeadOffsetY = asNumber(-16);
propertyChanged("_HeadOffsetY", _HeadOffsetY);
}

            else
{
                _HeadOffsetY = asNumber(-32);
propertyChanged("_HeadOffsetY", _HeadOffsetY);
}

}

        else if((_EndAngle == 90))
{
            if(_IsFlipped)
{
                _HeadOffsetX = asNumber(-32);
propertyChanged("_HeadOffsetX", _HeadOffsetX);
}

            else
{
                _HeadOffsetX = asNumber(-16);
propertyChanged("_HeadOffsetX", _HeadOffsetX);
}

            _HeadOffsetY = asNumber(-19);
propertyChanged("_HeadOffsetY", _HeadOffsetY);
}

        else if((_EndAngle == 180))
{
            _HeadOffsetX = asNumber(-29);
propertyChanged("_HeadOffsetX", _HeadOffsetX);
            if(_IsFlipped)
{
                _HeadOffsetY = asNumber(-32);
propertyChanged("_HeadOffsetY", _HeadOffsetY);
}

            else
{
                _HeadOffsetY = asNumber(-16);
propertyChanged("_HeadOffsetY", _HeadOffsetY);
}

}

        else
{
            if(_IsFlipped)
{
                _HeadOffsetX = asNumber(-16);
propertyChanged("_HeadOffsetX", _HeadOffsetX);
}

            else
{
                _HeadOffsetX = asNumber(-32);
propertyChanged("_HeadOffsetX", _HeadOffsetX);
}

            _HeadOffsetY = asNumber(-29);
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
                _XOffset += 16;
propertyChanged("_XOffset", _XOffset);
}

            else if((_CurrentAngle == 90))
{
                _YOffset += 16;
propertyChanged("_YOffset", _YOffset);
}

            else if((_CurrentAngle == 180))
{
                _XOffset -= 16;
propertyChanged("_XOffset", _XOffset);
}

            else if((_CurrentAngle == 270))
{
                _YOffset -= 16;
propertyChanged("_YOffset", _YOffset);
}

}

        else
{
            if((_EndAngle == 0))
{
                _XOffset += 16;
propertyChanged("_XOffset", _XOffset);
}

            else if((_EndAngle == 90))
{
                _YOffset += 16;
propertyChanged("_YOffset", _YOffset);
}

            else if((_EndAngle == 180))
{
                _XOffset -= 16;
propertyChanged("_XOffset", _XOffset);
}

            else if((_EndAngle == 270))
{
                _YOffset -= 16;
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
            createRecycledActor(getActorType(660), ((actor.getX() + _XTotal) - 32), ((actor.getY() + _YTotal) - 19), Script.FRONT);
            _Head = getLastCreatedActor();
propertyChanged("_Head", _Head);
            _Head.setAngle(Utils.RAD * (_StartAngle));
            _Pipes.push(_Head);
            _OffsetsX.push((_Head.getX() - actor.getX()));
            _OffsetsY.push((_Head.getY() - actor.getY()));
            _HeadRotations.push(Utils.DEG * (_Head.getAngle()));
            if((randomFloat() < 0.5))
{
                _IsFlipped = true;
propertyChanged("_IsFlipped", _IsFlipped);
                _Head.growTo(100/100, -100/100, 0, Linear.easeNone);
}

            else
{
                _IsFlipped = false;
propertyChanged("_IsFlipped", _IsFlipped);
                _Head.growTo(100/100, 100/100, 0, Linear.easeNone);
}

}

        if(!(_LastPieceWasBend))
{
            _AngleIndex = asNumber(randomInt(Math.floor(0), Math.floor(2)));
propertyChanged("_AngleIndex", _AngleIndex);
            if((_AngleIndex == 0))
{
                _EndAngle = asNumber(cast((actor.say("Goose Head Maker PM", "_customBlock_ChangeAngle", [_CurrentAngle,-90])), Float));
propertyChanged("_EndAngle", _EndAngle);
                _LastPieceWasBend = true;
propertyChanged("_LastPieceWasBend", _LastPieceWasBend);
}

            else if((_AngleIndex == 1))
{
                _EndAngle = asNumber(cast((actor.say("Goose Head Maker PM", "_customBlock_ChangeAngle", [_CurrentAngle,90])), Float));
propertyChanged("_EndAngle", _EndAngle);
                _LastPieceWasBend = true;
propertyChanged("_LastPieceWasBend", _LastPieceWasBend);
}

            else
{
                _EndAngle = asNumber(_CurrentAngle);
propertyChanged("_EndAngle", _EndAngle);
}

}

        else
{
            _LastPieceWasBend = false;
propertyChanged("_LastPieceWasBend", _LastPieceWasBend);
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
        _OffsetsX.push((_Head.getX() - actor.getX()));
        _OffsetsY.push((_Head.getY() - actor.getY()));
        _HeadRotations.push(Utils.DEG * (_Head.getAngle()));
        if((_CurrentNumberOfSegments == _NumberOfSegments))
{
            if(!isPrimitive(_Pipe)) {_Pipe = getDefaultValue(_Pipe);}
            _State = "Waiting";
propertyChanged("_State", _State);
            actor.say("Goose Head Maker PM", "_customBlock_TriggerEvent", ["GooseHeadComplete"]);
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
        _Head.setX((actor.getX() + _XOffset));
        _Head.setY((actor.getY() + _YOffset));
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
            actor.say("Goose Head Maker PM", "_customBlock_Start");
}

}

    public function _customEvent_Deactivate():Void
{
        _IsActive = false;
propertyChanged("_IsActive", _IsActive);
}

    

/* Params are:__Self __EventName */
public function _customBlock_TriggerEvent(__EventName:String):Void
{
var __Self:Actor = actor;
        /* "replace \" \" with \"\"" */
        shoutToScene("_customEvent_" + (("" + (("" + StringTools.replace(("" + "" + (scripts.Design_27_27_ActorExtrasPM._customBlock_SceneNameForActor(actor))), ("" + " "), ("" + ""))) + ("" + "_"))) + ("" + __EventName)));
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
nameMap.set("Start X Position", "_StartXPosition");
_StartXPosition = 0.0;
nameMap.set("Start Y Offset", "_StartYOffset");
_StartYOffset = 0.0;
nameMap.set("Movement X", "_MovementX");
_MovementX = 0.0;
nameMap.set("Start Y Position", "_StartYPosition");
_StartYPosition = 0.0;
nameMap.set("Ready To Generate?", "_ReadyToGenerate");
_ReadyToGenerate = false;
nameMap.set("Ready To Remove?", "_ReadyToRemove");
_ReadyToRemove = false;
nameMap.set("Movement Y", "_MovementY");
_MovementY = 0.0;
nameMap.set("Reactivate After Time", "_ReactivateAfterTime");
_ReactivateAfterTime = 0.0;
nameMap.set("Last Piece Was Bend?", "_LastPieceWasBend");
_LastPieceWasBend = false;
nameMap.set("Is Flipped?", "_IsFlipped");
_IsFlipped = false;

	}
	
	override public function init()
	{
		            actor.disableActorDrawing();
        _State = "Inactive";
propertyChanged("_State", _State);
        _StartXPosition = asNumber(actor.getX());
propertyChanged("_StartXPosition", _StartXPosition);
        _StartYPosition = asNumber(actor.getY());
propertyChanged("_StartYPosition", _StartYPosition);
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
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _MovementX = asNumber((actor.getX() - _StartXPosition));
propertyChanged("_MovementX", _MovementX);
        _MovementY = asNumber((actor.getY() - _StartYPosition));
propertyChanged("_MovementY", _MovementY);
        for(item in cast(_Pipes, Array<Dynamic>))
{
            item.setX((item.getX() + _MovementX));
            item.setY((item.getY() + _MovementY));
}

        _StartXPosition = asNumber(actor.getX());
propertyChanged("_StartXPosition", _StartXPosition);
        _StartYPosition = asNumber(actor.getY());
propertyChanged("_StartYPosition", _StartYPosition);
        if(_ReadyToGenerate)
{
            actor.say("Goose Head Maker PM", "_customBlock_Generate");
}

        else if(_ReadyToRemove)
{
            actor.say("Goose Head Maker PM", "_customBlock_Remove");
}

        _ReadyToGenerate = false;
propertyChanged("_ReadyToGenerate", _ReadyToGenerate);
        _ReadyToRemove = false;
propertyChanged("_ReadyToRemove", _ReadyToRemove);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}