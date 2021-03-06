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



class Design_44_44_Ducking extends ActorScript
{          	
	
public var _DuckRightAnimation:String;

public var _DuckLeftAnimation:String;

public var _AnimationCategory:String;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Duck Right Animation", "_DuckRightAnimation");
nameMap.set("Duck Left Animation", "_DuckLeftAnimation");
nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Ducking";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            /* "Inputs:---------------------" */
        /* "\"Facing Right?\" -- <Boolean> Actor Level Attribute, set in \"Walking\" Behavior (required)" */
        /* "Outputs:-------------------" */
        /* "\"Is Ducking?\" -- <Boolean> Actor Level Attribute" */
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(cast((actor.say("Control Adapter PM", "_customBlock_ControlIsOn", ["Duck"])), Bool))
{
            actor.setActorValue("Is Ducking?", true);
            if(asBoolean(actor.getActorValue("Facing Right?")))
{
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_DuckRightAnimation,_AnimationCategory]);
}

            else
{
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_DuckLeftAnimation,_AnimationCategory]);
}

}

        else
{
            actor.setActorValue("Is Ducking?", false);
            actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}