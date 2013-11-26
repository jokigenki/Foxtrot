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



class Design_411_411_CollectionDisplayPM extends ActorScript
{          	
	
public var _GrowPercent:Float;

public var _GrowTime:Float;

public var _FadeTime:Float;

public var _IsCollected:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Grow Percent", "_GrowPercent");
_GrowPercent = 0.0;
nameMap.set("Grow Time", "_GrowTime");
_GrowTime = 0.0;
nameMap.set("Fade Time", "_FadeTime");
_FadeTime = 0.0;
nameMap.set("Is Collected?", "_IsCollected");
_IsCollected = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            actor.disableActorDrawing();
        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    trace("" + actor.getValue("Collectable Trigger PM", "_CollectableId"));
                    if((actor.hasBehavior("Collectable Trigger PM") && cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected(actor.getValue("Collectable Trigger PM", "_CollectableId"))), Bool)))
{
                        _IsCollected = true;
propertyChanged("_IsCollected", _IsCollected);
}

                    else if((actor.hasBehavior("Inventory Collectable PM") && cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected(actor.getValue("Inventory Collectable PM", "_CollectableId"))), Bool)))
{
                        _IsCollected = true;
propertyChanged("_IsCollected", _IsCollected);
}

                    if(_IsCollected)
{
                        actor.setAnimation("" + ("" + (("" + ("" + actor.getAnimation())) + ("" + " Collected"))));
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
                        actor.enableActorDrawing();
}

}, actor);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}