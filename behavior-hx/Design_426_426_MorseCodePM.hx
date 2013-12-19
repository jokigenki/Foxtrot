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



class Design_426_426_MorseCodePM extends SceneScript
{          	
	
public var _MorseList:Array<Dynamic>;
    

/* Params are:__Characters */
public function _customBlock_PlayMorseCode(__Characters:String):Void
{
        __Characters = __Characters.toLowerCase();
for (i in 0...__Characters.length)
{
	var charCode = __Characters.charCodeAt(i);
	if (charCode < 97 || charCode > 123) continue;
	var sequence = _MorseList[charCode - 97];
	for (j in 0...sequence.length)
	{
		var time = j * 100;
		var code = sequence.charAt(j);
		var sfx = code == "." ? "Dot SFX" : "Dash SFX";
		if (time > 0)
		{
			runLater(time, function(timeTask:TimedTask):Void {
            		sayToScene("Sound Manager PM", "_customBlock_PlayNamedSound", [sfx]);
            		}, null);
		} else {
			sayToScene("Sound Manager PM", "_customBlock_PlayNamedSound", [sfx]);
		}
	}
}
}

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Morse List", "_MorseList");
_MorseList = [];

	}
	
	override public function init()
	{
		            _MorseList = [
".-", "-...", "-.-.", "-..", ".", "..-.", "--.",
"....", "..", ".---", "-.-", ".-..", "--", "-.",
"---", ".--.", "--.-", ".-.", "...", "-", "..-",
"...-", ".--,", "-..-", "-.--", "--.."];

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}