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



class Design_418_418_MakeDragSoundPM extends ActorScript
{          	
	
public var _IsOnGround:Bool;

public var _IsDragging:Bool;

public var _IsPlayingSound:Bool;

public var _MinimumDragSpeed:Float;

public var _SFXName:String;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Is On Ground?", "_IsOnGround");
_IsOnGround = false;
nameMap.set("Is Dragging?", "_IsDragging");
_IsDragging = false;
nameMap.set("Is Playing Sound?", "_IsPlayingSound");
_IsPlayingSound = false;
nameMap.set("Minimum Drag Speed", "_MinimumDragSpeed");
_MinimumDragSpeed = 1.0;
nameMap.set("SFX Name", "_SFXName");
_SFXName = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _IsDragging = false;
propertyChanged("_IsDragging", _IsDragging);
        if(((actor.getXVelocity() >= _MinimumDragSpeed) || (actor.getXVelocity() <= -(_MinimumDragSpeed))))
{
            _IsDragging = true;
propertyChanged("_IsDragging", _IsDragging);
}

        if((_IsOnGround && _IsDragging))
{
            if(!(_IsPlayingSound))
{
                _IsPlayingSound = true;
propertyChanged("_IsPlayingSound", _IsPlayingSound);
                sayToScene("Sound Manager PM", "_customBlock_LoopSceneSoundForActor", [_SFXName,getCurrentSceneName(),actor]);
}

}

        else
{
            _IsPlayingSound = false;
propertyChanged("_IsPlayingSound", _IsPlayingSound);
            sayToScene("Sound Manager PM", "_customBlock_StopSceneSoundForActor", [_SFXName,getCurrentSceneName(),actor]);
}

        _IsOnGround = false;
propertyChanged("_IsOnGround", _IsOnGround);
}
});
    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(((event.thisCollidedWithTerrain || event.thisCollidedWithTile) && event.thisFromBottom))
{
            _IsOnGround = true;
propertyChanged("_IsOnGround", _IsOnGround);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}