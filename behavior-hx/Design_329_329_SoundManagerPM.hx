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

public var _Count:Float;

public var _LocalSceneSounds:Array<Dynamic>;

public var _Sound:Sound;
    

/* Params are:__Music */
public function _customBlock_LoopMusic(__Music:Sound):Void
{
        if(!(getGameAttribute("Current Music") == ("" + __Music)))
{
            loopSoundOnChannel(__Music, Std.int(0));
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
        fadeOutSoundOnChannel(Std.int(0),__FadeOutTime);
        runLater(1000 * __FadeOutTime, function(timeTask:TimedTask):Void {
                    playSoundOnChannel(__Music, Std.int(0));
                    if((__FadeOutTime > 0))
{
                        setVolumeForChannel(0/100, Std.int(0));
                        fadeInSoundOnChannel(Std.int(0),__FadeOutTime);
}

                    setGameAttribute("Current Music", ("" + __Music));
                    setGameAttribute("Is Music On?", true);
}, null);
}
    

/* Params are:*/
public function _customBlock_StopCurrentMusic():Void
{
        if(getGameAttribute("Is Music On?"))
{
            stopSoundOnChannel(Std.int(0));
            setGameAttribute("Current Music", "None");
            setGameAttribute("Is Music On?", false);
}

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
            _Sound = cast((scripts.Design_207_207_StencylExtrasPM._customBlock_GetNamedSound(__SoundName)), Sound);
            if((hasValue(_Sound) != false))
{
                playSound(_Sound);
}

            else
{
                trace("" + (("" + "Sound ") + ("" + (("" + __SoundName) + ("" + " is missing!")))));
}

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
	trace("Sound " + soundName + " is missing!");
	return;
}

        playSound(sound);
}
    

/* Params are:__Sound __Channel */
public function _customBlock_LoopSoundOnChannel(__Sound:Sound, __Channel:Float):Void
{
        if(__Sound != null)
{
            loopSoundOnChannel(__Sound, Std.int(__Channel));
}

        else
{
            trace("" + "Missing Sound for loop on channel!");
}

}
    

/* Params are:__SoundName __SceneName */
public function _customBlock_LoopSceneSound(__SoundName:String, __SceneName:String):Void
{
        if(cast((sayToScene("Sound Manager PM", "_customBlock_IsSceneSoundPlaying", [__SoundName,__SceneName])), Bool))
{
            return;
}

        _Count = asNumber(getGameAttribute("Scene Sounds").length);
propertyChanged("_Count", _Count);
        if((_Count == 0))
{
            sayToScene("Sound Manager PM", "_customBlock_LoopSoundNamed", [__SoundName,(_Count + 1)]);
            getGameAttribute("Scene Sounds").push((("" + __SoundName) + ("" + (("" + "|") + ("" + (("" + __SceneName) + ("" + (("" + "|") + ("" + _Count)))))))));
}

        else
{
            for(index0 in 0...Std.int((_Count + 1)))
{
                if((index0 == _Count))
{
                    sayToScene("Sound Manager PM", "_customBlock_LoopSoundNamed", [__SoundName,(_Count + 1)]);
                    getGameAttribute("Scene Sounds").push((("" + __SoundName) + ("" + (("" + "|") + ("" + (("" + __SceneName) + ("" + (("" + "|") + ("" + _Count)))))))));
                    break;
}

                else if((getGameAttribute("Scene Sounds")[Std.int(index0)] == null))
{
                    sayToScene("Sound Manager PM", "_customBlock_LoopSoundNamed", [__SoundName,(_Count + 1)]);
                    getGameAttribute("Scene Sounds").insert(Std.int(index0), (("" + __SoundName) + ("" + (("" + "|") + ("" + (("" + __SceneName) + ("" + (("" + "|") + ("" + _Count)))))))));
                    break;
}

}

}

}
    

