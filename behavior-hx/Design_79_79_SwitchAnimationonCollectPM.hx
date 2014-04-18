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



class Design_79_79_SwitchAnimationonCollectPM extends ActorScript
{          	
	
public var _NewWalkLeftAnimation:String;

public var _NewWalkRightAnimation:String;

public var _NewJumpLeftAnimation:String;

public var _NewJumpRightAnimation:String;

public var _AnimationSwitchList:Array<Dynamic>;

public var _CollectableActorType:ActorType;
    

/* Params are:__Self __Data */
public function _customBlock_SwitchAnimation(__Data:String):Void
{
var __Self:Actor = actor;
        var dataArray = __Data.split("|");
var behaviourName = dataArray[0];
var attributeName = dataArray[1];
var animationName = dataArray[2];
        __Self.setValue(behaviourName, attributeName, animationName);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("New Walk Left Animation", "_NewWalkLeftAnimation");
nameMap.set("New Walk Right Animation", "_NewWalkRightAnimation");
nameMap.set("New Jump Left Animation", "_NewJumpLeftAnimation");
nameMap.set("New Jump Right Animation", "_NewJumpRightAnimation");
nameMap.set("Animation Switch List", "_AnimationSwitchList");
_AnimationSwitchList = [];
nameMap.set("Collectable Actor Type", "_CollectableActorType");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled && sameAsAny(_CollectableActorType, event.otherActor.getType(),event.otherActor.getGroup())){
        for(item in cast(_AnimationSwitchList, Array<Dynamic>))
{
            /* "Switch to <item> for Self" */
            actor.say("Switch Animation on Collect PM", "_customBlock_SwitchAnimation", [item]);
}

        recycleActor(event.otherActor);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}