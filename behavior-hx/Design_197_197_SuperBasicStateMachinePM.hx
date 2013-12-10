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



class Design_197_197_SuperBasicStateMachinePM extends ActorScript
{          	
	
public var _States:Array<Dynamic>;

public var _DefaultState:String;

public var _State:String;

public var _Behaviours:Array<Dynamic>;
    

/* Params are:__Self __NewState */
public function _customBlock_ChangeState(__NewState:String):Void
{
var __Self:Actor = actor;
        _State = "" + (__Self.say("Super Simple State Machine PM", "_customBlock_GetStateById", [__NewState]));
propertyChanged("_State", _State);
        if(("" + _State) == (""))
{
            return;
}

        var comps = _State.split(":");
        _Behaviours = comps[1].split(",");
propertyChanged("_Behaviours", _Behaviours);
        for(item in cast(_Behaviours, Array<Dynamic>))
{
            var bComps = item.split("=");
            var behaviour = bComps[0];
            var value = bComps[1] == "0" ? "Deactivated" : "Activated"; 	
            __Self.say(behaviour, "_customEvent_" + value);
}

}
    

/* Params are:__Self __StateId */
public function _customBlock_GetStateById(__StateId:String):String
{
var __Self:Actor = actor;
        for(item in cast(_States, Array<Dynamic>))
{
            var comps = item.split(":");
//if (comps.length > 1)
//{
	var sId = comps[Std.int(0)];
	if (sId == __StateId)
	{
		return item;
	}
//}
}

        return "";
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("States", "_States");
_States = [];
nameMap.set("Default State", "_DefaultState");
_DefaultState = "";
nameMap.set("State", "_State");
_State = "";
nameMap.set("Behaviours", "_Behaviours");
_Behaviours = [];
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if(!(("" + _DefaultState) == ("")))
{
            actor.say("Super Simple State Machine PM", "_customBlock_ChangeState", [_DefaultState]);
}


	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}