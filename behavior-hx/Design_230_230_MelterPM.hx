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



class Design_230_230_MelterPM extends ActorScript
{          	
	
public var _MeltRegion:Region;

public var _ItemsMelted:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Melt Region", "_MeltRegion");
nameMap.set("Items Melted", "_ItemsMelted");
_ItemsMelted = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _ItemsMelted = asNumber(0);
propertyChanged("_ItemsMelted", _ItemsMelted);
    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(event.otherActor.hasBehavior("Meltable PM"))
{
            if((Math.round(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorBottom(event.thisActor)), Float)) == Math.round(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorBottom(event.otherActor)), Float))))
{
                event.otherActor.setValue("Meltable PM", "_MeltX", actor.getX());
                event.otherActor.setValue("Meltable PM", "_MeltY", ((event.thisActor.getY() + 0) - (_ItemsMelted * 4)));
                event.otherActor.say("Meltable PM", "_customEvent_" + "Melt");
                _ItemsMelted += 1;
propertyChanged("_ItemsMelted", _ItemsMelted);
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}