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



class Design_442_442_PlaySoundWhenKilledPM extends ActorScript
{          	
	
public var _SoundName:String;

public var _NSounds:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Sound Name", "_SoundName");
_SoundName = "";
nameMap.set("N Sounds", "_NSounds");
_NSounds = 1.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenKilledListener(actor, function(list:Array<Dynamic>):Void {
if(wrapper.enabled){
        sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_SoundName,_NSounds]);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}