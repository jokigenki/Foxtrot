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



class SceneEvents_46 extends SceneScript
{          	
	
public var _ExitName:String;

public var _EggBall:Actor;

public var _CratesLeft:Float;

public var _ConfettiCount:Float;

public var _BossEgg:Actor;
    public function _customEvent_JumpStart():Void
{
        _EggBall.disableBehavior("Match Horizontal Movement PM");
        _EggBall.disableBehavior("Match Vertical Movement PM");
}


 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";
nameMap.set("Egg Ball", "_EggBall");
nameMap.set("Crates Left", "_CratesLeft");
_CratesLeft = 0.0;
nameMap.set("Confetti Count", "_ConfettiCount");
_ConfettiCount = 0.0;
nameMap.set("Boss Egg", "_BossEgg");

	}
	
	override public function init()
	{
		            runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    getActor(301).disableActorDrawing();
                    getActor(302).disableActorDrawing();
                    _CratesLeft = asNumber(0);
propertyChanged("_CratesLeft", _CratesLeft);
                    _EggBall = getActor(6);
propertyChanged("_EggBall", _EggBall);
                    for(actorOfType in getActorsOfType(getActorType(772)))
{
if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
                        _CratesLeft += 1;
propertyChanged("_CratesLeft", _CratesLeft);
}
}

}, null);
    addWhenTypeGroupKilledListener(getActorType(757), function(eventActor:Actor, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        createRecycledActor(getActorType(757), getActor(3).getX(), (getActor(3).getY() - 32), Script.FRONT);
        getLastCreatedActor().setValue("Match Horizontal Movement PM", "_Target", getActor(3));
        getLastCreatedActor().setValue("Match Vertical Movement PM", "_Target", getActor(3));
        getLastCreatedActor().setValue("Match Vertical Movement PM", "_Offset", -35);
        getLastCreatedActor().setValue("Jump To Start PM", "_Target", getActor(3));
        _EggBall = getLastCreatedActor();
propertyChanged("_EggBall", _EggBall);
}
});
    addWhenTypeGroupKilledListener(getActorType(772), function(eventActor:Actor, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _CratesLeft -= 1;
propertyChanged("_CratesLeft", _CratesLeft);
        if((_CratesLeft == 65))
{
            trace("" + "Step 1");
            getActor(299).setValue("Horizontal Oscillation PM", "_CurrentVelocity", 10);
            getActor(299).setValue("Random Timed Activation PM", "_MaxTime", 3);
            getActor(299).setValue("Random Timed Activation PM", "_MinTime", 2);
}

        else if((_CratesLeft == 45))
{
            trace("" + "Step 2");
            getActor(299).setValue("Horizontal Oscillation PM", "_CurrentVelocity", 12);
            getActor(299).setValue("Random Timed Activation PM", "_MaxTime", 2);
            getActor(299).setValue("Random Timed Activation PM", "_MinTime", 1);
            if(getGameAttribute("Is Music On?"))
{
                sayToScene("Sound Manager PM", "_customBlock_LoopMusic", [getSound(969)]);
}

}

        else if((_CratesLeft == 20))
{
            trace("" + "Step 3");
            getActor(299).setValue("Horizontal Oscillation PM", "_CurrentVelocity", 14);
            getActor(299).setValue("Random Timed Activation PM", "_MaxTime", 1);
            getActor(299).setValue("Random Timed Activation PM", "_MinTime", 0.75);
            if(getGameAttribute("Is Music On?"))
{
                sayToScene("Sound Manager PM", "_customBlock_LoopMusic", [getSound(970)]);
}

}

        else if((_CratesLeft == 10))
{
            trace("" + "Step 4");
            getActor(299).setValue("Horizontal Oscillation PM", "_CurrentVelocity", 16);
            getActor(299).setValue("Random Timed Activation PM", "_MaxTime", 0.75);
            getActor(299).setValue("Random Timed Activation PM", "_MinTime", 0.5);
}

        else if((_CratesLeft == 0))
{
            getActor(299).shout("_customEvent_" + "Killed");
            trace("" + "KILLED!");
}

}
});
    addWhenKilledListener(getActor(299), function(list:Array<Dynamic>):Void {
if(wrapper.enabled){
        getActor(302).setX((getActor(299).getX() + 18));
        getActor(302).setY((getActor(299).getY() + 9));
        getActor(301).enableActorDrawing();
        getActor(302).enableActorDrawing();
        getActor(301).fadeTo(0 / 100, 0, Linear.easeNone);
        getActor(301).fadeTo(1, 2, Quad.easeOut);
        scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_LockDoorActor(getActor(300));
        getActor(301).setValue("Usable Item PM", "_IsEnabled", true);
        getActor(301).setValue("Displays Popup PM", "_IsEnabled", true);
        _ConfettiCount = asNumber(0);
propertyChanged("_ConfettiCount", _ConfettiCount);
        runPeriodically(1000 * 0.1, function(timeTask:TimedTask):Void {
                    for(index0 in 0...Std.int(10))
{
                        createRecycledActor(getActorType(941), (((640 - getScreenWidth()) / 2) + (640 * randomFloat())), 0, Script.FRONT);
}

                    _ConfettiCount += 1;
propertyChanged("_ConfettiCount", _ConfettiCount);
                    if((_ConfettiCount >= 10))
{
                        timeTask.repeats = false;
return;
}

}, null);
        if(getGameAttribute("Is Music On?"))
{
            sayToScene("Sound Manager PM", "_customBlock_PlaySoundThenMusic", [getSound(962),getSound(466),3.3]);
}

        for(actorOfType in getActorsOfType(getActorType(354)))
{
if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
            recycleActor(actorOfType);
}
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}