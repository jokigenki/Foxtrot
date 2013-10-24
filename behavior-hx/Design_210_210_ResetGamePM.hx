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
        setGameAttribute("Destination Scene", "none");
        setGameAttribute("Last Scene Name", "none");
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