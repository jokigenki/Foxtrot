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



class Design_183_183_ReduceHealthPM extends ActorScript
{          	
	
public var _StartingHealth:Float;

public var _KillBehaviour:String;

public var _StatesForHealthValues:Array<Dynamic>;

public var _CurrentHealth:Float;

public var _KilledSceneEvent:String;

public var _ReducedHealthEvent:String;

public var _SoundsForHealthValues:Array<Dynamic>;
    public function _customEvent_Killed():Void
{
        _CurrentHealth -= 1;
propertyChanged("_CurrentHealth", _CurrentHealth);
        shoutToScene("_customEvent_" + _ReducedHealthEvent);
        if((_CurrentHealth <= 0))
{
            if(actor.hasBehavior(_KillBehaviour))
{
                actor.say(_KillBehaviour, "_customEvent_" + "Killed");
                shoutToScene("_customEvent_" + _KilledSceneEvent);
}

}

        if(actor.hasBehavior("Super Simple State Machine PM"))
{
            for(item in cast(_StatesForHealthValues, Array<Dynamic>))
{
                var values = item.split(":");
var healthValue = Std.parseInt(values[0]);
var state = values[1];

                if((healthValue == _CurrentHealth))
{
                    actor.say("Super Simple State Machine PM", "_customBlock_ChangeState", [state]);
}

}

}

        for(item in cast(_SoundsForHealthValues, Array<Dynamic>))
{
            var values = item.split(":");
var healthValue = Std.parseInt(values[0]);
var sound = values[1];

            if((healthValue == _CurrentHealth))
{
                playSound(cast((scripts.Design_207_207_StencylExtrasPM._customBlock_GetNamedSound(sound)), Sound));
}

}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Starting Health", "_StartingHealth");
_StartingHealth = 0.0;
nameMap.set("Kill Behaviour", "_KillBehaviour");
_KillBehaviour = "";
nameMap.set("States For Health Values", "_StatesForHealthValues");
_StatesForHealthValues = [];
nameMap.set("Current Health", "_CurrentHealth");
_CurrentHealth = 0.0;
nameMap.set("Killed Scene Event", "_KilledSceneEvent");
_KilledSceneEvent = "";
nameMap.set("Reduced Health Event", "_ReducedHealthEvent");
_ReducedHealthEvent = "ReducedHealth";
nameMap.set("Sounds For Health Values", "_SoundsForHealthValues");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _CurrentHealth = asNumber(_StartingHealth);
propertyChanged("_CurrentHealth", _CurrentHealth);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}