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



class Design_318_318_BehaviourExtras extends ActorScript
{          	
	    

/* Params are:__Self __DestinationBehaviour __DestinationVariable __OriginBehaviour __OriginVariable */
public function _customBlock_AsyncSetBehaviour(__DestinationBehaviour:String, __DestinationVariable:String, __OriginBehaviour:String, __OriginVariable:String):Void
{
var __Self:Actor = actor;
        runPeriodically(1000 * 0.01, function(timeTask:TimedTask):Void {
                    if((__Self.hasBehavior(__OriginBehaviour) && __Self.hasBehavior(__DestinationBehaviour)))
{
                        __Self.setValue(__DestinationBehaviour, __DestinationVariable, __Self.getValue(__OriginBehaviour, __OriginVariable));
                        timeTask.repeats = false;
return;
}

}, actor);
}
    

/* Params are:__Self __EventName __TriggerBehaviour __WatchedBehaviour */
public function _customBlock_TriggerEventWhenBehaviourReady(__EventName:String, __TriggerBehaviour:String, __WatchedBehaviour:String):Void
{
var __Self:Actor = actor;
        runPeriodically(1000 * 0.01, function(timeTask:TimedTask):Void {
                    if((__Self.hasBehavior(__TriggerBehaviour) && __Self.hasBehavior(__WatchedBehaviour)))
{
                        __Self.say(__TriggerBehaviour, "_customEvent_" + __EventName);
                        timeTask.repeats = false;
return;
}

}, actor);
}
    

/* Params are:__Self __EventName __WatchedBehaviour */
public function _customBlock_TriggerEventInAllWhenBehaviourReady(__EventName:String, __WatchedBehaviour:String):Void
{
var __Self:Actor = actor;
        runPeriodically(1000 * 0.01, function(timeTask:TimedTask):Void {
                    if(__Self.hasBehavior(__WatchedBehaviour))
{
                        __Self.shout("_customEvent_" + __EventName);
                        timeTask.repeats = false;
return;
}

}, actor);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}