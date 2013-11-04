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

public var _IsGenerating:Bool;

public var _Head:Actor;

public var _Pipes:Array<Dynamic>;
    

/* Params are:__Self */
public function _customBlock_UpdatePositions():Void
{
var __Self:Actor = actor;
        if((_StartAngle == _EndAngle))
{
            if((_StartAngle == 0))
{
                _Head.setX((_Head.getX() + 32));
                _Head.setAngle(Utils.RAD * (0));
                _XOffset += 32;
propertyChanged("_XOffset", _XOffset);
}

            else if((_StartAngle == 90))
{
                _Head.setY((_Head.getY() + 32));
                _Head.setAngle(Utils.RAD * (90));
                if((hasValue(_Pipe) != false))
{
                    _Pipe.setAngle(Utils.RAD * (90));
}

                _YOffset += 32;
propertyChanged("_YOffset", _YOffset);
}

            else if((_StartAngle == 180))
{
                _Head.setX((_Head.getX() - 32));
                _Head.setAngle(Utils.RAD * (180));
                if((hasValue(_Pipe) != false))
{
                    _Pipe.setAngle(Utils.RAD * (180));
}

                _XOffset -= 32;
propertyChanged("_XOffset", _XOffset);
}

            else if((_StartAngle == 270))
{
                _Head.setY((_Head.getY() - 32));
                _Head.setAngle(Utils.RAD * (270));
                if((hasValue(_Pipe) != false))
{
                    _Pipe.setAngle(Utils.RAD * (270));
}

                _YOffset -= 32;
propertyChanged("_YOffset", _YOffset);
}

}

        else
{
            trace("" + (("" + _StartAngle) + ("" + (("" + ":") + ("" + _EndAngle)))));
            if((_EndAngle == 0))
{
                if((_StartAngle == 0))
{
                    _Pipe.setAngle(Utils.RAD * (270));
}

                _XOffset += 16;
propertyChanged("_XOffset", _XOffset);
}

            else if((_EndAngle == 90))
{
                if((_StartAngle == 0))
{
                    _Pipe.setAngle(Utils.RAD * (90));
}

                _YOffset += 16;
propertyChanged("_YOffset", _YOffset);
}

            else if((_EndAngle == 180))
{
                if((_StartAngle == 90))
{
                    _Pipe.setAngle(Utils.RAD * (180));
}

                else if((_EndAngle == 270))
{
                    _Pipe.setAngle(Utils.RAD * (90));
}

                _XOffset -= 16;
propertyChanged("_XOffset", _XOffset);
}

            else if((_EndAngle == 270))
{
                if((_StartAngle == 0))
{
                    _Pipe.setAngle(Utils.RAD * (180));
}

                else if((_StartAngle == 180))
{
                    _Pipe.setAngle(Utils.RAD * (270));
}

                _YOffset -= 16;
propertyChanged("_YOffset", _YOffset);
}

            if((_StartAngle == 0))
{
                _XOffset += 16;
propertyChanged("_XOffset", _XOffset);
}

            else if((_StartAngle == 90))
{
                _YOffset += 16;
propertyChanged("_YOffset", _YOffset);
}

            else if((_StartAngle == 180))
{
                _XOffset -= 16;
propertyChanged("_XOffset", _XOffset);
}

            else if((_StartAngle == 270))
{
                _YOffset -= 16;
propertyChanged("_YOffset", _YOffset);
}

}

}
    

/* Params are:__Self __CurrentAngle __ChangeAngle */
public function _customBlock_ChangeAngle(__CurrentAngle:Float, __ChangeAngle:Float):Float
{
var __Self:Actor = actor;
        __CurrentAngle += __ChangeAngle;
while (__CurrentAngle > 360)
{
	__CurrentAngle -= 360;
}

while (__CurrentAngle < 0)
{
	__CurrentAngle += 360;
}

return __CurrentAngle;

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
_MaxNumberOfSegments = 3.0;
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
nameMap.set("Is Generating?", "_IsGenerating");
_IsGenerating = true;
nameMap.set("Head", "_Head");
nameMap.set("Pipes", "_Pipes");
_Pipes = [];
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _CurrentNumberOfSegments = asNumber(0);
propertyChanged("_CurrentNumberOfSegments", _CurrentNumberOfSegments);
        _NumberOfSegments = asNumber(randomInt(Math.floor(2), Math.floor(_MaxNumberOfSegments)));
propertyChanged("_NumberOfSegments", _NumberOfSegments);
        runPeriodically(1000 * _GenerateTime, function(timeTask:TimedTask):Void {
                    if(_IsGenerating)
{
                        if((hasValue(_Head) == false))
{
                            createRecycledActor(getActorType(660), (actor.getX() - 19), (actor.getY() - 16), Script.FRONT);
                            _Head = getLastCreatedActor();
propertyChanged("_Head", _Head);
                            _Head.setAngle(Utils.RAD * (_StartAngle));
                            return;
}

                        _AngleIndex = asNumber(randomInt(Math.floor(0), Math.floor(0)));
propertyChanged("_AngleIndex", _AngleIndex);
                        if((_AngleIndex == 0))
{
                            _EndAngle = asNumber(cast((actor.say("Goose Head Maker PM", "_customBlock_ChangeAngle", [_StartAngle,-90])), Float));
propertyChanged("_EndAngle", _EndAngle);
}

                        else if((_AngleIndex == 1))
{
                            _EndAngle = asNumber(cast((actor.say("Goose Head Maker PM", "_customBlock_ChangeAngle", [_StartAngle,90])), Float));
propertyChanged("_EndAngle", _EndAngle);
}

                        else
{
                            _EndAngle = asNumber(_StartAngle);
propertyChanged("_EndAngle", _EndAngle);
}

                        if((_StartAngle == _EndAngle))
{
                            createRecycledActor(getActorType(662), (actor.getX() + _XOffset), (actor.getY() + _YOffset), Script.FRONT);
                            _Pipe = getLastCreatedActor();
propertyChanged("_Pipe", _Pipe);
}

                        else
{
                            createRecycledActor(getActorType(664), (actor.getX() + _XOffset), (actor.getY() + _YOffset), Script.FRONT);
                            _Pipe = getLastCreatedActor();
propertyChanged("_Pipe", _Pipe);
}

                        actor.say("Goose Head Maker PM", "_customBlock_UpdatePositions");
                        _StartAngle = asNumber(_EndAngle);
propertyChanged("_StartAngle", _StartAngle);
                        _CurrentNumberOfSegments += 1;
propertyChanged("_CurrentNumberOfSegments", _CurrentNumberOfSegments);
                        if((_CurrentNumberOfSegments == _NumberOfSegments))
{
                            _IsGenerating = false;
propertyChanged("_IsGenerating", _IsGenerating);
}

}

}, actor);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}