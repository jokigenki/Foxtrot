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



class Design_299_299_ComplexMovementPM extends ActorScript
{          	
	
public var _Movements:Array<Dynamic>;

public var _CurrentAction:String;

public var _CurrentType:String;

public var _NextAction:String;

public var _NextType:String;

public var _ActionComponents:Array<Dynamic>;

public var _ActionPointer:Float;

public var _CurrentActionTime:Float;

public var _Param1:Float;

public var _Param2:Float;

public var _Duration:Float;

public var _Ease:String;
    

/* Params are:__Self */
public function _customBlock_StartNextAction():Void
{
var __Self:Actor = actor;
        /* "Actions are in format Type(Sequential/Concurrent):Action(Slide/Spin/Fade/Grow/Pause):Duration:Ease:Param1(X/Angle/Width):Param2(Y/Height)" */
        _ActionComponents = ("" + _Movements[Std.int(_ActionPointer)]).split(":");
propertyChanged("_ActionComponents", _ActionComponents);
        _NextType = _ActionComponents[Std.int(0)];
propertyChanged("_NextType", _NextType);
        _NextAction = _ActionComponents[Std.int(1)];
propertyChanged("_NextAction", _NextAction);
        /* "If the current action is concurrent, and the next action is the last item in the list, is sequential or is a pause, stop loading actions" */
        if(((_CurrentType == "C") && ((_ActionPointer == (_Movements.length - 1)) || ((_NextType == "S") || (_NextAction == "Pause")))))
{
            _CurrentType = "";
propertyChanged("_CurrentType", _CurrentType);
            _CurrentAction = "";
propertyChanged("_CurrentAction", _CurrentAction);
            _CurrentActionTime = asNumber(-1);
propertyChanged("_CurrentActionTime", _CurrentActionTime);
            return;
}

        _ActionPointer += 1;
propertyChanged("_ActionPointer", _ActionPointer);
        if((_ActionPointer >= _Movements.length))
{
            _ActionPointer = asNumber(0);
propertyChanged("_ActionPointer", _ActionPointer);
}

        if((_CurrentActionTime == -1))
{
            _CurrentActionTime = asNumber(asNumber(_ActionComponents[Std.int(2)]));
propertyChanged("_CurrentActionTime", _CurrentActionTime);
            if((_CurrentActionTime > 0))
{
                runLater(1000 * _CurrentActionTime, function(timeTask:TimedTask):Void {
                            actor.say("Complex Movement PM", "_customBlock_StartNextAction");
}, actor);
}

}

        _Duration = asNumber(_ActionComponents[Std.int(2)]);
propertyChanged("_Duration", _Duration);
        var ease = Linear.easeNone;
        if((_ActionComponents.length > 3))
{
            _Ease = _ActionComponents[Std.int(3)];
propertyChanged("_Ease", _Ease);
            ease = scripts.Design_299_299_ComplexMovementPM._customBlock_GetEaseByName(_Ease);
}

        if((_ActionComponents.length > 4))
{
            _Param1 = asNumber(_ActionComponents[Std.int(4)]);
propertyChanged("_Param1", _Param1);
}

        if((_ActionComponents.length > 5))
{
            _Param2 = asNumber(_ActionComponents[Std.int(5)]);
propertyChanged("_Param2", _Param2);
}

        if((_NextAction == "Slide To"))
{
            actor.moveTo(_Param1, _Param2, _Duration, ease);
}

        if((_NextAction == "Slide By"))
{
            actor.moveBy(_Param1, _Param2, _Duration, ease);
}

        else if((_NextAction == "Spin To"))
{
            actor.spinTo(_Param1, _Duration, ease);
}

        else if((_NextAction == "Spin By"))
{
            actor.spinBy(_Param1, _Duration, ease);
}

        else if((_NextAction == "Fade"))
{
            actor.fadeTo(_Param1 / 100, _Duration, ease);
}

        else if((_NextAction == "Grow"))
{
            actor.growTo(_Param1 /100, _Param2 /100, _Duration, ease);
}

        if((_NextType == "C"))
{
            _CurrentAction = _NextAction;
propertyChanged("_CurrentAction", _CurrentAction);
            _CurrentType = _NextType;
propertyChanged("_CurrentType", _CurrentType);
            actor.say("Complex Movement PM", "_customBlock_StartNextAction");
}

        else
{
            _CurrentAction = "";
propertyChanged("_CurrentAction", _CurrentAction);
            _CurrentType = "";
propertyChanged("_CurrentType", _CurrentType);
            _CurrentActionTime = asNumber(-1);
propertyChanged("_CurrentActionTime", _CurrentActionTime);
            if((asNumber(_ActionComponents[Std.int(2)]) == 0))
{
                actor.say("Complex Movement PM", "_customBlock_StartNextAction");
}

}

}
    

/* Params are:__EaseName */
public static function _customBlock_GetEaseByName(__EaseName:String):Dynamic
{
        if (__EaseName == null || __EaseName == "None") return Linear.easeNone;
var comps = __EaseName.split(".");
var easeClass = Type.resolveClass("com.eclecticdesignstudio.motion.easing." + comps[0]);
return Reflect.getProperty(easeClass, comps[1]);

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Movements", "_Movements");
_Movements = [];
nameMap.set("Current Action", "_CurrentAction");
_CurrentAction = "";
nameMap.set("Current Type", "_CurrentType");
_CurrentType = "";
nameMap.set("Next Action", "_NextAction");
_NextAction = "";
nameMap.set("Next Type", "_NextType");
_NextType = "";
nameMap.set("Action Components", "_ActionComponents");
_ActionComponents = [];
nameMap.set("Action Pointer", "_ActionPointer");
_ActionPointer = 0.0;
nameMap.set("Current Action Time", "_CurrentActionTime");
_CurrentActionTime = -1.0;
nameMap.set("Param1", "_Param1");
_Param1 = 0.0;
nameMap.set("Param2", "_Param2");
_Param2 = 0.0;
nameMap.set("Duration", "_Duration");
_Duration = 0.0;
nameMap.set("Ease", "_Ease");
_Ease = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _ActionPointer = asNumber(0);
propertyChanged("_ActionPointer", _ActionPointer);
        actor.say("Complex Movement PM", "_customBlock_StartNextAction");

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}