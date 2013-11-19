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



class Design_71_71_CentreXbetweenActorsPM extends ActorScript
{          	
	
public var _LeftActor:Actor;

public var _RightActor:Actor;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Left Actor", "_LeftActor");
nameMap.set("Right Actor", "_RightActor");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            actor.anchorToScreen();
        /* "Custom: Get right for <Left Actor>, Get left for <Right Actor>, Get right for ><Left Actor>" */
        actor.setX((cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorRight(_LeftActor)), Float) + ((cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft(_RightActor)), Float) - cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorRight(_LeftActor)), Float)) / 2)));

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}