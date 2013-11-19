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



class Design_275_275_RotationPipePM extends ActorScript
{          	
	
public var _NorthAnimation:String;

public var _EastAnimation:String;

public var _SouthAnimation:String;

public var _WestAnimation:String;

public var _StartOrientation:String;

public var _CurrentOrientation:String;

public var _Connections:Array<Dynamic>;

public var _HasNorthInput:Bool;

public var _HasSouthInput:Bool;

public var _HasEastInput:Bool;

public var _HasWestInput:Bool;

public var _NorthOutput:Actor;

public var _SouthOutput:Actor;

public var _EastOutput:Actor;

public var _ConnectionMap:String;

public var _WestOutput:Actor;

public var _Input:String;

public var _Output:Actor;

public var _TargetMap:Array<Dynamic>;
    

/* Params are: */
public function _customBlock_UpdateAnimation():Void
{
var __Self:Actor = actor;
        if((_CurrentOrientation == "North"))
{
            actor.setAnimation("" + _NorthAnimation);
}

        else if((_CurrentOrientation == "East"))
{
            actor.setAnimation("" + _EastAnimation);
}

        else if((_CurrentOrientation == "South"))
{
            actor.setAnimation("" + _SouthAnimation);
}

        else if((_CurrentOrientation == "West"))
{
            actor.setAnimation("" + _WestAnimation);
}

}
    

/* Params are: */
public function _customBlock_UpdateConnections():Void
{
var __Self:Actor = actor;
        actor.say("Rotation Pipe PM", "_customBlock_DisableOutput", [_NorthOutput,"South"]);
        actor.say("Rotation Pipe PM", "_customBlock_DisableOutput", [_EastOutput,"West"]);
        actor.say("Rotation Pipe PM", "_customBlock_DisableOutput", [_SouthOutput,"North"]);
        actor.say("Rotation Pipe PM", "_customBlock_DisableOutput", [_WestOutput,"East"]);
        for(item in cast(_Connections, Array<Dynamic>))
{
            _Input = "" + (actor.say("Rotation Pipe PM", "_customBlock_GetRotatedConnection", [("" + item).charAt(Std.int(0))]));
propertyChanged("_Input", _Input);
            _Output = cast((actor.say("Rotation Pipe PM", "_customBlock_GetRotatedTarget", [("" + item).charAt(Std.int(1))])), Actor);
propertyChanged("_Output", _Output);
            if(((_Input == "N") && _HasNorthInput))
{
                actor.say("Rotation Pipe PM", "_customBlock_TriggerOutput", [_Output,"South"]);
}

            else if(((_Input == "E") && _HasEastInput))
{
                actor.say("Rotation Pipe PM", "_customBlock_TriggerOutput", [_Output,"West"]);
}

            else if(((_Input == "S") && _HasSouthInput))
{
                actor.say("Rotation Pipe PM", "_customBlock_TriggerOutput", [_Output,"North"]);
}

            else if(((_Input == "W") && _HasWestInput))
{
                actor.say("Rotation Pipe PM", "_customBlock_TriggerOutput", [_Output,"East"]);
}

}

}
    

/* Params are:__Self */
public function _customBlock_RotateClockwise():Void
{
var __Self:Actor = actor;
        if((_CurrentOrientation == "North"))
{
            __Self.say("Rotation Pipe PM", "_customBlock_SetOrientation", ["East"]);
}

        else if((_CurrentOrientation == "East"))
{
            __Self.say("Rotation Pipe PM", "_customBlock_SetOrientation", ["South"]);
}

        else if((_CurrentOrientation == "South"))
{
            __Self.say("Rotation Pipe PM", "_customBlock_SetOrientation", ["West"]);
}

        else if((_CurrentOrientation == "West"))
{
            __Self.say("Rotation Pipe PM", "_customBlock_SetOrientation", ["North"]);
}

}
    

/* Params are:__Self */
public function _customBlock_RotateAnticlockwise():Void
{
var __Self:Actor = actor;
        if((_CurrentOrientation == "North"))
{
            __Self.say("Rotation Pipe PM", "_customBlock_SetOrientation", ["West"]);
}

        else if((_CurrentOrientation == "East"))
{
            __Self.say("Rotation Pipe PM", "_customBlock_SetOrientation", ["North"]);
}

        else if((_CurrentOrientation == "South"))
{
            __Self.say("Rotation Pipe PM", "_customBlock_SetOrientation", ["East"]);
}

        else if((_CurrentOrientation == "West"))
{
            __Self.say("Rotation Pipe PM", "_customBlock_SetOrientation", ["South"]);
}

}
    

/* Params are:__Self __NewOrientation */
public function _customBlock_SetOrientation(__NewOrientation:String):Void
{
var __Self:Actor = actor;
        _CurrentOrientation = __NewOrientation;
propertyChanged("_CurrentOrientation", _CurrentOrientation);
        if((hasValue(_TargetMap) == false))
{
            _TargetMap = new Array<Dynamic>();
propertyChanged("_TargetMap", _TargetMap);
}

        if((_CurrentOrientation == "East"))
{
            _ConnectionMap = "WNES";
propertyChanged("_ConnectionMap", _ConnectionMap);
            _TargetMap[Std.int(0)] = _WestOutput;
            _TargetMap[Std.int(1)] = _NorthOutput;
            _TargetMap[Std.int(2)] = _EastOutput;
            _TargetMap[Std.int(3)] = _SouthOutput;
}

        else if((_CurrentOrientation == "South"))
{
            _ConnectionMap = "SWNE";
propertyChanged("_ConnectionMap", _ConnectionMap);
            _TargetMap[Std.int(0)] = _SouthOutput;
            _TargetMap[Std.int(1)] = _WestOutput;
            _TargetMap[Std.int(2)] = _NorthOutput;
            _TargetMap[Std.int(3)] = _EastOutput;
}

        else if((_CurrentOrientation == "West"))
{
            _ConnectionMap = "ESWN";
propertyChanged("_ConnectionMap", _ConnectionMap);
            _TargetMap[Std.int(0)] = _EastOutput;
            _TargetMap[Std.int(1)] = _SouthOutput;
            _TargetMap[Std.int(2)] = _WestOutput;
            _TargetMap[Std.int(3)] = _NorthOutput;
}

        else
{
            _ConnectionMap = "NESW";
propertyChanged("_ConnectionMap", _ConnectionMap);
            _TargetMap[Std.int(0)] = _NorthOutput;
            _TargetMap[Std.int(1)] = _EastOutput;
            _TargetMap[Std.int(2)] = _SouthOutput;
            _TargetMap[Std.int(3)] = _WestOutput;
}

        actor.say("Rotation Pipe PM", "_customBlock_UpdateAnimation");
        actor.say("Rotation Pipe PM", "_customBlock_UpdateConnections");
}
    

/* Params are:__Self __Connection */
public function _customBlock_GetRotatedConnection(__Connection:String):String
{
var __Self:Actor = actor;
        if((__Connection == "E"))
{
            return ("" + _ConnectionMap).charAt(Std.int(1));
}

        else if((__Connection == "S"))
{
            return ("" + _ConnectionMap).charAt(Std.int(2));
}

        else if((__Connection == "W"))
{
            return ("" + _ConnectionMap).charAt(Std.int(3));
}

        return ("" + _ConnectionMap).charAt(Std.int(0));
}
    

/* Params are:__Self __Connection */
public function _customBlock_GetRotatedTarget(__Connection:String):Actor
{
var __Self:Actor = actor;
        if((__Connection == "E"))
{
            return _TargetMap[Std.int(1)];
}

        else if((__Connection == "S"))
{
            return _TargetMap[Std.int(2)];
}

        else if((__Connection == "W"))
{
            return _TargetMap[Std.int(3)];
}

        return _TargetMap[Std.int(0)];
}
    

/* Params are: __Target __Direction */
public function _customBlock_TriggerOutput(__Target:Actor, __Direction:String):Void
{
var __Self:Actor = actor;
        if(!(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorIsNull(__Target)), Bool)))
{
            if(__Target.hasBehavior("Rotation Pipe PM"))
{
                if((__Direction == "East"))
{
                    __Target.setValue("Rotation Pipe PM", "_HasEastInput", true);
}

                else if((__Direction == "South"))
{
                    __Target.setValue("Rotation Pipe PM", "_HasSouthInput", true);
}

                else if((__Direction == "West"))
{
                    __Target.setValue("Rotation Pipe PM", "_HasWestInput", true);
}

                else
{
                    __Target.setValue("Rotation Pipe PM", "_HasNorthInput", true);
}

}

            if(__Target.hasBehavior("Activate On Event PM"))
{
                __Target.say("Activate On Event PM", "_customEvent_" + "Activate");
}

}

}
    

