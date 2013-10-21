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



class SceneEvents_32 extends SceneScript
{          	
	
public var _ExitName:String;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";

	}
	
	override public function init()
	{
		    addActorEntersRegionListener(getRegion(2), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(156),a.getType(),a.getGroup())){
        getActor(14).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 1.5, function(timeTask:TimedTask):Void {
                    getActor(14).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(3), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(156),a.getType(),a.getGroup())){
        getActor(19).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 0.5, function(timeTask:TimedTask):Void {
                    getActor(19).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(0), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(156),a.getType(),a.getGroup())){
        getActor(21).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 1.5, function(timeTask:TimedTask):Void {
                    getActor(21).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(1), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(156),a.getType(),a.getGroup())){
        getActor(20).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 0.5, function(timeTask:TimedTask):Void {
                    getActor(20).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(2), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(9),a.getType(),a.getGroup())){
        getActor(14).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 1.5, function(timeTask:TimedTask):Void {
                    getActor(14).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(0), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(9),a.getType(),a.getGroup())){
        getActor(21).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 1.5, function(timeTask:TimedTask):Void {
                    getActor(21).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}