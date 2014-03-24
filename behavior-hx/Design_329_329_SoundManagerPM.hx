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
            setVolumeForChannel(100/100, Std.int(0));
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
        trace("" + (("" + "LOOP CURRENT MUSIC") + ("" + ("" + _Music))));
        sayToScene("Sound Manager PM", "_customBlock_LoopMusic", [_Music]);
}
    

/* Params are:__FadeOutTime __Music __FadeInTime */
public function _customBlock_FadeOutCurrent(__FadeOutTime:Float, __Music:Sound, __FadeInTime:Float):Void
{
        fadeOutSoundOnChannel(Std.int(0),__FadeOutTime);
        runLater(1000 * __FadeOutTime, function(timeTask:TimedTask):Void {
                    loopSoundOnChannel(__Music, Std.int(0));
                    if((__FadeOutTime > 0))
{
                        setVolumeForChannel(100/100, Std.int(0));
                        fadeInSoundOnChannel(Std.int(0),__FadeInTime);
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
            trace("" + "STOP CURRENT MUSIC");
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
    

/* Params are:__Sound __Volume */
public function _customBlock_PlaySoundAtVolume(__Sound:Sound, __Volume:Float):Void
{
        if(__Sound != null)
{
            setVolumeForChannel(__Volume/100, Std.int(1));
            playSoundOnChannel(__Sound, Std.int(1));
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
    

/* Params are:__SoundName __Volume */
public function _customBlock_PlayNamedSoundAtVolume(__SoundName:String, __Volume:Float):Void
{
        if(__SoundName != null)
{
            _Sound = cast((scripts.Design_207_207_StencylExtrasPM._customBlock_GetNamedSound(__SoundName)), Sound);
            if((hasValue(_Sound) != false))
{
                setVolumeForChannel(__Volume/100, Std.int(1));
                playSoundOnChannel(_Sound, Std.int(1));
}

            else
{
                trace("" + (("" + "Sound ") + ("" + (("" + "") + ("" + " is missing!")))));
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
    

/* Params are:__SoundSet __NumberOfSounds __Volume */
public function _customBlock_PlayRandomSoundAtVolume(__SoundSet:String, __NumberOfSounds:Float, __Volume:Float):Void
{
        if (__SoundSet == null || __SoundSet == "") return;
var soundIndex = randomInt(1, __NumberOfSounds);
var soundName = __SoundSet;
if (__NumberOfSounds > 1) soundName = soundName + " " + soundIndex + " SFX";
else soundName = soundName + " SFX";
var sound = cast(scripts.Design_207_207_StencylExtrasPM._customBlock_GetNamedSound(soundName), Sound);
if (sound == null)
{
	trace("Sound " + soundName + " is missing!");
	return;
}

        setVolumeForChannel(__Volume/100, Std.int(1));
        playSoundOnChannel(sound, Std.int(1));
}
    

/* Params are:__Sound __Channel */
public function _customBlock_LoopSoundOnChannel(__Sound:Sound, __Channel:Float):Void
{
        if(__Sound != null)
{
            trace("" + (("" + "Looping sound on ") + ("" + __Channel)));
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
        _LocalSceneSounds = getGameAttribute("Scene Sounds");
propertyChanged("_LocalSceneSounds", _LocalSceneSounds);
        _Count = asNumber(_LocalSceneSounds.length);
propertyChanged("_Count", _Count);
        if((_Count == 0))
{
            sayToScene("Sound Manager PM", "_customBlock_LoopSoundNamed", [__SoundName,(_Count + 2)]);
            _LocalSceneSounds.push((("" + __SoundName) + ("" + (("" + "|") + ("" + (("" + __SceneName) + ("" + (("" + "|") + ("" + _Count)))))))));
}

        else
{
            for(index0 in 0...Std.int((_Count + 1)))
{
                if((index0 == _Count))
{
                    sayToScene("Sound Manager PM", "_customBlock_LoopSoundNamed", [__SoundName,(_Count + 2)]);
                    _LocalSceneSounds.push((("" + __SoundName) + ("" + (("" + "|") + ("" + (("" + __SceneName) + ("" + (("" + "|") + ("" + _Count)))))))));
                    break;
}

                else if((_LocalSceneSounds[Std.int(index0)] == null))
{
                    sayToScene("Sound Manager PM", "_customBlock_LoopSoundNamed", [__SoundName,(index0 + 2)]);
                    _LocalSceneSounds.insert(Std.int(index0), (("" + __SoundName) + ("" + (("" + "|") + ("" + (("" + __SceneName) + ("" + (("" + "|") + ("" + index0)))))))));
                    break;
}

}

}

        setGameAttribute("Scene Sounds", _LocalSceneSounds);
}
    

/* Params are:__SoundName __SceneName __Actor */
public function _customBlock_LoopSceneSoundForActor(__SoundName:String, __SceneName:String, __Actor:Actor):Void
{
        if(cast((sayToScene("Sound Manager PM", "_customBlock_IsSceneSoundPlayingForActor", [__SoundName,__SceneName,__Actor])), Bool))
{
            return;
}

        _LocalSceneSounds = getGameAttribute("Scene Sounds");
propertyChanged("_LocalSceneSounds", _LocalSceneSounds);
        _Count = asNumber(_LocalSceneSounds.length);
propertyChanged("_Count", _Count);
        if((_Count == 0))
{
            sayToScene("Sound Manager PM", "_customBlock_LoopSoundNamed", [__SoundName,(_Count + 2)]);
            _LocalSceneSounds.push((("" + (("" + (("" + __SoundName) + ("" + "|"))) + ("" + (("" + (("" + __SceneName) + ("" + "|"))) + ("" + (("" + _Count) + ("" + "|"))))))) + ("" + "" + (scripts.Design_27_27_ActorExtrasPM._customBlock_SceneNameForActor(__Actor)))));
}

        else
{
            for(index0 in 0...Std.int((_Count + 1)))
{
                if((index0 == _Count))
{
                    sayToScene("Sound Manager PM", "_customBlock_LoopSoundNamed", [__SoundName,(_Count + 2)]);
                    _LocalSceneSounds.push((("" + (("" + (("" + __SoundName) + ("" + "|"))) + ("" + (("" + (("" + __SceneName) + ("" + "|"))) + ("" + (("" + _Count) + ("" + "|"))))))) + ("" + "" + (scripts.Design_27_27_ActorExtrasPM._customBlock_SceneNameForActor(__Actor)))));
                    break;
}

                else if((_LocalSceneSounds[Std.int(index0)] == null))
{
                    sayToScene("Sound Manager PM", "_customBlock_LoopSoundNamed", [__SoundName,(index0 + 2)]);
                    _LocalSceneSounds.insert(Std.int(index0), (("" + (("" + (("" + __SoundName) + ("" + "|"))) + ("" + (("" + (("" + __SceneName) + ("" + "|"))) + ("" + (("" + index0) + ("" + "|"))))))) + ("" + "" + (scripts.Design_27_27_ActorExtrasPM._customBlock_SceneNameForActor(__Actor)))));
                    break;
}

}

}

        setGameAttribute("Scene Sounds", _LocalSceneSounds);
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
		trace("Stop sound on channel " + (channel + 2));
		stopSoundOnChannel(channel + 2);
		_LocalSceneSounds[index0] = null;
		break;
	}
}


            setGameAttribute("Scene Sounds", _LocalSceneSounds);
}

}
    

/* Params are:__SoundName __SceneName __Actor */
public function _customBlock_StopSceneSoundForActor(__SoundName:String, __SceneName:String, __Actor:Actor):Void
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
	var actorName = "" + comps[3];
	var thisActorName = scripts.Design_27_27_ActorExtrasPM._customBlock_SceneNameForActor(__Actor);

	if (sceneName == __SceneName &&
		soundName == __SoundName &&
		actorName == thisActorName)
	{
		trace("Stop sound on channel " + (channel + 2));
		stopSoundOnChannel(channel + 2);
		_LocalSceneSounds[index0] = null;
		break;
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
    

/* Params are:__SoundName __SceneName __Actor */
public function _customBlock_IsSceneSoundPlayingForActor(__SoundName:String, __SceneName:String, __Actor:Actor):Bool
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
	var actorName = "" + comps[3];
	var thisActorName = scripts.Design_27_27_ActorExtrasPM._customBlock_SceneNameForActor(__Actor);

	if (sceneName == __SceneName && 
		soundName == __SoundName &&
		actorName == thisActorName)
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
            loopSoundOnChannel(_Sound, Std.int(__Channel));
}

        else
{
            trace("" + (("" + "Sound ") + ("" + (("" + __SoundName) + ("" + " is missing!")))));
}

}
    

/* Params are:__SceneName */
public function _customBlock_StopAllSceneSounds(__SceneName:String):Void
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
	//ignore the actor name as we need to stop all sounds
	
	if (sceneName == __SceneName)
	{
		stopSoundOnChannel(channel + 2);
		_LocalSceneSounds[index0] = null;
	}
}


            setGameAttribute("Scene Sounds", _LocalSceneSounds);
}

}
    

/* Params are:__SceneName */
public function _customBlock_StopAllOtherSceneSounds(__SceneName:String):Void
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
	//ignore actor name as we need to stop all sounds
	
	if (sceneName != __SceneName)
	{
		stopSoundOnChannel(channel + 2);
		_LocalSceneSounds[index0] = null;
	}
}


            setGameAttribute("Scene Sounds", _LocalSceneSounds);
}

}
    