/* Params are: __Target __Direction */
public function _customBlock_DisableOutput(__Target:Actor, __Direction:String):Void
{
var __Self:Actor = actor;
        if(!(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorIsNull(__Target)), Bool)))
{
            if(__Target.hasBehavior("Rotation Pipe PM"))
{
                if((__Direction == "East"))
{
                    __Target.setValue("Rotation Pipe PM", "_HasEastInput", false);
}

                else if((__Direction == "South"))
{
                    __Target.setValue("Rotation Pipe PM", "_HasSouthInput", false);
}

                else if((__Direction == "West"))
{
                    __Target.setValue("Rotation Pipe PM", "_HasWestInput", false);
}

                else
{
                    __Target.setValue("Rotation Pipe PM", "_HasNorthInput", false);
}

}

            if(__Target.hasBehavior("Activate On Event PM"))
{
                __Target.say("Activate On Event PM", "_customEvent_" + "Deactivate");
}

}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("North Animation", "_NorthAnimation");
nameMap.set("East Animation", "_EastAnimation");
nameMap.set("South Animation", "_SouthAnimation");
nameMap.set("West Animation", "_WestAnimation");
nameMap.set("Start Orientation", "_StartOrientation");
_StartOrientation = "North";
nameMap.set("Current Orientation", "_CurrentOrientation");
_CurrentOrientation = "";
nameMap.set("Connections", "_Connections");
_Connections = [];
nameMap.set("Has North Input?", "_HasNorthInput");
_HasNorthInput = false;
nameMap.set("Has South Input?", "_HasSouthInput");
_HasSouthInput = false;
nameMap.set("Has East Input?", "_HasEastInput");
_HasEastInput = false;
nameMap.set("Has West Input?", "_HasWestInput");
_HasWestInput = false;
nameMap.set("Actor", "actor");
nameMap.set("North Output", "_NorthOutput");
nameMap.set("South Output", "_SouthOutput");
nameMap.set("East Output", "_EastOutput");
nameMap.set("Connection Map", "_ConnectionMap");
_ConnectionMap = "";
nameMap.set("West Output", "_WestOutput");
nameMap.set("Input", "_Input");
_Input = "";
nameMap.set("Output", "_Output");
nameMap.set("Target Map", "_TargetMap");
_TargetMap = [];

	}
	
	override public function init()
	{
		            actor.say("Rotation Pipe PM", "_customBlock_SetOrientation", [_StartOrientation]);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}