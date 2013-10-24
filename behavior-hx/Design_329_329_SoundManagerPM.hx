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



class Design_329_329_SoundManagerPM extends SceneScript
{          	
	
public var _Music:Sound;
    

/* Params are:__Music */
public function _customBlock_LoopMusic(__Music:Sound):Void
{
        trace("" + (("" + "CURRENT: ") + ("" + getGameAttribute("Current Music"))));
        trace("" + (("" + "NEW: ") + ("" + ("" + __Music))));
        if(!(getGameAttribute("Current Music") == ("" + __Music)))
{
            stopAllSounds();
            loopSound(__Music);
            setGameAttribute("Current Music", ("" + __Music));
            setGameAttribute("Music On", true);
}

}
    

/* Params are:__FadeOutTime __Music __FadeInTime */
public function _customBlock_FadeOutCurrent(__FadeOutTime:Float, __Music:Sound, __FadeInTime:Float):Void
{
        fadeOutForAllSounds(__FadeOutTime);
        runLater(1000 * __FadeOutTime, function(timeTask:TimedTask):Void {
                    stopAllSounds();
                    loopSound(__Music);
                    fadeInForAllSounds(__FadeInTime);
                    setGameAttribute("Current Music", ("" + __Music));
}, null);
}
    

/* Params are:*/
public function _customBlock_StopCurrentMusic():Void
{
        stopAllSounds();
        setGameAttribute("Current Music", "None");
        setGameAttribute("Music On", false);
}
    

/* Params are:*/
public function _customBlock_LoopCurrentMusic():Void
{
        sayToScene("Sound Manager PM", "_customBlock_LoopMusic", [_Music]);
}

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Music", "_Music");

	}
	
	override public function init()
	{
		            runPeriodically(1000 * 0.1, function(timeTask:TimedTask):Void {
                    if(getGameAttribute("Game Was Loaded"))
{
                        if((getGameAttribute("Music On") && (hasValue(_Music) != false)))
{
                            sayToScene("Sound Manager PM", "_customBlock_LoopMusic", [_Music]);
}

                        else
{
                            sayToScene("Sound Manager PM", "_customBlock_StopCurrentMusic");
}

                        timeTask.repeats = false;
return;
}

}, null);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}