/* Params are:__SoundName __SceneName */
public function _customBlock_StopSceneSound(__SoundName:String, __SceneName:String):Void
{
        _LocalSceneSounds = getGameAttribute("Scene Sounds");
propertyChanged("_LocalSceneSounds", _LocalSceneSounds);
        _Count = asNumber(_LocalSceneSounds.length);
propertyChanged("_Count", _Count);
        for(index0 in 0...Std.int(_Count))
{
            var item = _LocalSceneSounds[index0];
if (item != null)
{
	var comps = item.split("|");
	var soundName = comps[0];
	var sceneName = "" + comps[1];
	var channel = Std.parseInt(comps[2]);

	if (sceneName == __SceneName && soundName == __SoundName)
	{
		stopSoundOnChannel(channel + 1);
		_LocalSceneSounds[index0] = null;
	}
}


            setGameAttribute("Scene Sounds", _LocalSceneSounds);
}

}
    

/* Params are:__SoundName __SceneName */
public function _customBlock_IsSceneSoundPlaying(__SoundName:String, __SceneName:String):Bool
{
        _LocalSceneSounds = getGameAttribute("Scene Sounds");
propertyChanged("_LocalSceneSounds", _LocalSceneSounds);
        _Count = asNumber(_LocalSceneSounds.length);
propertyChanged("_Count", _Count);
        for(index0 in 0...Std.int(_Count))
{
            var item = _LocalSceneSounds[index0];
if (item != null)
{
	var comps = item.split("|");
	var soundName = comps[0];
	var sceneName = "" + comps[1];

	if (sceneName == __SceneName && soundName == __SoundName)
	{
		return true;
	}
}

}

        return false;
}
    

/* Params are:__SoundName __Channel */
public function _customBlock_LoopSoundNamed(__SoundName:String, __Channel:Float):Void
{
        trace("" + (("" + "LOOPING ") + ("" + (("" + __SoundName) + ("" + (("" + " ON ") + ("" + __Channel)))))));
        _Sound = cast((scripts.Design_207_207_StencylExtrasPM._customBlock_GetNamedSound(__SoundName)), Sound);
        if((hasValue(_Sound) != false))
{
            loopSoundOnChannel(cast((scripts.Design_207_207_StencylExtrasPM._customBlock_GetNamedSound(__SoundName)), Sound), Std.int(__Channel));
}

        else
{
            trace("" + (("" + "Sound ") + ("" + (("" + __SoundName) + ("" + " is missing!")))));
}

}

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Music", "_Music");
nameMap.set("Sound UI Actor", "_SoundUIActor");
nameMap.set("Count", "_Count");
_Count = 0.0;
nameMap.set("Local Scene Sounds", "_LocalSceneSounds");
_LocalSceneSounds = [];
nameMap.set("Sound", "_Sound");

	}
	
	override public function init()
	{
		            _LocalSceneSounds = getGameAttribute("Scene Sounds");
propertyChanged("_LocalSceneSounds", _LocalSceneSounds);
        _Count = asNumber(_LocalSceneSounds.length);
propertyChanged("_Count", _Count);
        for(index0 in 0...Std.int(_Count))
{
            var item = _LocalSceneSounds[index0];
if (item != null)
{
	var comps = item.split("|");
	var soundName = comps[0];
	var sceneName = "" + comps[1];
	var channel = Std.parseInt(comps[2]);

	if (sceneName != getCurrentSceneName())
	{
		stopSoundOnChannel(channel + 1);
		_LocalSceneSounds[index0] = null;
	}
}


            setGameAttribute("Scene Sounds", _LocalSceneSounds);
}

        runPeriodically(1000 * 0.1, function(timeTask:TimedTask):Void {
                    if(getGameAttribute("Game Was Loaded"))
{
                        if(((hasValue(_Music) != false) && getGameAttribute("Is Music On?")))
{
                            if(!(getGameAttribute("Current Music") == ("" + _Music)))
{
                                sayToScene("Sound Manager PM", "_customBlock_FadeOutCurrent", [1,_Music,0]);
}

                            else
{
                                sayToScene("Sound Manager PM", "_customBlock_LoopCurrentMusic");
}

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