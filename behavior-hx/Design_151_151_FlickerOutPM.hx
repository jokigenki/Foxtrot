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



class Design_151_151_FlickerOutPM extends ActorScript
{          	
	
public var _TotalTime:Float;

public var _CumulativeTime:Float;

public var _NumberOfFlickers:Float;

public var _CurrentDivisor:Float;

public var _StepTime:Float;

public var _KillX:Float;

public var _KillY:Float;

public var _KillForce:Float;
    public function _customEvent_Killed():Void
{
        actor.say("Disable Behaviours On Killed PM", "_customBlock_RunDisableOnKilled");
        _StepTime = asNumber((_TotalTime / (_NumberOfFlickers * 2)));
propertyChanged("_StepTime", _StepTime);
        _CumulativeTime = asNumber(_StepTime);
propertyChanged("_CumulativeTime", _CumulativeTime);
        for(index0 in 0...Std.int(_NumberOfFlickers))
{
            runLater(1000 * _CumulativeTime, function(timeTask:TimedTask):Void {
                        actor.disableActorDrawing();
}, actor);
            _CumulativeTime += _StepTime;
propertyChanged("_CumulativeTime", _CumulativeTime);
            runLater(1000 * _CumulativeTime, function(timeTask:TimedTask):Void {
                        actor.enableActorDrawing();
}, actor);
            _CumulativeTime += _StepTime;
propertyChanged("_CumulativeTime", _CumulativeTime);
}

        runLater(1000 * _TotalTime, function(timeTask:TimedTask):Void {
                    recycleActor(actor);
                    if(actor.isBehaviorEnabled("Reload On Death PM"))
{
                        actor.say("Reload On Death PM", "_customEvent_" + "Reload");
}

}, actor);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Total Time", "_TotalTime");
_TotalTime = 0.0;
nameMap.set("Cumulative Time", "_CumulativeTime");
_CumulativeTime = 0.0;
nameMap.set("Number Of Flickers", "_NumberOfFlickers");
_NumberOfFlickers = 0.0;
nameMap.set("Current Divisor", "_CurrentDivisor");
_CurrentDivisor = 0.0;
nameMap.set("Step Time", "_StepTime");
_StepTime = 0.0;
nameMap.set("Kill X", "_KillX");
_KillX = 0.0;
nameMap.set("Kill Y", "_KillY");
_KillY = 0.0;
nameMap.set("Kill Force", "_KillForce");
_KillForce = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}