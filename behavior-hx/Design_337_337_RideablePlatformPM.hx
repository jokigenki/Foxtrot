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



class Design_337_337_RideablePlatformPM extends ActorScript
{          	
	
public var _XOffset:Float;

public var _YOffset:Float;

public var _OldX:Float;

public var _OldY:Float;

public var _TargetX:Float;

public var _TargetY:Float;

public var _ActorFrames:Array<Dynamic>;

public var _ActorsOnPlatform:Array<Dynamic>;

public var _NewActorFrames:Array<Dynamic>;

public var _NewActorsOnPlatform:Array<Dynamic>;

public var _ItemIndex:Float;
    

/* Params are:__Self __X __Y */
public function _customBlock_MovePlatform(__X:Float, __Y:Float):Void
{
var __Self:Actor = actor;
        _TargetX = asNumber(__X);
propertyChanged("_TargetX", _TargetX);
        _TargetY = asNumber(__Y);
propertyChanged("_TargetY", _TargetY);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("X Offset", "_XOffset");
_XOffset = 0;
nameMap.set("Y Offset", "_YOffset");
_YOffset = 0;
nameMap.set("Old X", "_OldX");
_OldX = 0;
nameMap.set("Old Y", "_OldY");
_OldY = 0;
nameMap.set("Target X", "_TargetX");
_TargetX = 0;
nameMap.set("Target Y", "_TargetY");
_TargetY = 0;
nameMap.set("Actor Frames", "_ActorFrames");
nameMap.set("Actors On Platform", "_ActorsOnPlatform");
nameMap.set("New Actor Frames", "_NewActorFrames");
nameMap.set("New Actors On Platform", "_NewActorsOnPlatform");
nameMap.set("Item Index", "_ItemIndex");
_ItemIndex = 0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _OldX = asNumber(actor.getX());
propertyChanged("_OldX", _OldX);
        _OldY = asNumber(actor.getY());
propertyChanged("_OldY", _OldY);
        _ActorFrames = new Array<Dynamic>();
propertyChanged("_ActorFrames", _ActorFrames);
        _ActorsOnPlatform = new Array<Dynamic>();
propertyChanged("_ActorsOnPlatform", _ActorsOnPlatform);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _XOffset = asNumber((_TargetX - _OldX));
propertyChanged("_XOffset", _XOffset);
        _YOffset = asNumber((_TargetY - _OldY));
propertyChanged("_YOffset", _YOffset);
        actor.setX(_TargetX);
        actor.setY(_TargetY);
        if(!((_ActorsOnPlatform.length == 0)))
{
            _NewActorFrames = new Array<Dynamic>();
propertyChanged("_NewActorFrames", _NewActorFrames);
            _NewActorsOnPlatform = new Array<Dynamic>();
propertyChanged("_NewActorsOnPlatform", _NewActorsOnPlatform);
            _ItemIndex = asNumber(0);
propertyChanged("_ItemIndex", _ItemIndex);
            for(item in cast(_ActorFrames, Array<Dynamic>))
{
                if(((item + 1) < 5))
{
                    _NewActorsOnPlatform.push(_ActorsOnPlatform[Std.int(_ItemIndex)]);
                    _NewActorFrames.push((item + 1));
}

                _ItemIndex += 1;
propertyChanged("_ItemIndex", _ItemIndex);
}

            _ActorFrames = _NewActorFrames;
propertyChanged("_ActorFrames", _ActorFrames);
            _ActorsOnPlatform = _NewActorsOnPlatform;
propertyChanged("_ActorsOnPlatform", _ActorsOnPlatform);
            for(item in cast(_ActorsOnPlatform, Array<Dynamic>))
{
                item.setX((item.getX() + _XOffset));
                item.setY((item.getY() + _YOffset));
}

}

        _OldX = asNumber(actor.getX());
propertyChanged("_OldX", _OldX);
        _OldY = asNumber(actor.getY());
propertyChanged("_OldY", _OldY);
}
});
    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(event.otherActor.hasBehavior("Platform Rider PM"))
{
            if(event.otherActor.getActorValue("Can Ride Platform?"))
{
                _ItemIndex = asNumber(Utils.indexOf(_ActorsOnPlatform, event.otherActor));
propertyChanged("_ItemIndex", _ItemIndex);
                if(Utils.contains(_ActorsOnPlatform, event.otherActor))
{
                    _ActorFrames[Std.int(_ItemIndex)] = 0;
}

                else
{
                    _ActorsOnPlatform.push(event.otherActor);
                    _ActorFrames.push(0);
}

}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}