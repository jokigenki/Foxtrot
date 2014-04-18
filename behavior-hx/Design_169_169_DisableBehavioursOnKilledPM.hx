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



class Design_169_169_DisableBehavioursOnKilledPM extends ActorScript
{          	
	
public var _BehavioursToDisable:Array<Dynamic>;

public var _IsKilled:Bool;
    public function _customEvent_Killed():Void
{
        for(item in cast(_BehavioursToDisable, Array<Dynamic>))
{
            if(actor.hasBehavior(item))
{
                actor.disableBehavior(item);
}

}

        actor.setXVelocity(0);
        actor.setYVelocity(0);
}

    

/* Params are:__Self */
public function _customBlock_RunDisableOnKilled():Void
{
var __Self:Actor = actor;
        if(actor.hasBehavior("Disable Behaviours On Killed PM"))
{
            actor.say("Disable Behaviours On Killed PM", "_customEvent_" + "Killed");
}

        actor.setXVelocity(0);
        actor.setYVelocity(0);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Behaviours To Disable", "_BehavioursToDisable");
_BehavioursToDisable = [];
nameMap.set("Is Killed?", "_IsKilled");
_IsKilled = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}