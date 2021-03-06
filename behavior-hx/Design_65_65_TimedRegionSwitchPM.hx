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

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_65_65_TimedRegionSwitchPM extends ActorScript
{          	
	
public var _OnAnimation:String;

public var _SwitchAfterSeconds:Float;

public var _IsActive:Bool;

public var _OffAnimation:String;

public var _SwitchRegion:Region;

public var _IsPressed:Bool;

public var _TimeElapsed:Float;

public var _SwitchTargetIDs:Array<Dynamic>;

public var _OfftoOnAnimation:String;

public var _StartState:Bool;

public var _IsRunning:Bool;

public var _OntoOffAnimation:String;

public var _SFX:Sound;

public var _Beatsperframe:Float;

public var _SFXOff:Sound;
    

/* Params are: */
public function _customBlock_EnterSwitch():Void
{
var __Self:Actor = actor;
        _IsActive = !(_StartState);
propertyChanged("_IsActive", _IsActive);
        _IsPressed = true;
propertyChanged("_IsPressed", _IsPressed);
        _IsRunning = false;
propertyChanged("_IsRunning", _IsRunning);
        dispatchPreEvent();
        scripts.Design_165_165_MoveOnActivatedPM._customBlock_ActivateList(_SwitchTargetIDs,_IsActive);
        _TimeElapsed = asNumber(0);
propertyChanged("_TimeElapsed", _TimeElapsed);
        dispatchEvent();
        actor.say("Timed Region Switch PM", "_customBlock_UpdateSwitchAnimation");
        sayToScene("Sound Manager PM", "_customBlock_PlaySound", [_SFX]);
}
    

/* Params are: */
public function _customBlock_ExitSwitch():Void
{
var __Self:Actor = actor;
        _IsPressed = false;
propertyChanged("_IsPressed", _IsPressed);
        _IsRunning = true;
propertyChanged("_IsRunning", _IsRunning);
        runPeriodically(1000 * 0.1, function(timeTask:TimedTask):Void {
                    if((_IsPressed || (_IsActive == _StartState)))
{
                        timeTask.repeats = false;
return;
}

                    _TimeElapsed += 1;
propertyChanged("_TimeElapsed", _TimeElapsed);
                    if(((_TimeElapsed / 10) >= _SwitchAfterSeconds))
{
                        _IsActive = _StartState;
propertyChanged("_IsActive", _IsActive);
                        scripts.Design_165_165_MoveOnActivatedPM._customBlock_ActivateList(_SwitchTargetIDs,_IsActive);
                        _TimeElapsed = asNumber(0);
propertyChanged("_TimeElapsed", _TimeElapsed);
                        dispatchEvent();
                        _IsRunning = false;
propertyChanged("_IsRunning", _IsRunning);
                        actor.say("Timed Region Switch PM", "_customBlock_UpdateSwitchAnimation");
                        sayToScene("Sound Manager PM", "_customBlock_PlaySound", [_SFXOff]);
}

}, actor);
        actor.say("Timed Region Switch PM", "_customBlock_UpdateSwitchAnimation");
}
    

/* Params are: */
public function _customBlock_UpdateSwitchAnimation():Void
{
var __Self:Actor = actor;
        if(_IsRunning)
{
            if(_IsActive)
{
                actor.setAnimation("" + _OntoOffAnimation);
}

            else
{
                actor.setAnimation("" + _OfftoOnAnimation);
}

            _Beatsperframe = asNumber(((_SwitchAfterSeconds / actor.getNumFrames()) * 10));
propertyChanged("_Beatsperframe", _Beatsperframe);
}

        else
{
            if(_IsActive)
{
                actor.setAnimation("" + _OnAnimation);
}

            else
{
                actor.setAnimation("" + _OffAnimation);
}

}

}
            public function dispatchEvent () 
{
	var actorname = scripts.Design_27_27_ActorExtrasPM._customBlock_SceneNameForActor(actor);
	actorname = actorname.split(" ").join("");
	shoutToScene("_customEvent_" + actorname + "Switched" + (_IsActive ? "On" : "Off"));
}
            public function dispatchPreEvent () 
{
	var actorname = scripts.Design_27_27_ActorExtrasPM._customBlock_SceneNameForActor(actor);
	actorname = actorname.split(" ").join("");
	shoutToScene("_customEvent_" + actorname + "PreSwitched" + (_IsActive ? "On" : "Off"));
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("On Animation", "_OnAnimation");
nameMap.set("Switch After Seconds", "_SwitchAfterSeconds");
_SwitchAfterSeconds = 0.0;
nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Off Animation", "_OffAnimation");
nameMap.set("Switch Region", "_SwitchRegion");
nameMap.set("Is Pressed?", "_IsPressed");
_IsPressed = false;
nameMap.set("Time Elapsed", "_TimeElapsed");
_TimeElapsed = 0.0;
nameMap.set("Switch Target IDs", "_SwitchTargetIDs");
_SwitchTargetIDs = [];
nameMap.set("Actor", "actor");
nameMap.set("Off to On Animation", "_OfftoOnAnimation");
nameMap.set("Start State", "_StartState");
_StartState = false;
nameMap.set("Is Running?", "_IsRunning");
_IsRunning = false;
nameMap.set("On to Off Animation", "_OntoOffAnimation");
nameMap.set("SFX", "_SFX");
_SFX = getSound(800);
nameMap.set("Beats per frame", "_Beatsperframe");
_Beatsperframe = 0.0;
nameMap.set("SFX Off", "_SFXOff");

	}
	
	override public function init()
	{
		            createBoxRegion((actor.getX() - 4), (actor.getY() - 9), 16, 8);
        _SwitchRegion = getLastCreatedRegion();
propertyChanged("_SwitchRegion", _SwitchRegion);
        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    scripts.Design_165_165_MoveOnActivatedPM._customBlock_ActivateList(_SwitchTargetIDs,_IsActive);
}, actor);
        _StartState = _IsActive;
propertyChanged("_StartState", _StartState);
        actor.say("Timed Region Switch PM", "_customBlock_UpdateSwitchAnimation");
    addActorEntersRegionListener(_SwitchRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(0),a.getType(),a.getGroup())){
        actor.say("Timed Region Switch PM", "_customBlock_EnterSwitch");
}
});
    addActorExitsRegionListener(_SwitchRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(0),a.getType(),a.getGroup())){
        actor.say("Timed Region Switch PM", "_customBlock_ExitSwitch");
}
});
    addActorEntersRegionListener(_SwitchRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(14),a.getType(),a.getGroup())){
        actor.say("Timed Region Switch PM", "_customBlock_EnterSwitch");
}
});
    addActorExitsRegionListener(_SwitchRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(14),a.getType(),a.getGroup())){
        actor.say("Timed Region Switch PM", "_customBlock_ExitSwitch");
}
});
    addActorEntersRegionListener(_SwitchRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(8),a.getType(),a.getGroup())){
        actor.say("Timed Region Switch PM", "_customBlock_EnterSwitch");
}
});
    addActorExitsRegionListener(_SwitchRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(8),a.getType(),a.getGroup())){
        actor.say("Timed Region Switch PM", "_customBlock_ExitSwitch");
}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_IsRunning)
{
            actor.setCurrentFrame(Std.int(Math.floor((_TimeElapsed / _Beatsperframe))));
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}