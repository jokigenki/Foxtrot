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



class Design_263_263_FillingLiquidPM extends ActorScript
{          	
	
public var _LiquidLevel:Float;

public var _MaxLevel:Float;

public var _ClipHeight:Float;

public var _ScaleX:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Liquid Level", "_LiquidLevel");
_LiquidLevel = 0.0;
nameMap.set("Max Level", "_MaxLevel");
_MaxLevel = 0.0;
nameMap.set("Clip Height", "_ClipHeight");
_ClipHeight = 0.0;
nameMap.set("Scale X", "_ScaleX");
_ScaleX = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _ScaleX = asNumber(((cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorRight(actor)), Float) - cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft(actor)), Float)) / (actor.getWidth())));
propertyChanged("_ScaleX", _ScaleX);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        var level = _LiquidLevel < _MaxLevel ? _LiquidLevel : _MaxLevel;
var h = (level / _ClipHeight) * 100;
        actor.growTo((100 * _ScaleX)/100, h/100, 0.1, Linear.easeNone);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}