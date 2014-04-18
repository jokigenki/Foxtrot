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



class SceneEvents_13 extends SceneScript
{          	
	
 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		
	}
	
	override public function init()
	{
		            if((!(getGameAttribute("Speed Run In Progress")) || cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected("Egg1_10")), Bool)))
{
            recycleActor(getActor(60));
            recycleActor(getActor(61));
            recycleActor(getActor(62));
            recycleActor(getActor(63));
            recycleActor(getActor(64));
            recycleActor(getActor(57));
            recycleActor(getActor(58));
            recycleActor(getActor(59));
}

        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    sayToScene("Sound Manager PM", "_customBlock_LoopSceneSound", ["Lift Loop SFX",getCurrentSceneName()]);
}, null);
        runLater(1000 * 0.2, function(timeTask:TimedTask):Void {
                    sayToScene("Sound Manager PM", "_customBlock_LoopSceneSound", ["Lift Loop SFX",getCurrentSceneName()]);
}, null);
    addWhenKilledListener(getActor(12), function(list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(getGameAttribute("Speed Run In Progress"))
{
            recycleActor(getActor(60));
            recycleActor(getActor(61));
            recycleActor(getActor(62));
            recycleActor(getActor(63));
            recycleActor(getActor(64));
            recycleActor(getActor(57));
            recycleActor(getActor(58));
            recycleActor(getActor(59));
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}