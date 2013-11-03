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



class Design_345_345_ExplodeAfterTimePM extends ActorScript
{          	
	
public var _TimeElapsed:Float;

public var _Beatsperframe:Float;

public var _ExplodeAfterSeconds:Float;

public var _ExplodeBehaviour:String;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Time Elapsed", "_TimeElapsed");
_TimeElapsed = 0.0;
nameMap.set("Beats per frame", "_Beatsperframe");
_Beatsperframe = 0.0;
nameMap.set("Explode After Seconds", "_ExplodeAfterSeconds");
_ExplodeAfterSeconds = 3.0;
nameMap.set("Explode Behaviour", "_ExplodeBehaviour");
_ExplodeBehaviour = "Explode With Set Pieces PM";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _Beatsperframe = asNumber(((_ExplodeAfterSeconds / actor.getNumFrames()) * 10));
propertyChanged("_Beatsperframe", _Beatsperframe);
        _TimeElapsed = asNumber(0);
propertyChanged("_TimeElapsed", _TimeElapsed);
        runPeriodically(1000 * 0.1, function(timeTask:TimedTask):Void {
                    _TimeElapsed += 1;
propertyChanged("_TimeElapsed", _TimeElapsed);
                    if(((_TimeElapsed / 10) >= _ExplodeAfterSeconds))
{
                        actor.say(_ExplodeBehaviour, "_customEvent_" + "Killed");
}

}, actor);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        actor.setCurrentFrame(Std.int(Math.floor((_TimeElapsed / _Beatsperframe))));
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}