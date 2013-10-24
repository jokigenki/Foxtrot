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



class Design_187_187_DropItemWhenKilledPM extends ActorScript
{          	
	
public var _ActorTypeToCreate:ActorType;

public var _XDirection:Float;

public var _YDirection:Float;

public var _Force:Float;

public var _CreationAttributes:Array<Dynamic>;

public var _CollectableId:String;

public var _CollectionEventName:String;

public var _SwitchtoAnimationNamed:String;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor Type To Create", "_ActorTypeToCreate");
nameMap.set("X Direction", "_XDirection");
_XDirection = 0.0;
nameMap.set("Y Direction", "_YDirection");
_YDirection = 0.0;
nameMap.set("Force", "_Force");
_Force = 0.0;
nameMap.set("Creation Attributes", "_CreationAttributes");
_CreationAttributes = [];
nameMap.set("Collectable Id", "_CollectableId");
_CollectableId = "";
nameMap.set("Collection Event Name", "_CollectionEventName");
_CollectionEventName = "";
nameMap.set("Switch to Animation Named", "_SwitchtoAnimationNamed");
_SwitchtoAnimationNamed = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenKilledListener(actor, function(list:Array<Dynamic>):Void {
if(wrapper.enabled){
        trace("" + "DROP!");
        /* "GA: Collected Items" */
        if(cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected(_CollectableId)), Bool))
{
            return;
}

        trace("" + (("" + "Creating: ") + ("" + _CollectableId)));
        createRecycledActor(_ActorTypeToCreate, actor.getXCenter(), actor.getYCenter(), Script.MIDDLE);
        if(!(_Force == 0))
{
            getLastCreatedActor().push(_XDirection, _YDirection, _Force);
}

        scripts.Design_27_27_ActorExtrasPM._customBlock_SetActorValues(_CreationAttributes,getLastCreatedActor());
        if(getLastCreatedActor().hasBehavior("Inventory Collectable PM"))
{
            getLastCreatedActor().setValue("Inventory Collectable PM", "_CollectableId", _CollectableId);
            getLastCreatedActor().setValue("Inventory Collectable PM", "_Collectioneventname", _CollectionEventName);
}

        if(((hasValue(_SwitchtoAnimationNamed) != false) && !(("" + _SwitchtoAnimationNamed) == (""))))
{
            getLastCreatedActor().setAnimation("" + ("" + _SwitchtoAnimationNamed));
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}