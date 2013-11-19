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



class Design_66_66_ToggleRegionSwitchPM extends ActorScript
{          	
	
public var _IsActive:Bool;

public var _ActiveAnimation:String;

public var _InactiveAnimation:String;

public var _PressedAnimation:String;

public var _PressedInactiveAnimation:String;

public var _SwitchRegion:Region;

public var _SwitchTargetIDs:Array<Dynamic>;

public var _IsPressed:Bool;
    

/* Params are: */
public function _customBlock_EnterSwitch():Void
{
var __Self:Actor = actor;
        _IsPressed = true;
propertyChanged("_IsPressed", _IsPressed);
        _IsActive = !(_IsActive);
propertyChanged("_IsActive", _IsActive);
        scripts.Design_165_165_MoveOnActivatedPM._customBlock_ActivateList(_SwitchTargetIDs,_IsActive);
        dispatchEvent();
        actor.say("Toggle Region Switch PM", "_customBlock_UpdateSwitchAnimation");
}
    

/* Params are: */
public function _customBlock_ExitSwitch():Void
{
var __Self:Actor = actor;
        _IsPressed = false;
propertyChanged("_IsPressed", _IsPressed);
        dispatchEvent();
        actor.say("Toggle Region Switch PM", "_customBlock_UpdateSwitchAnimation");
}
    

/* Params are: */
public function _customBlock_UpdateSwitchAnimation():Void
{
var __Self:Actor = actor;
        if(_IsPressed)
{
            if(_IsActive)
{
                actor.setAnimation("" + _PressedAnimation);
}

            else
{
                actor.setAnimation("" + _PressedInactiveAnimation);
}

}

        else
{
            if(_IsActive)
{
                actor.setAnimation("" + _ActiveAnimation);
}

            else
{
                actor.setAnimation("" + _InactiveAnimation);
}

}

}
            public function dispatchEvent () 
{
	var actorname = scripts.Design_27_27_ActorExtrasPM._customBlock_SceneNameForActor(actor);
	actorname = actorname.split(" ").join("");
	shoutToScene("_customEvent_" + actorname + "Switched" + (_IsActive ? "On" : "Off"));
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Active Animation", "_ActiveAnimation");
nameMap.set("Inactive Animation", "_InactiveAnimation");
nameMap.set("Pressed Animation", "_PressedAnimation");
nameMap.set("Pressed Inactive Animation", "_PressedInactiveAnimation");
nameMap.set("Switch Region", "_SwitchRegion");
nameMap.set("Switch Target IDs", "_SwitchTargetIDs");
_SwitchTargetIDs = [];
nameMap.set("Is Pressed?", "_IsPressed");
_IsPressed = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            createBoxRegion((actor.getX() - 4), (actor.getY() - 9), 16, 8);
        _SwitchRegion = getLastCreatedRegion();
propertyChanged("_SwitchRegion", _SwitchRegion);
        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    scripts.Design_165_165_MoveOnActivatedPM._customBlock_ActivateList(_SwitchTargetIDs,_IsActive);
}, actor);
        _IsPressed = false;
propertyChanged("_IsPressed", _IsPressed);
        actor.say("Toggle Region Switch PM", "_customBlock_UpdateSwitchAnimation");
    addActorEntersRegionListener(_SwitchRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(0),a.getType(),a.getGroup())){
        actor.say("Toggle Region Switch PM", "_customBlock_EnterSwitch");
}
});
    addActorExitsRegionListener(_SwitchRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(0),a.getType(),a.getGroup())){
        actor.say("Toggle Region Switch PM", "_customBlock_ExitSwitch");
}
});
    addActorEntersRegionListener(_SwitchRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(14),a.getType(),a.getGroup())){
        actor.say("Toggle Region Switch PM", "_customBlock_EnterSwitch");
}
});
    addActorExitsRegionListener(_SwitchRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(14),a.getType(),a.getGroup())){
        actor.say("Toggle Region Switch PM", "_customBlock_ExitSwitch");
}
});
    addActorEntersRegionListener(_SwitchRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(8),a.getType(),a.getGroup())){
        actor.say("Toggle Region Switch PM", "_customBlock_EnterSwitch");
}
});
    addActorEntersRegionListener(_SwitchRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(8),a.getType(),a.getGroup())){
        actor.say("Toggle Region Switch PM", "_customBlock_ExitSwitch");
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}