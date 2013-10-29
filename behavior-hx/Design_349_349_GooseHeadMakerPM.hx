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
                actor.setX((actor.getX() + 32));
                actor.setAngle(Utils.RAD * (-90));
}

            else if((_StartAngle == 90))
{
                actor.setY((actor.getY() + 32));
                actor.setAngle(Utils.RAD * (180));
                _Pipe.setAngle(Utils.RAD * (90));
}

            else if((_StartAngle == 180))
{
                actor.setX((actor.getX() - 32));
                actor.setAngle(Utils.RAD * (90));
}

            else if((_StartAngle == 270))
{
                actor.setY((actor.getY() - 32));
                _Pipe.setAngle(Utils.RAD * (-90));
}

}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Start Angle", "_StartAngle");
_StartAngle = 0;
nameMap.set("Generate Time", "_GenerateTime");
_GenerateTime = 0;
nameMap.set("Number Of Segments", "_NumberOfSegments");
_NumberOfSegments = 0;
nameMap.set("Max Number Of Segments", "_MaxNumberOfSegments");
_MaxNumberOfSegments = 0;
nameMap.set("Current Number Of Segments", "_CurrentNumberOfSegments");
_CurrentNumberOfSegments = 0;
nameMap.set("End Angle", "_EndAngle");
_EndAngle = 0;
nameMap.set("Angle Index", "_AngleIndex");
_AngleIndex = 0;
nameMap.set("X Offset", "_XOffset");
_XOffset = 0;
nameMap.set("Y Offset", "_YOffset");
_YOffset = 0;
nameMap.set("Pipe", "_Pipe");
nameMap.set("Is Generating?", "_IsGenerating");
_IsGenerating = false;
nameMap.set("Head", "_Head");
nameMap.set("Pipes", "_Pipes");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _CurrentNumberOfSegments = asNumber(0);
propertyChanged("_CurrentNumberOfSegments", _CurrentNumberOfSegments);
        _NumberOfSegments = asNumber(randomInt(Math.floor(2), Math.floor(_MaxNumberOfSegments)));
propertyChanged("_NumberOfSegments", _NumberOfSegments);
        runLater(1000 * _GenerateTime, function(timeTask:TimedTask):Void {
                    if(_IsGenerating)
{
                        _AngleIndex = asNumber(randomInt(Math.floor(2), Math.floor(2)));
propertyChanged("_AngleIndex", _AngleIndex);
                        if((_AngleIndex == 0))
{
                            _EndAngle = asNumber(((_StartAngle - 90) % 360));
propertyChanged("_EndAngle", _EndAngle);
}

                        else if((_AngleIndex == 1))
{
                            _EndAngle = asNumber(((_StartAngle + 90) % 360));
propertyChanged("_EndAngle", _EndAngle);
}

                        else
{
                            _EndAngle = asNumber(_StartAngle);
propertyChanged("_EndAngle", _EndAngle);
}

                        if((_StartAngle == _EndAngle))
{
                            createRecycledActor(getActorType(662), actor.getX(), actor.getY(), Script.FRONT);
                            _Pipe = getLastCreatedActor();
propertyChanged("_Pipe", _Pipe);
}

                        else
{
                            createRecycledActor(getActorType(664), actor.getX(), actor.getY(), Script.FRONT);
                            _Pipe = getLastCreatedActor();
propertyChanged("_Pipe", _Pipe);
}

                        _StartAngle = asNumber(_EndAngle);
propertyChanged("_StartAngle", _StartAngle);
}

}, actor);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}