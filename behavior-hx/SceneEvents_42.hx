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



class SceneEvents_42 extends SceneScript
{          	
	
public var _WasInitialised:Bool;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Was Initialised?", "_WasInitialised");
_WasInitialised = false;

	}
	
	override public function init()
	{
		            if(!(getGameAttribute("Game Was Loaded")))
{
            loadGame("mySave", function(success:Bool):Void {
                if(success)
{
                    setGameAttribute("Current Music", "None");
                    setGameAttribute("Current Atlases", "0");
                    setGameAttribute("Game Was Loaded", true);
                    setGameAttribute("Speed Run In Progress", false);
}

                else
{
                    setGameAttribute("Game Was Loaded", false);
}

});
}

    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((getGameAttribute("Game Was Loaded") && !(_WasInitialised)))
{
            _WasInitialised = true;
propertyChanged("_WasInitialised", _WasInitialised);
            /* "load shared and home atlases" */
            trace("" + getGameAttribute("Save Destination"));
            runLater(1000 * 5, function(timeTask:TimedTask):Void {
                        if((!(getGameAttribute("Save Destination") == "none") && (("" + getGameAttribute("Save Destination")).indexOf("Tutorial") == -1)))
{
                            setGameAttribute("Last Destination", "_Home|_Home|A|A");
                            shoutToScene("_customEvent_" + "SwitchScene");
}

                        else
{
                            setGameAttribute("Game Was Loaded", true);
                            setGameAttribute("Collected Items", new Array<Dynamic>());
                            setGameAttribute("Collected Speed Run Items", new Array<Dynamic>());
                            setGameAttribute("Inventory New", new Array<Dynamic>());
                            setGameAttribute("Inventory", new Array<Dynamic>());
                            setGameAttribute("Speed Run Collectables", new Array<Dynamic>());
                            setGameAttribute("Unlocked Doors", new Array<Dynamic>());
                            setGameAttribute("Unlocked Speed Run Doors", new Array<Dynamic>());
                            setGameAttribute("Gold Keys", 0);
                            setGameAttribute("Speed Run Timer", 0);
                            setGameAttribute("Save Destination", "none");
                            setGameAttribute("Last Destination", "none");
                            setGameAttribute("In Pants?", false);
                            saveGame("mySave", function(success:Bool):Void {
                                setGameAttribute("Last Destination", "Tutorial_01|Tutorial_01|A|A");
                                shoutToScene("_customEvent_" + "SwitchScene");
});
}

}, null);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}