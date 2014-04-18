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



class SceneEvents_42 extends SceneScript
{          	
	
public var _WasInitialised:Bool;

public var _LocalCollected:Array<Dynamic>;

public var _TotalEggs:Float;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Was Initialised?", "_WasInitialised");
_WasInitialised = false;
nameMap.set("Local Collected", "_LocalCollected");
_LocalCollected = [];
nameMap.set("Total Eggs", "_TotalEggs");
_TotalEggs = 0.0;

	}
	
	override public function init()
	{
		            runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    runLater(1000 * getValueForScene("Typewriter Text PM", "_TotalTime"), function(timeTask:TimedTask):Void {
                                if((!(getGameAttribute("Save Destination") == "none") && (("" + getGameAttribute("Save Destination")).indexOf("Tutorial") == -1)))
{
                                    setGameAttribute("Last Destination", "_Home|_Home|A|A");
                                    shoutToScene("_customEvent_" + "SwitchScene");
}

                                else
{
                                    setGameAttribute("Game Was Loaded", true);
                                    setGameAttribute("Collected Items", new Array<Dynamic>());
                                    setGameAttribute("Collected Speed Run Items", new Array<Dynamic>());
                                    setGameAttribute("Inventory New", new Array<Dynamic>());
                                    setGameAttribute("Inventory", new Array<Dynamic>());
                                    setGameAttribute("Speed Run Collectables", new Array<Dynamic>());
                                    setGameAttribute("Unlocked Doors", new Array<Dynamic>());
                                    setGameAttribute("Unlocked Speed Run Doors", new Array<Dynamic>());
                                    setGameAttribute("Gold Keys", 0);
                                    setGameAttribute("Speed Run Timer", 0);
                                    setGameAttribute("Save Destination", "none");
                                    setGameAttribute("Last Destination", "none");
                                    setGameAttribute("In Pants?", true);
                                    saveGame("mySave", function(success:Bool):Void {
                                        setGameAttribute("Last Destination", "Tutorial_01|Tutorial_01|A|A");
                                        shoutToScene("_customEvent_" + "SwitchScene");
});
}

}, null);
}, null);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}