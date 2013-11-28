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



class Design_202_202_TimerPM extends SceneScript
{          	
	
public var _TimerRunning:Bool;

public var _TimerCancelled:Bool;

public var _RunComplete:Bool;

public var _LocalSpeedRunTime:Float;

public var _LocalSpeedRunSuccessTime:Float;

public var _LocalRunInProgress:Bool;

public var _LocalSpeedRunCollectables:Array<Dynamic>;

public var _CollectedSpeedRunItems:Array<Dynamic>;

public var _XPosition:Float;

public var _YPosition:Float;

public var _DoorToOpen:Actor;

public var _KeyToKill:Actor;
    public function _customEvent_TimerReset():Void
{
        _TimerCancelled = true;
propertyChanged("_TimerCancelled", _TimerCancelled);
        _LocalRunInProgress = false;
propertyChanged("_LocalRunInProgress", _LocalRunInProgress);
        _LocalSpeedRunTime = asNumber(0);
propertyChanged("_LocalSpeedRunTime", _LocalSpeedRunTime);
        setGameAttribute("Speed Run Timer", 0);
        setGameAttribute("Speed Run In Progress", false);
        scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_EmptySpeedRunCollected();
        scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_LockAllSpeedRunDoors();
}

    public function _customEvent_ItemAddedToInventory():Void
{
        if(!(getGameAttribute("Speed Run In Progress")))
{
            return;
}

        _RunComplete = true;
propertyChanged("_RunComplete", _RunComplete);
        _LocalSpeedRunCollectables = getGameAttribute("Speed Run Collectables");
propertyChanged("_LocalSpeedRunCollectables", _LocalSpeedRunCollectables);
        _CollectedSpeedRunItems = getGameAttribute("Collected Speed Run Items");
propertyChanged("_CollectedSpeedRunItems", _CollectedSpeedRunItems);
        for(item in cast(_LocalSpeedRunCollectables, Array<Dynamic>))
{
            if(!(Utils.contains(_CollectedSpeedRunItems, item)))
{
                trace("" + (("" + "missing ") + ("" + (("" + "") + ("" + item)))));
                _RunComplete = false;
propertyChanged("_RunComplete", _RunComplete);
                break;
}

}

        if(_RunComplete)
{
            sayToScene("Speed Run Timer PM", "_customEvent_" + "CompleteSpeedRun");
}

}

    

/* Params are:__Time */
public function _customBlock_ConvertNumberToTimeString(__Time:Float):String
{
        if (__Time < 0) return "0:00";
var mins = Math.floor(__Time / 60);
var secs = __Time - (mins * 60);

var minsString = Std.string(mins);
var secsString = secs < 10 ? "0" + secs : "" + secs;

return minsString + ":" + secsString;
}
    

/* Params are:*/
public function _customBlock_SaveSpeedRunData():Void
{
        setGameAttribute("Speed Run In Progress", _LocalRunInProgress);
        setGameAttribute("Speed Run Timer", _LocalSpeedRunTime);
}
    public function _customEvent_EggCollected():Void
{
        if((getGameAttribute("Speed Run In Progress") && _DoorToOpen != null))
{
            _DoorToOpen.say("Collectable Door PM", "_customEvent_" + "KeyCollected");
}

}

    public function _customEvent_CompleteSpeedRun():Void
{
        sayToScene("Speed Run Timer PM", "_customEvent_" + "TimerReset");
        scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_CollectItemWithType("Egg1_Speed",getActorType(178));
}


 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Timer Running?", "_TimerRunning");
_TimerRunning = false;
nameMap.set("Timer Cancelled?", "_TimerCancelled");
_TimerCancelled = false;
nameMap.set("Run Complete?", "_RunComplete");
_RunComplete = false;
nameMap.set("Local Speed Run Time", "_LocalSpeedRunTime");
_LocalSpeedRunTime = 0.0;
nameMap.set("Local Speed Run Success Time", "_LocalSpeedRunSuccessTime");
_LocalSpeedRunSuccessTime = 0.0;
nameMap.set("Local Run In Progress?", "_LocalRunInProgress");
_LocalRunInProgress = false;
nameMap.set("Local Speed Run Collectables", "_LocalSpeedRunCollectables");
_LocalSpeedRunCollectables = [];
nameMap.set("Collected Speed Run Items", "_CollectedSpeedRunItems");
_CollectedSpeedRunItems = [];
nameMap.set("X Position", "_XPosition");
_XPosition = 288.0;
nameMap.set("Y Position", "_YPosition");
_YPosition = 30.0;
nameMap.set("Door To Open", "_DoorToOpen");
nameMap.set("Key To Kill", "_KeyToKill");

	}
	
	override public function init()
	{
		            if(getGameAttribute("Speed Run In Progress"))
{
            _LocalRunInProgress = getGameAttribute("Speed Run In Progress");
propertyChanged("_LocalRunInProgress", _LocalRunInProgress);
            _TimerRunning = true;
propertyChanged("_TimerRunning", _TimerRunning);
            _LocalSpeedRunTime = asNumber(getGameAttribute("Speed Run Timer"));
propertyChanged("_LocalSpeedRunTime", _LocalSpeedRunTime);
            _LocalSpeedRunSuccessTime = asNumber(getGameAttribute("Speed Run Success Time"));
propertyChanged("_LocalSpeedRunSuccessTime", _LocalSpeedRunSuccessTime);
            if(_KeyToKill != null)
{
                recycleActor(_KeyToKill);
}

            runPeriodically(1000 * 1, function(timeTask:TimedTask):Void {
                        if((_LocalRunInProgress && !(_TimerCancelled)))
{
                            _LocalSpeedRunTime += 1;
propertyChanged("_LocalSpeedRunTime", _LocalSpeedRunTime);
                            if((_LocalSpeedRunTime >= _LocalSpeedRunSuccessTime))
{
                                sayToScene("Speed Run Timer PM", "_customEvent_" + "TimerReset");
                                if(isTransitioning())
{
                                    runLater(1000 * 1.5, function(timeTask:TimedTask):Void {
                                                switchScene(GameModel.get().scenes.get(getIDForScene(getGameAttribute("Speed Run Start"))).getID(), createFadeOut((0.5)),createFadeIn((0.5)));
}, null);
}

                                else
{
                                    switchScene(GameModel.get().scenes.get(getIDForScene(getGameAttribute("Speed Run Start"))).getID(), createFadeOut((0.5)),createFadeIn((0.5)));
}

}

}

                        else
{
                            trace("" + "stopping timer");
                            _TimerRunning = false;
propertyChanged("_TimerRunning", _TimerRunning);
                            _TimerCancelled = true;
propertyChanged("_TimerCancelled", _TimerCancelled);
                            setGameAttribute("Speed Run In Progress", false);
                            scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_EmptySpeedRunCollected();
                            scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_LockAllSpeedRunDoors();
                            timeTask.repeats = false;
return;
}

}, null);
}

    addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((_LocalRunInProgress && _TimerRunning))
{
            if(((_LocalSpeedRunSuccessTime - _LocalSpeedRunTime) < 11))
{
                g.setFont(getFont(343));
}

            else
{
                g.setFont(getFont(342));
}

            g.drawString("" + "" + (sayToScene("Speed Run Timer PM", "_customBlock_ConvertNumberToTimeString", [(_LocalSpeedRunSuccessTime - _LocalSpeedRunTime)])), _XPosition, _YPosition);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}