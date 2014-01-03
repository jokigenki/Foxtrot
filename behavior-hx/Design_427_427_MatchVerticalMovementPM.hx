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



class Design_427_427_MatchVerticalMovementPM extends ActorScript
{          	
	
public var _OldX:Float;

public var _OldY:Float;

public var _Target:Actor;

public var _Offset:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Old X", "_OldX");
_OldX = -2000.0;
nameMap.set("Old Y", "_OldY");
_OldY = -2000.0;
nameMap.set("Target", "_Target");
nameMap.set("Offset", "_Offset");
_Offset = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((hasValue(_Target) != false))
{
            if((_OldY == -2000))
{
                _OldY = asNumber((actor.getY() - _Offset));
propertyChanged("_OldY", _OldY);
}

            actor.setY(((actor.getY() - _Offset) + ((_Target.getY() - _OldY) + _Offset)));
            _OldY = asNumber(_Target.getY());
propertyChanged("_OldY", _OldY);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}