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



class Design_241_241_SpawnSineWaveControllerPM extends ActorScript
{          	
	
public var _MaximumValue:Float;

public var _Frequency:Float;

public var _CurrentTime:Float;

public var _MinimumValue:Float;

public var _StartTime:Float;
    public function _customEvent_Spawned():Void
{
        _CurrentTime = asNumber((_CurrentTime + actor.getValue("Spawn PM", "_SpawnRepeatDelay")));
propertyChanged("_CurrentTime", _CurrentTime);
        // give a value between 0 and amplitude
var m2 = (_MaximumValue - _MinimumValue) / 2;
var value = m2 * Math.sin(_Frequency * (_CurrentTime + _StartTime)) + m2 + _MinimumValue;
        actor.setValue("Spawn PM", "_SpawnRepeatDelay", value);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Maximum Value", "_MaximumValue");
_MaximumValue = 1.0;
nameMap.set("Frequency", "_Frequency");
_Frequency = 0.0;
nameMap.set("Current Time", "_CurrentTime");
_CurrentTime = 0.0;
nameMap.set("Minimum Value", "_MinimumValue");
_MinimumValue = 0.1;
nameMap.set("Start Time", "_StartTime");
_StartTime = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _CurrentTime = asNumber(0);
propertyChanged("_CurrentTime", _CurrentTime);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}