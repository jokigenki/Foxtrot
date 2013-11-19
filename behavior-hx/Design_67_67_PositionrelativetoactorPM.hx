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



class Design_67_67_PositionrelativetoactorPM extends ActorScript
{          	
	
public var _XOffset:Float;

public var _YOffset:Float;

public var _TargetActor:Actor;

public var _OffsetWhenFacingLeft:Float;

public var _OffsetWhenFacingRight:Float;

public var _WasFacingRight:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("X Offset", "_XOffset");
_XOffset = 0.0;
nameMap.set("Y Offset", "_YOffset");
_YOffset = 0.0;
nameMap.set("Target Actor", "_TargetActor");
nameMap.set("Offset When Facing Left", "_OffsetWhenFacingLeft");
_OffsetWhenFacingLeft = 0.0;
nameMap.set("Offset When Facing Right", "_OffsetWhenFacingRight");
_OffsetWhenFacingRight = 0.0;
nameMap.set("Was Facing Right?", "_WasFacingRight");
_WasFacingRight = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _XOffset = asNumber((actor.getX() - _TargetActor.getX()));
propertyChanged("_XOffset", _XOffset);
        _YOffset = asNumber((actor.getY() - _TargetActor.getY()));
propertyChanged("_YOffset", _YOffset);
        if(_TargetActor.getActorValue("Facing Right?"))
{
            _WasFacingRight = true;
propertyChanged("_WasFacingRight", _WasFacingRight);
            _XOffset += _OffsetWhenFacingRight;
propertyChanged("_XOffset", _XOffset);
}

        else
{
            _XOffset += _OffsetWhenFacingLeft;
propertyChanged("_XOffset", _XOffset);
}

    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_TargetActor.getActorValue("Facing Right?"))
{
            if(!(_WasFacingRight))
{
                _XOffset -= _OffsetWhenFacingLeft;
propertyChanged("_XOffset", _XOffset);
                _XOffset += _OffsetWhenFacingRight;
propertyChanged("_XOffset", _XOffset);
                _WasFacingRight = true;
propertyChanged("_WasFacingRight", _WasFacingRight);
}

}

        else
{
            if(_WasFacingRight)
{
                _XOffset -= _OffsetWhenFacingRight;
propertyChanged("_XOffset", _XOffset);
                _XOffset += _OffsetWhenFacingLeft;
propertyChanged("_XOffset", _XOffset);
                _WasFacingRight = false;
propertyChanged("_WasFacingRight", _WasFacingRight);
}

}

        actor.setX((_TargetActor.getX() + _XOffset));
        actor.setY((_TargetActor.getY() + _YOffset));
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}