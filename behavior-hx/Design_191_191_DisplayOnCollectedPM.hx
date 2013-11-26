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



class Design_191_191_DisplayOnCollectedPM extends ActorScript
{          	
	
public var _CollectionDisplayType:ActorType;

public var _IsCollected:Bool;

public var _GrowPercent:Float;

public var _GrowTime:Float;

public var _FadeTime:Float;

public var _SFX:Sound;
    

/* Params are:__Self */
public function _customBlock_DisplayOnCollect():Void
{
var __Self:Actor = actor;
        createRecycledActor(getActorType(787), (((getScreenWidth() / 2) + getScreenX()) - 32), (((getScreenHeight() / 2) + getScreenY()) - 32), Script.FRONT);
        createRecycledActor(_CollectionDisplayType, getLastCreatedActor().getXCenter(), getLastCreatedActor().getYCenter(), Script.FRONT);
        getLastCreatedActor().setX((getLastCreatedActor().getX() - (getLastCreatedActor().getWidth() / 2)));
        getLastCreatedActor().setY((getLastCreatedActor().getY() - (getLastCreatedActor().getHeight() / 2)));
        getLastCreatedActor().setActorValue("Collection Display", true);
        getLastCreatedActor().setActorValue("Collection Animation", ("" + actor.getAnimation()));
        sayToScene("Sound Manager PM", "_customBlock_PlaySound", [_SFX]);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Collection Display Type", "_CollectionDisplayType");
nameMap.set("Is Collected?", "_IsCollected");
_IsCollected = false;
nameMap.set("Grow Percent", "_GrowPercent");
_GrowPercent = 0.0;
nameMap.set("Grow Time", "_GrowTime");
_GrowTime = 0.0;
nameMap.set("Fade Time", "_FadeTime");
_FadeTime = 0.0;
nameMap.set("SFX", "_SFX");
_SFX = getSound(799);
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if(!((hasValue(_CollectionDisplayType) != false)))
{
            _CollectionDisplayType = actor.getType();
            propertyChanged("_CollectionDisplayType", _CollectionDisplayType);
}

        actor.disableActorDrawing();
        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    if(actor.getActorValue("Collection Display"))
{
                        actor.setAnimation("" + ("" + (("" + actor.getActorValue("Collection Animation")) + ("" + " Collected"))));
                        runLater(1000 * 0.6, function(timeTask:TimedTask):Void {
                                    actor.enableActorDrawing();
                                    actor.growTo(_GrowPercent/100, _GrowPercent/100, (_GrowTime / 2), Quad.easeInOut);
                                    runLater(1000 * (_GrowTime / 2), function(timeTask:TimedTask):Void {
                                                actor.growTo(100/100, 100/100, _GrowTime, Quad.easeInOut);
                                                actor.fadeTo(0, _FadeTime, Quad.easeOut);
                                                runLater(1000 * _FadeTime, function(timeTask:TimedTask):Void {
                                                            recycleActor(actor);
}, actor);
}, actor);
}, actor);
}

                    else
{
                        if((actor.hasBehavior("Inventory Collectable PM") && cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected(actor.getValue("Inventory Collectable PM", "_CollectableId"))), Bool)))
{
                            recycleActor(actor);
}

                        if((actor.hasBehavior("Collectable Trigger PM") && cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected(actor.getValue("Collectable Trigger PM", "_CollectableId"))), Bool)))
{
                            recycleActor(actor);
}

                        actor.enableActorDrawing();
}

}, actor);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}