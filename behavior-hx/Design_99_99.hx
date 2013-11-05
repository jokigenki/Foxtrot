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



class Design_99_99 extends ActorScript
{          	
	
public var _DoorRegion:Region;

public var _Canusedoor:Bool;

public var _HasUsedDoor:Bool;

public var _DoorReady:Bool;

public var _HideSprite:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Door Region", "_DoorRegion");
nameMap.set("Can use door?", "_Canusedoor");
_Canusedoor = false;
nameMap.set("Has Used Door?", "_HasUsedDoor");
_HasUsedDoor = false;
nameMap.set("Door Ready?", "_DoorReady");
_DoorReady = false;
nameMap.set("Hide Sprite", "_HideSprite");
_HideSprite = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if(_HideSprite)
{
            actor.disableActorDrawing();
}

        _DoorReady = false;
propertyChanged("_DoorReady", _DoorReady);
        /* "GA: Unlocked Doors (List)" */
        createBoxRegion((actor.getXCenter() - 2), cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop(actor)), Float), 4, (cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorBottom(actor)), Float) - cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop(actor)), Float)));
        _DoorRegion = getLastCreatedRegion();
propertyChanged("_DoorRegion", _DoorRegion);
        _Canusedoor = false;
propertyChanged("_Canusedoor", _Canusedoor);
        _HasUsedDoor = false;
propertyChanged("_HasUsedDoor", _HasUsedDoor);
        /* "GA: Last Scene Name (Text)" */
        actor.say("Activate Door PM", "_customEvent_" + "UnlockDestination");
        runLater(1000 * 0.5, function(timeTask:TimedTask):Void {
                    _DoorReady = true;
propertyChanged("_DoorReady", _DoorReady);
}, actor);
    addActorEntersRegionListener(_DoorRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(9),a.getType(),a.getGroup())){
        if((!(_DoorReady) || isTransitioning()))
{
            return;
}

        _Canusedoor = true;
propertyChanged("_Canusedoor", _Canusedoor);
        if(_HasUsedDoor)
{
            _Canusedoor = false;
propertyChanged("_Canusedoor", _Canusedoor);
}

        /* "Custom: Is \"UseObject\" on for <Actor by door>" */
        if(_Canusedoor)
{
            _HasUsedDoor = true;
propertyChanged("_HasUsedDoor", _HasUsedDoor);
            _Canusedoor = false;
propertyChanged("_Canusedoor", _Canusedoor);
            /* "Now move to the linked scene" */
            actor.say("Activate Door PM", "_customEvent_" + "UseDoor");
}

}
});
    addActorExitsRegionListener(_DoorRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(9),a.getType(),a.getGroup())){
        _Canusedoor = false;
propertyChanged("_Canusedoor", _Canusedoor);
        _DoorReady = true;
propertyChanged("_DoorReady", _DoorReady);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}