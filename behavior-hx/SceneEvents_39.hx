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



class SceneEvents_39 extends SceneScript
{          	
	
public var _ExitName:String;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";

	}
	
	override public function init()
	{
		            runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    if(!(getGameAttribute("In Pants?")))
{
                        createRecycledActor(getActorType(9), getActor(8).getX(), getActor(8).getY(), Script.FRONT);
                        getLastCreatedActor().setActorValue("Facing Right?", getActor(8).getActorValue("Facing Right?"));
                        recycleActor(getActor(8));
                        sayToScene("Split Screen Button PM", "_customBlock_SetActorToControl", [getLastCreatedActor()]);
                        getActor(6).setValue("Activate Door PM", "_ActorToMove", getLastCreatedActor());
                        getActor(7).setValue("Activate Door PM", "_ActorToMove", getLastCreatedActor());
}

                    if((getGameAttribute("ControlMode") == "Button"))
{
                        getActor(9).setAnimation("" + ("" + "buttons"));
}

                    else if((getGameAttribute("ControlMode") == "Split"))
{
                        getActor(9).setAnimation("" + ("" + "split"));
}

}, null);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}