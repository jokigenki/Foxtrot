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



class Design_329_329_SoundManagerPM extends SceneScript
{          	
	
public var _Music:Sound;

public var _SoundUIActor:Actor;
    

/* Params are:__Music */
public function _customBlock_LoopMusic(__Music:Sound):Void
{
        if(!(getGameAttribute("Current Music") == ("" + __Music)))
{
            stopAllSounds();
            loopSound(__Music);
            setGameAttribute("Current Music", ("" + __Music));
            setGameAttribute("Is Music On?", true);
            if((hasValue(_SoundUIActor) != false))
{
                _SoundUIActor.say("Music Toggle PM", "_customEvent_" + "MusicOn");
}

}

}
    

/* Params are:*/
public function _customBlock_LoopCurrentMusic():Void
{
        sayToScene("Sound Manager PM", "_customBlock_LoopMusic", [_Music]);
}
    

/* Params are:__FadeOutTime __Music __FadeInTime */
public function _customBlock_FadeOutCurrent(__FadeOutTime:Float, __Music:Sound, __FadeInTime:Float):Void
{
        fadeOutForAllSounds(__FadeOutTime);
        runLater(1000 * __FadeOutTime, function(timeTask:TimedTask):Void {
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
        setGameAttribute("Is Music On?", false);
        if((hasValue(_SoundUIActor) != false))
{
            _SoundUIActor.say("Music Toggle PM", "_customEvent_" + "MusicOff");
}

}
    

/* Params are:__Sound */
public function _customBlock_PlaySound(__Sound:Sound):Void
{
        if(__Sound != null)
{
            playSound(__Sound);
}

}
    

/* Params are:__SoundName */
public function _customBlock_PlayNamedSound(__SoundName:String):Void
{
        if(__SoundName != null)
{
            playSound(cast((scripts.Design_207_207_StencylExtrasPM._customBlock_GetNamedSound(__SoundName)), Sound));
}

}
    

/* Params are:__SetName __NumberOfSounds */
public function _customBlock_PlayRandomSoundFromSet(__SetName:String, __NumberOfSounds:Float):Void
{
        if (__SetName == null || __SetName == "") return;
var soundIndex = randomInt(1, __NumberOfSounds);
var soundName = __SetName;
if (__NumberOfSounds > 1) soundName = soundName + " " + soundIndex + " SFX";
else soundName = soundName + " SFX";
var sound = cast(scripts.Design_207_207_StencylExtrasPM._customBlock_GetNamedSound(soundName), Sound);
if (sound == null)
{
	trace(soundName + " is missing");
	return;
}

        playSound(sound);
}
    

/* Params are:__Sound __Channel */
public function _customBlock_LoopSoundOnChannel(__Sound:Sound, __Channel:Float):Void
{
        loopSoundOnChannel(__Sound, Std.int(__Channel));
}

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Music", "_Music");
nameMap.set("Sound UI Actor", "_SoundUIActor");

	}
	
	override public function init()
	{
		            runPeriodically(1000 * 0.1, function(timeTask:TimedTask):Void {
                    if(getGameAttribute("Game Was Loaded"))
{
                        if(((hasValue(_Music) != false) && getGameAttribute("Is Music On?")))
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