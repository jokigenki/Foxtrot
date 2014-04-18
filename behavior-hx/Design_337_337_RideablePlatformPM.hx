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

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_337_337_RideablePlatformPM extends ActorScript
{          	
	
public var _XOffset:Float;

public var _YOffset:Float;

public var _OldX:Float;

public var _OldY:Float;

public var _ActorFrames:Array<Dynamic>;

public var _ActorsOnPlatform:Array<Dynamic>;

public var _NewActorFrames:Array<Dynamic>;

public var _NewActorsOnPlatform:Array<Dynamic>;

public var _ItemIndex:Float;

public var _Target:Actor;

public var _TargetOffsetX:Float;

public var _TargetOffsetY:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("X Offset", "_XOffset");
_XOffset = 0.0;
nameMap.set("Y Offset", "_YOffset");
_YOffset = 0.0;
nameMap.set("Old X", "_OldX");
_OldX = 0.0;
nameMap.set("Old Y", "_OldY");
_OldY = 0.0;
nameMap.set("Actor Frames", "_ActorFrames");
_ActorFrames = [];
nameMap.set("Actors On Platform", "_ActorsOnPlatform");
_ActorsOnPlatform = [];
nameMap.set("New Actor Frames", "_NewActorFrames");
_NewActorFrames = [];
nameMap.set("New Actors On Platform", "_NewActorsOnPlatform");
_NewActorsOnPlatform = [];
nameMap.set("Item Index", "_ItemIndex");
_ItemIndex = 0.0;
nameMap.set("Target", "_Target");
nameMap.set("Target Offset X", "_TargetOffsetX");
_TargetOffsetX = 0.0;
nameMap.set("Target Offset Y", "_TargetOffsetY");
_TargetOffsetY = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _OldX = asNumber(actor.getX());
propertyChanged("_OldX", _OldX);
        _OldY = asNumber(actor.getY());
propertyChanged("_OldY", _OldY);
        _ActorsOnPlatform = new Array<Dynamic>();
propertyChanged("_ActorsOnPlatform", _ActorsOnPlatform);
        _ActorFrames = new Array<Dynamic>();
propertyChanged("_ActorFrames", _ActorFrames);
        runLater(1000 * 0.05, function(timeTask:TimedTask):Void {
                    createRecycledActor(getActorType(714), actor.getXCenter(), actor.getYCenter(), Script.FRONT);
                    _Target = getLastCreatedActor();
propertyChanged("_Target", _Target);
                    _TargetOffsetX = asNumber((actor.getX() - _Target.getX()));
propertyChanged("_TargetOffsetX", _TargetOffsetX);
                    _TargetOffsetY = asNumber((actor.getY() - _Target.getY()));
propertyChanged("_TargetOffsetY", _TargetOffsetY);
}, actor);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(!((hasValue(_Target) != false)))
{
            return;
}

        _XOffset = asNumber((_Target.getX() - _OldX));
propertyChanged("_XOffset", _XOffset);
        _YOffset = asNumber((_Target.getY() - _OldY));
propertyChanged("_YOffset", _YOffset);
        if(!(actor == _Target))
{
            actor.setX((_Target.getX() + _TargetOffsetX));
            actor.setY((_Target.getY() + _TargetOffsetY));
}

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

        _OldX = asNumber(_Target.getX());
propertyChanged("_OldX", _OldX);
        _OldY = asNumber(_Target.getY());
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