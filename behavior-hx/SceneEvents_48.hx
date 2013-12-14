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



class SceneEvents_48 extends SceneScript
{          	
	
public var _ExitName:String;

public var _BombCrate:Actor;
    public function _customEvent_TimedSwitchLight11PreSwitchedOn():Void
{
        if(((hasValue(_BombCrate) != false) && _BombCrate.isAlive()))
{
            _BombCrate.setValue("Explode After Time PM", "_ExplodeAfterSeconds", 0.5);
}

}


 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";
nameMap.set("Bomb Crate", "_BombCrate");

	}
	
	override public function init()
	{
		            if(!(getGameAttribute("Speed Run In Progress")))
{
            recycleActor(getActor(54));
            recycleActor(getActor(55));
}

        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    sayToScene("Sound Manager PM", "_customBlock_LoopSceneSound", ["Conveyor Loop SFX",getCurrentSceneName()]);
}, null);
    addActorEntersRegionListener(getRegion(0), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(653),a.getType(),a.getGroup())){
        a.applyImpulse(0, -1, 75);
        getActor(9).say("Activate On Event PM", "_customEvent_" + "Activate");
}
});
    addWhenTypeGroupCreatedListener(getActorType(653), function(eventActor:Actor, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _BombCrate = eventActor;
propertyChanged("_BombCrate", _BombCrate);
}
});
    addActorEntersRegionListener(getRegion(2), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(653),a.getType(),a.getGroup())){
        a.applyImpulse(1, 0, 75);
}
});
    addWhenTypeGroupKilledListener(getActorType(653), function(eventActor:Actor, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        getActor(9).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}
});
    addActorEntersRegionListener(getRegion(1), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAs(getActor(9), a)){
        getActor(9).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}
});
    addWhenKilledListener(getActor(52), function(list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(getGameAttribute("Speed Run In Progress"))
{
            recycleActor(getActor(54));
            recycleActor(getActor(55));
}

}
});
    addActorEntersRegionListener(getRegion(0), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAs(getActor(3), a)){
        getActor(8).say("Spawn PM", "_customEvent_" + "Activated");
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}