/* Params are:__Sound __Music __Delay */
public function _customBlock_PlaySoundThenMusic(__Sound:Sound, __Music:Sound, __Delay:Float):Void
{
        sayToScene("Sound Manager PM", "_customBlock_StopCurrentMusic");
        sayToScene("Sound Manager PM", "_customBlock_PlaySound", [__Sound]);
        runLater(1000 * __Delay, function(timeTask:TimedTask):Void {
                    sayToScene("Sound Manager PM", "_customBlock_LoopMusic", [__Music]);
}, null);
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
		            sayToScene("Sound Manager PM", "_customBlock_StopAllOtherSceneSounds", [getCurrentSceneName()]);
        runPeriodically(1000 * 0.05, function(timeTask:TimedTask):Void {
                    if(getGameAttribute("Game Was Loaded"))
{
                        if(((hasValue(_Music) != false) && getGameAttribute("Is Music On?")))
{
                            if(!(getGameAttribute("Current Music") == ("" + _Music)))
{
                                sayToScene("Sound Manager PM", "_customBlock_FadeOutCurrent", [0.2,_Music,0]);
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
    addKeyStateListener("Esc", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void {
if(wrapper.enabled && pressed){
        saveGame("mySave", function(success:Bool):Void {
            switchScene(52, createFadeOut((0.5)),createFadeIn((0.5)));
});
}
});
    addFocusChangeListener(function(lost:Bool, list:Array<Dynamic>):Void {
if(wrapper.enabled && lost){
        sayToScene("Sound Manager PM", "_customBlock_StopAllSceneSounds", [getCurrentSceneName()]);
}
});
    addFocusChangeListener(function(lost:Bool, list:Array<Dynamic>):Void {
if(wrapper.enabled && !lost){
        runPeriodically(1000 * 0.05, function(timeTask:TimedTask):Void {
                    if(getGameAttribute("Game Was Loaded"))
{
                        if(((hasValue(_Music) != false) && getGameAttribute("Is Music On?")))
{
                            if(!(getGameAttribute("Current Music") == ("" + _Music)))
{
                                sayToScene("Sound Manager PM", "_customBlock_FadeOutCurrent", [0.2,_Music,0]);
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
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}