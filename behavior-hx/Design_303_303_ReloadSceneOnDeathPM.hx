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



class Design_303_303_ReloadSceneOnDeathPM extends SceneScript
{          	
	
public var _FadeTime:Float;

public var _Scene:Scene;
    public function _customEvent_Reload():Void
{
        if(getGameAttribute("Speed Run In Progress"))
{
            sayToScene("Speed Run Timer PM", "_customBlock_SaveSpeedRunData");
}

        if(!(isTransitioning()))
{
            setGameAttribute("Last Destination", getGameAttribute("Save Destination"));
            if((_Scene == GameModel.get().scenes.get(getIDForScene(getCurrentSceneName()))))
{
                reloadCurrentScene(createFadeOut((_FadeTime)),createFadeIn((_FadeTime)));
}

            else
{
                switchScene(_Scene.getID(), createFadeOut((_FadeTime)),createFadeIn((_FadeTime)));
}

}

        else
{
            runLater(1000 * 1, function(timeTask:TimedTask):Void {
                        setGameAttribute("Last Destination", getGameAttribute("Save Destination"));
                        if((_Scene == GameModel.get().scenes.get(getIDForScene(getCurrentSceneName()))))
{
                            reloadCurrentScene(createFadeOut((_FadeTime)),createFadeIn((_FadeTime)));
}

                        else
{
                            switchScene(_Scene.getID(), createFadeOut((_FadeTime)),createFadeIn((_FadeTime)));
}

}, null);
}

}


 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Fade Time", "_FadeTime");
_FadeTime = 0.5;
nameMap.set("Scene", "_Scene");

	}
	
	override public function init()
	{
		            if((hasValue(_Scene) == false))
{
            _Scene = GameModel.get().scenes.get(getIDForScene(getCurrentSceneName())); 
            propertyChanged("_Scene", _Scene);
}


	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}