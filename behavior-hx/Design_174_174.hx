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



class Design_174_174 extends ActorScript
{          	
	
public var _IsActive:Bool;

public var _ActiveAnimation:String;

public var _InactiveAnimation:String;

public var _PressedAnimation:String;

public var _PressedInactiveAnimation:String;

public var _SwitchRegion:Region;

public var _SwitchTargetIDs:Array<Dynamic>;
    

/* Params are: */
public function _customBlock_EnterSwitch():Void
{
var __Self:Actor = actor;
        _IsActive = !(_IsActive);
propertyChanged("_IsActive", _IsActive);
        scripts.Design_165_165_MoveOnActivatedPM._customBlock_ActivateList(_SwitchTargetIDs,_IsActive);
        actor.say("Single Use Region Switch PM", "_customBlock_UpdateSwitchAnimation");
        dispatchEvent();
        actor.disableBehavior("Single Use Region Switch PM");
}
    

/* Params are: */
public function _customBlock_UpdateSwitchAnimation():Void
{
var __Self:Actor = actor;
        if(_IsActive)
{
            actor.setAnimation("" + _PressedAnimation);
}

        else
{
            actor.setAnimation("" + _PressedInactiveAnimation);
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
        actor.say("Single Use Region Switch PM", "_customBlock_UpdateSwitchAnimation");
    addActorEntersRegionListener(getLastCreatedRegion(), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(0),a.getType(),a.getGroup())){
        actor.say("Single Use Region Switch PM", "_customBlock_EnterSwitch");
}
});
    addActorEntersRegionListener(_SwitchRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(8),a.getType(),a.getGroup())){
        actor.say("Single Use Region Switch PM", "_customBlock_EnterSwitch");
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}