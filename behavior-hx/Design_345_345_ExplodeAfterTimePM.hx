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



class Design_345_345_ExplodeAfterTimePM extends ActorScript
{          	
	
public var _TimeElapsed:Float;

public var _Beatsperframe:Float;

public var _ExplodeAfterSeconds:Float;

public var _ExplodeBehaviour:String;

public var _IsReady:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Time Elapsed", "_TimeElapsed");
_TimeElapsed = 0.0;
nameMap.set("Beats per frame", "_Beatsperframe");
_Beatsperframe = 0.0;
nameMap.set("Explode After Seconds", "_ExplodeAfterSeconds");
_ExplodeAfterSeconds = 3.0;
nameMap.set("Explode Behaviour", "_ExplodeBehaviour");
_ExplodeBehaviour = "Explode With Set Pieces PM";
nameMap.set("Is Ready?", "_IsReady");
_IsReady = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            runLater(1000 * 0.15, function(timeTask:TimedTask):Void {
                    _IsReady = true;
propertyChanged("_IsReady", _IsReady);
                    _Beatsperframe = asNumber(((_ExplodeAfterSeconds / actor.getNumFrames()) * 10));
propertyChanged("_Beatsperframe", _Beatsperframe);
                    _TimeElapsed = asNumber(0);
propertyChanged("_TimeElapsed", _TimeElapsed);
                    runPeriodically(1000 * 0.1, function(timeTask:TimedTask):Void {
                                _TimeElapsed += 1;
propertyChanged("_TimeElapsed", _TimeElapsed);
                                if(((_TimeElapsed / 10) >= _ExplodeAfterSeconds))
{
                                    actor.say(_ExplodeBehaviour, "_customEvent_" + "Killed");
}

}, actor);
}, actor);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_IsReady)
{
            actor.setCurrentFrame(Std.int(Math.floor((_TimeElapsed / _Beatsperframe))));
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}