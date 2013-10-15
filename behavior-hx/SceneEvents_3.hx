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



class SceneEvents_3 extends SceneScript
{          	
	
 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		
	}
	
	override public function init()
	{
		            if(!(getGameAttribute("Game Was Loaded")))
{
            loadGame("mySave", function(success:Bool):Void {
                if(success)
{
                    setGameAttribute("Game Was Loaded", true);
                    if((!(getGameAttribute("Save Destination") == "none") && !(("" + getGameAttribute("Save Destination")).split("|")[Std.int(1)] == "_Home")))
{
                        runLater(1000 * 0.5, function(timeTask:TimedTask):Void {
                                    trace("" + (("" + "Last scene: ") + ("" + getGameAttribute("Save Destination"))));
                                    getActor(18).setValue("Activate Door PM", "_Destination", getGameAttribute("Save Destination"));
                                    getActor(18).say("Activate Door PM", "_customEvent_" + "ActivateDoor");
                                    getActor(18).say("Collectable Door PM", "_customEvent_" + "DoorActivated");
}, null);
}

}

                else
{
                    setGameAttribute("Game Was Loaded", false);
}

});
}


	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}