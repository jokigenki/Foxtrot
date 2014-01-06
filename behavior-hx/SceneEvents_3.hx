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



class SceneEvents_3 extends SceneScript
{          	
	
 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		
	}
	
	override public function init()
	{
		            setGameAttribute("Speed Run In Progress", false);
        runLater(1000 * 0.2, function(timeTask:TimedTask):Void {
                    getActor(17).setValue("Activate Door PM", "_Destination", "_Home|Tutorial_01|A|A");
                    scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_UnlockActor(getActor(17));
                    getActor(17).say("Collectable Door PM", "_customEvent_" + "DoorActivated");
                    if((!(getGameAttribute("Save Destination") == "none") && !(("" + getGameAttribute("Save Destination")).split("|")[Std.int(1)] == "_Home")))
{
                        setGameAttribute("Last Destination", "" + (scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ReverseDestination(getGameAttribute("Save Destination"))));
                        getActor(18).setValue("Activate Door PM", "_Destination", getGameAttribute("Save Destination"));
                        getActor(18).say("Collectable Door PM", "_customEvent_" + "DoorActivated");
}

                    if(getGameAttribute("Game Complete"))
{
                        getActor(19).setValue("Displays Popup PM", "_PopupType", getActorType(945));
                        getActor(19).setValue("Displays Popup PM", "_InactivePopupType", getActorType(945));
}

}, null);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}