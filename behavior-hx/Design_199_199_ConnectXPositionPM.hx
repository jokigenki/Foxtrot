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



class Design_199_199_ConnectXPositionPM extends ActorScript
{          	
	
public var _Target:Actor;

public var _TargetXOffset:Float;

public var _TargetYOffset:Float;
    

/* Params are:__Self __Target */
public function _customBlock_AssignFollowTarget(__Target:Actor):Void
{
var __Self:Actor = actor;
        var xOff = __Self.getX() - __Target.getX();
var yOff = __Self.getY() - __Target.getY();
__Self.setValue("Make Target Follow PM", "_Target", __Target);
__Self.setValue("Make Target Follow PM", "_TargetXOffset", xOff);
__Self.setValue("Make Target Follow PM", "_TargetYOffset", yOff);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Target", "_Target");
nameMap.set("Target X Offset", "_TargetXOffset");
_TargetXOffset = 0.0;
nameMap.set("Target Y Offset", "_TargetYOffset");
_TargetYOffset = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if(!(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorIsNull(actor)), Bool)))
{
            _TargetXOffset = asNumber((_Target.getX() - actor.getX()));
propertyChanged("_TargetXOffset", _TargetXOffset);
            _TargetYOffset = asNumber((_Target.getY() - actor.getY()));
propertyChanged("_TargetYOffset", _TargetYOffset);
}

    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _Target.setX((actor.getX() + _TargetXOffset));
        _Target.setY((actor.getY() + _TargetYOffset));
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}