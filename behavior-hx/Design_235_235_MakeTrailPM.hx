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



class Design_235_235_MakeTrailPM extends ActorScript
{          	
	
public var _LastX:Float;

public var _TrailActorWidth:Float;

public var _TrailActorType:ActorType;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Last X", "_LastX");
_LastX = 0.0;
nameMap.set("Trail Actor Width", "_TrailActorWidth");
_TrailActorWidth = 0.0;
nameMap.set("Trail Actor Type", "_TrailActorType");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _LastX = asNumber(actor.getX());
propertyChanged("_LastX", _LastX);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        while((actor.getX() > _LastX))
{
            createRecycledActor(_TrailActorType, _LastX, actor.getY(), Script.FRONT);
            getLastCreatedActor().moveToLayer(actor.getLayerID());
            getLastCreatedActor().sendBackward();
            _LastX += _TrailActorWidth;
propertyChanged("_LastX", _LastX);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}