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



class Design_205_205_SpeedRunCollectablePM extends ActorScript
{          	
	
public var _SpeedRunTime:Float;

public var _SpeedRunCollectables:Array<Dynamic>;

public var _CompletionEggName:String;

public var _StartDoorId:String;

public var _StartScene:String;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Speed Run Time", "_SpeedRunTime");
_SpeedRunTime = 0.0;
nameMap.set("Speed Run Collectables", "_SpeedRunCollectables");
_SpeedRunCollectables = [];
nameMap.set("Completion Egg Name", "_CompletionEggName");
_CompletionEggName = "";
nameMap.set("Start Door Id", "_StartDoorId");
_StartDoorId = "";
nameMap.set("Start Scene", "_StartScene");
_StartScene = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if(getGameAttribute("Speed Run In Progress"))
{
            recycleActor(actor);
}

    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled && sameAsAny(getActorType(9), event.otherActor.getType(),event.otherActor.getGroup())){
        recycleActor(actor);
        setGameAttribute("Speed Run Success Time", _SpeedRunTime);
        setGameAttribute("Speed Run Collectables", _SpeedRunCollectables);
        setGameAttribute("Speed Run Egg Name", _CompletionEggName);
        setGameAttribute("Speed Run Start", _StartScene);
        sayToScene("Speed Run Timer PM", "_customEvent_" + "TimerReset");
        setGameAttribute("Speed Run In Progress", true);
        reloadCurrentScene(createFadeOut((0.5)),createFadeIn((0.5)));
        scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_UnlockExit(_StartDoorId);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}