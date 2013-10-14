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



class Design_21_21_SceneTransitionPM extends SceneScript
{          	
	    public function _customEvent_SwitchScene():Void
{
        if(isTransitioning())
{
            runLater(1000 * 1, function(timeTask:TimedTask):Void {
                        sayToScene("Scene Transition PM", "_customBlock_DoSwitchScene");
}, null);
}

        else
{
            sayToScene("Scene Transition PM", "_customBlock_DoSwitchScene");
}

}

    

/* Params are:*/
public function _customBlock_DoSwitchScene():Void
{
        if(("" + getGameAttribute("Last Destination")) == (""))
{
            return;
}

        var nextScene = getGameAttribute("Last Destination").split("|")[1];
        if((nextScene == getCurrentSceneName()))
{
            return;
}

        if(sceneHasBehavior("Speed Run Timer PM"))
{
            sayToScene("Speed Run Timer PM", "_customBlock_SaveSpeedRunData");
}

        if((nextScene.indexOf("Farm") > -1))
{
            trace("" + "loading farm atlas, unloading factory");
            loadAtlas(Std.int(2));
            loadAtlas(Std.int(0));
            unloadAtlas(Std.int(1));
}

        else if((nextScene.indexOf("Factory") > -1))
{
            trace("" + "unloading farm atlas, loading factory");
            loadAtlas(Std.int(0));
            loadAtlas(Std.int(1));
            unloadAtlas(Std.int(2));
}

        else
{
            trace("" + "unloading farm atlas, unloading factory");
            loadAtlas(Std.int(0));
            unloadAtlas(Std.int(1));
            unloadAtlas(Std.int(2));
}

        switchScene(GameModel.get().scenes.get(getIDForScene(("" + getGameAttribute("Last Destination")).split("|")[Std.int(1)])).getID(), createFadeOut((0.5)),createFadeIn((0.5)));
}

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		
	}
	
	override public function init()
	{
		            if((getGameAttribute("Game Was Loaded") && !(getGameAttribute("Speed Run In Progress"))))
{
            saveGame("mySave", function(success:Bool):Void {

});
}


	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}