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



class ActorEvents_990 extends ActorScript
{          	
	
 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		
	}
	
	override public function init()
	{
		            trace("" + (("" + "MUSIC ON: -------------------------------") + ("" + ("" + getGameAttribute("Is Music On?")))));
        if(getGameAttribute("Is Music On?"))
{
            actor.setAnimation("" + ("" + "music"));
}

        else
{
            actor.setAnimation("" + ("" + "sfx"));
}

    addMouseOverActorListener(actor, function(mouseState:Int, list:Array<Dynamic>):Void {
if(wrapper.enabled && 5 == mouseState){
        if(getGameAttribute("Is Music On?"))
{
            trace("" + "MUSIC OFF");
            actor.setAnimation("" + ("" + "sfx"));
            sayToScene("Sound Manager PM", "_customBlock_StopCurrentMusic");
}

        else
{
            trace("" + "MUSIC ON");
            actor.setAnimation("" + ("" + "music"));
            sayToScene("Sound Manager PM", "_customBlock_LoopMusic", [getSound(851)]);
}

        saveGame("mySave", function(success:Bool):Void {

});
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}