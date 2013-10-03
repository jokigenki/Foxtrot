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
            switchScene(_Scene.getID(), createFadeOut((_FadeTime)),createFadeIn((_FadeTime)));
}

        else
{
            runLater(1000 * 1, function(timeTask:TimedTask):Void {
                        switchScene(_Scene.getID(), createFadeOut((_FadeTime)),createFadeIn((_FadeTime)));
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
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}