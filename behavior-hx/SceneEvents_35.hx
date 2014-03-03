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
import nme.display.BitmapData;
import nme.display.Bitmap;
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



class SceneEvents_35 extends SceneScript
{          	
	
public var _ExitName:String;

public var _Crate:Actor;

public var _StartRandomiser:Float;
    public function _customEvent_SwitchSingleUse31SwitchedOn():Void
{
        getActor(32).say("Single Use Region Switch PM", "_customBlock_ResetSwitch");
        getActor(26).setValue("Conveyor PM", "_Direction", 1);
        getActor(27).setValue("Conveyor PM", "_Direction", 1);
        getActor(30).setValue("Conveyor PM", "_Direction", 1);
        getActor(43).setValue("Conveyor PM", "_Direction", 1.5);
        getActor(55).setValue("Conveyor PM", "_Direction", 1.5);
}

    public function _customEvent_SwitchSingleUse32SwitchedOn():Void
{
        getActor(31).say("Single Use Region Switch PM", "_customBlock_ResetSwitch");
        getActor(26).setValue("Conveyor PM", "_Direction", -1);
        getActor(27).setValue("Conveyor PM", "_Direction", -1);
        getActor(30).setValue("Conveyor PM", "_Direction", -1);
        getActor(43).setValue("Conveyor PM", "_Direction", -1.5);
        getActor(55).setValue("Conveyor PM", "_Direction", -1.5);
}

    public function _customEvent_TimedSwitchLight62PreSwitchedOn():Void
{
        if(((hasValue(_Crate) != false) && _Crate.isAlive()))
{
            _Crate.setValue("Explode After Time PM", "_ExplodeAfterSeconds", 0.5);
}

}

    public function _customEvent_TimedSwitchLight62SwitchedOn():Void
{
        _Crate = getActor(13).getValue("Spawn PM", "_LastSpawn");
propertyChanged("_Crate", _Crate);
}

    public function _customEvent_SwitchSingleUse68SwitchedOn():Void
{
        getActor(69).say("Single Use Region Switch PM", "_customBlock_ResetSwitch");
        getActor(56).setValue("Conveyor PM", "_Direction", 1);
        getActor(64).setValue("Conveyor PM", "_Direction", 1);
        getActor(65).setValue("Conveyor PM", "_Direction", 1);
        getActor(66).setValue("Conveyor PM", "_Direction", 1);
        getActor(67).setValue("Conveyor PM", "_Direction", 1);
}

    public function _customEvent_SwitchSingleUse69SwitchedOn():Void
{
        getActor(68).say("Single Use Region Switch PM", "_customBlock_ResetSwitch");
        getActor(56).setValue("Conveyor PM", "_Direction", -1);
        getActor(64).setValue("Conveyor PM", "_Direction", -1);
        getActor(65).setValue("Conveyor PM", "_Direction", -1);
        getActor(66).setValue("Conveyor PM", "_Direction", -1);
        getActor(67).setValue("Conveyor PM", "_Direction", -1);
}


 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";
nameMap.set("Crate", "_Crate");
nameMap.set("Start Randomiser", "_StartRandomiser");
_StartRandomiser = 0.0;

	}
	
	override public function init()
	{
		            runLater(1000 * 0.2, function(timeTask:TimedTask):Void {
                    sayToScene("Sound Manager PM", "_customBlock_LoopSceneSound", ["Conveyor Loop SFX",getCurrentSceneName()]);
}, null);
    addWhenTypeGroupKilledListener(getActorType(653), function(eventActor:Actor, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        startShakingScreen(1 / 100, 0.25);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}