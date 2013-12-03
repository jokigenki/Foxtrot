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

public var _SFX:Sound;

public var _ChannelNumber:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Is On Ground?", "_IsOnGround");
_IsOnGround = false;
nameMap.set("Is Dragging?", "_IsDragging");
_IsDragging = false;
nameMap.set("Is Playing Sound?", "_IsPlayingSound");
_IsPlayingSound = false;
nameMap.set("SFX", "_SFX");
nameMap.set("Channel Number", "_ChannelNumber");
_ChannelNumber = 2;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _IsDragging = false;
propertyChanged("_IsDragging", _IsDragging);
        if(!(actor.getXVelocity() == 0))
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
                sayToScene("Sound Manager PM", "_customBlock_LoopSoundOnChannel", [_SFX,_ChannelNumber]);
}

}

        else
{
            _IsPlayingSound = false;
propertyChanged("_IsPlayingSound", _IsPlayingSound);
            stopSoundOnChannel(Std.int(_ChannelNumber));
}

        _IsOnGround = false;
propertyChanged("_IsOnGround", _IsOnGround);
}
});
    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(event.thisFromBottom)
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