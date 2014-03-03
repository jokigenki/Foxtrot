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



class Design_210_210_ResetGamePM extends ActorScript
{          	
	    

/* Params are: */
public function _customBlock_ResetGame():Void
{
var __Self:Actor = actor;
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
        setGameAttribute("Save Destination", "_Home|_Home");
        setGameAttribute("Last Destination", "_Home|_Home");
        setGameAttribute("Game Complete", false);
        scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_UnlockExit("_Home|Tutorial_05|A|B");
        scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_CollectItemWithType("Tutorial_05Key",getActorType(142));
        saveGame("mySave", function(success:Bool):Void {
            reloadCurrentScene(createFadeOut((0.5)),createFadeIn((0.5)));
});
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}