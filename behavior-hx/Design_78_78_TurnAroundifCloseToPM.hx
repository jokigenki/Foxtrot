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



class Design_78_78_TurnAroundifCloseToPM extends ActorScript
{          	
	
public var _DangerActorType:ActorType;

public var _XDistance:Float;

public var _MinimumDistance:Float;

public var _ActiveYDistance:Float;

public var _YDistance:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Danger Actor Type", "_DangerActorType");
nameMap.set("X Distance", "_XDistance");
_XDistance = 0.0;
nameMap.set("Minimum Distance", "_MinimumDistance");
_MinimumDistance = 0.0;
nameMap.set("Active Y Distance", "_ActiveYDistance");
_ActiveYDistance = 0.0;
nameMap.set("Y Distance", "_YDistance");
_YDistance = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        for(actorOfType in getActorsOfType(_DangerActorType))
{
if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
            _YDistance = asNumber((actorOfType.getYCenter() - actor.getYCenter()));
propertyChanged("_YDistance", _YDistance);
            if(((_YDistance > _ActiveYDistance) || (_YDistance < -(_ActiveYDistance))))
{
                continue;
}

            _XDistance = asNumber((actorOfType.getXCenter() - actor.getXCenter()));
propertyChanged("_XDistance", _XDistance);
            /* "Custom: Is \"Left\" on for Self" */
            if((((_XDistance >= -(_MinimumDistance)) && (_XDistance < 0)) && cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Left"])), Bool)))
{
                /* "Custom: Set \"Right\" to <true> for Self" */
                /* "Custom: Set \"Left\" to <false> for Self" */
                actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",true]);
                actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",false]);
}

            /* "Custom: Is \"Right\" on for Self" */
            else if((((_XDistance <= _MinimumDistance) && (_XDistance > 0)) && cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Right"])), Bool)))
{
                /* "Custom: Set \"Right\" to <false> for Self" */
                /* "Custom: Set \"Left\" to <true> for Self" */
                actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Left",true]);
                actor.say("Control Adapter PM", "_customBlock_SetIsOn", ["Right",false]);
}

}
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}