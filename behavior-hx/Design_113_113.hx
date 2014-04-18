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



class Design_113_113 extends ActorScript
{          	
	
public var _DoorRegion:Region;

public var _Canusedoor:Bool;

public var _HasUsedDoor:Bool;

public var _DoorIsReady:Bool;

public var _Exitonlywhenonground:Bool;

public var _VerticalVelocityCheck:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Door Region", "_DoorRegion");
nameMap.set("Can use door?", "_Canusedoor");
_Canusedoor = false;
nameMap.set("Has Used Door?", "_HasUsedDoor");
_HasUsedDoor = false;
nameMap.set("Door Is Ready?", "_DoorIsReady");
_DoorIsReady = false;
nameMap.set("Exit only when on ground", "_Exitonlywhenonground");
_Exitonlywhenonground = false;
nameMap.set("Vertical Velocity Check", "_VerticalVelocityCheck");
_VerticalVelocityCheck = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            /* "GA: Unlocked Doors (List)" */
        createBoxRegion(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft(actor)), Float), cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop(actor)), Float), (cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorRight(actor)), Float) - cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft(actor)), Float)), (cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorBottom(actor)), Float) - cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop(actor)), Float)));
        _DoorRegion = getLastCreatedRegion();
propertyChanged("_DoorRegion", _DoorRegion);
        /* "GA: Last Scene Name (Text)" */
        actor.say("Activate Door PM", "_customEvent_" + "ActivateDoor");
        actor.say("Activate Door PM", "_customEvent_" + "UnlockDestination");
        actor.disableActorDrawing();
        runLater(1000 * 1, function(timeTask:TimedTask):Void {
                    _DoorIsReady = true;
propertyChanged("_DoorIsReady", _DoorIsReady);
}, actor);
    addActorEntersRegionListener(_DoorRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(0),a.getType(),a.getGroup())){
        if((_Exitonlywhenonground && !(asBoolean(a.getActorValue("On Ground?")))))
{
            return;
}

        if(((_VerticalVelocityCheck < 0) && (actor.getYVelocity() > 0)))
{
            return;
}

        if(((_VerticalVelocityCheck > 0) && (actor.getYVelocity() < 0)))
{
            return;
}

        if(!(_DoorIsReady))
{
            return;
}

        actor.say("Activate Door PM", "_customEvent_" + "UseDoor");
        _DoorIsReady = false;
propertyChanged("_DoorIsReady", _DoorIsReady);
}
});
    addActorExitsRegionListener(_DoorRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(0),a.getType(),a.getGroup())){
        _DoorIsReady = true;
propertyChanged("_DoorIsReady", _DoorIsReady);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}