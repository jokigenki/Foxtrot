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



class Design_133_133 extends ActorScript
{          	
	
public var _ActorType:ActorType;

public var _CanUseItem:Bool;

public var _UseRegion:Region;

public var _ItemIsReady:Bool;

public var _NeedsReset:Bool;

public var _ActorByItem:Actor;

public var _IsEnabled:Bool;

public var _SceneEventName:String;

public var _UserEventName:String;

public var _SelfEventName:String;

public var _CurrentNumberOfUses:Float;

public var _ActivateAfterNumberOfUses:Float;

public var _ActivationAreaWidth:Float;

public var _UpdateEventName:String;

public var _ActivationAreaHeight:Float;
    

/* Params are:__Self __value */
public function _customBlock_SetIsEnabled(__value:Bool):Void
{
var __Self:Actor = actor;
        __Self.setValue("Usable Item PM", "_IsEnabled", __value);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor Type", "_ActorType");
nameMap.set("Actor", "actor");
nameMap.set("Can Use Item?", "_CanUseItem");
_CanUseItem = false;
nameMap.set("Use Region", "_UseRegion");
nameMap.set("Item Is Ready?", "_ItemIsReady");
_ItemIsReady = false;
nameMap.set("Needs Reset?", "_NeedsReset");
_NeedsReset = false;
nameMap.set("Actor By Item", "_ActorByItem");
nameMap.set("Is Enabled?", "_IsEnabled");
_IsEnabled = false;
nameMap.set("Scene Event Name", "_SceneEventName");
_SceneEventName = "";
nameMap.set("User Event Name", "_UserEventName");
_UserEventName = "";
nameMap.set("Self Event Name", "_SelfEventName");
_SelfEventName = "";
nameMap.set("Current Number Of Uses", "_CurrentNumberOfUses");
_CurrentNumberOfUses = 0.0;
nameMap.set("Activate After Number Of Uses", "_ActivateAfterNumberOfUses");
_ActivateAfterNumberOfUses = 1.0;
nameMap.set("Activation Area Width", "_ActivationAreaWidth");
_ActivationAreaWidth = 4.0;
nameMap.set("Update Event Name", "_UpdateEventName");
_UpdateEventName = "";
nameMap.set("Activation Area Height", "_ActivationAreaHeight");
_ActivationAreaHeight = 4.0;

	}
	
	override public function init()
	{
		            createBoxRegion((actor.getXCenter() - (_ActivationAreaWidth / 2)), (actor.getYCenter() - (_ActivationAreaHeight / 2)), _ActivationAreaWidth, _ActivationAreaHeight);
        _CurrentNumberOfUses = asNumber(0);
propertyChanged("_CurrentNumberOfUses", _CurrentNumberOfUses);
        _UseRegion = getLastCreatedRegion();
propertyChanged("_UseRegion", _UseRegion);
        _CanUseItem = false;
propertyChanged("_CanUseItem", _CanUseItem);
        _ItemIsReady = false;
propertyChanged("_ItemIsReady", _ItemIsReady);
        runLater(1000 * 1, function(timeTask:TimedTask):Void {
                    _ItemIsReady = true;
propertyChanged("_ItemIsReady", _ItemIsReady);
}, actor);
    addActorEntersRegionListener(_UseRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(_ActorType,a.getType(),a.getGroup())){
        _CanUseItem = false;
propertyChanged("_CanUseItem", _CanUseItem);
        _CurrentNumberOfUses = asNumber(0);
propertyChanged("_CurrentNumberOfUses", _CurrentNumberOfUses);
        if(_IsEnabled)
{
            /* "Custom: Set Prevent Jump to <true> for <the actor>" */
            a.say("Jumping PM", "_customBlock_SetPreventJump", [true]);
            _NeedsReset = false;
propertyChanged("_NeedsReset", _NeedsReset);
            _CanUseItem = true;
propertyChanged("_CanUseItem", _CanUseItem);
            _ActorByItem = a;
propertyChanged("_ActorByItem", _ActorByItem);
}

}
});
    addActorExitsRegionListener(_UseRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(_ActorType,a.getType(),a.getGroup())){
        /* "Custom: Set Prevent Jump to <false> for <the actor>" */
        a.say("Jumping PM", "_customBlock_SetPreventJump", [false]);
        _CanUseItem = false;
propertyChanged("_CanUseItem", _CanUseItem);
}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((!(_ItemIsReady) || cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorIsNull(_ActorByItem)), Bool)))
{
            return;
}

        /* "Custom: Is \"UseObject\" on for <Actor By Item>" */
        if(cast((_ActorByItem.say("Control Adapter PM", "_customBlock_ControlIsOn", ["UseObject"])), Bool))
{
            if(_CanUseItem)
{
                _CanUseItem = false;
propertyChanged("_CanUseItem", _CanUseItem);
                _CurrentNumberOfUses += 1;
propertyChanged("_CurrentNumberOfUses", _CurrentNumberOfUses);
                if((_CurrentNumberOfUses >= _ActivateAfterNumberOfUses))
{
                    shoutToScene("_customEvent_" + _SceneEventName);
                    actor.shout("_customEvent_" + _SelfEventName);
                    _ActorByItem.shout("_customEvent_" + _UserEventName);
}

                else
{
                    actor.shout("_customEvent_" + _UpdateEventName);
                    _NeedsReset = true;
propertyChanged("_NeedsReset", _NeedsReset);
}

}

}

        else if(_NeedsReset)
{
            _NeedsReset = false;
propertyChanged("_NeedsReset", _NeedsReset);
            _CanUseItem = true;
propertyChanged("_CanUseItem", _CanUseItem);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}