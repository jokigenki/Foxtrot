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



class Design_311_311_LinearDegreesChangerPM extends ActorScript
{          	
	
public var _TargetBehaviourName:String;

public var _CurrentDegrees:Float;

public var _Direction:Float;

public var _MaxAngle:Float;

public var _MinAngle:Float;

public var _TargetBehaviourIsReady:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Target Behaviour Name", "_TargetBehaviourName");
_TargetBehaviourName = "";
nameMap.set("Current Degrees", "_CurrentDegrees");
_CurrentDegrees = 0.0;
nameMap.set("Direction", "_Direction");
_Direction = 0.0;
nameMap.set("Max Angle", "_MaxAngle");
_MaxAngle = 0.0;
nameMap.set("Min Angle", "_MinAngle");
_MinAngle = 0.0;
nameMap.set("Target Behaviour Is Ready?", "_TargetBehaviourIsReady");
_TargetBehaviourIsReady = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            runPeriodically(1000 * 0.1, function(timeTask:TimedTask):Void {
                    if(actor.isBehaviorEnabled(_TargetBehaviourName))
{
                        _CurrentDegrees = asNumber(actor.getValue(_TargetBehaviourName, "_Degrees"));
propertyChanged("_CurrentDegrees", _CurrentDegrees);
                        _TargetBehaviourIsReady = true;
propertyChanged("_TargetBehaviourIsReady", _TargetBehaviourIsReady);
                        timeTask.repeats = false;
return;
}

}, actor);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(!(_TargetBehaviourIsReady))
{
            return;
}

        if(((_CurrentDegrees <= _MinAngle) && (_Direction < 0)))
{
            _Direction = asNumber((_Direction * -1));
propertyChanged("_Direction", _Direction);
}

        else if(((_CurrentDegrees >= _MaxAngle) && (_Direction > 0)))
{
            _Direction = asNumber((_Direction * -1));
propertyChanged("_Direction", _Direction);
}

        _CurrentDegrees = asNumber((_CurrentDegrees + _Direction));
propertyChanged("_CurrentDegrees", _CurrentDegrees);
        actor.setValue(_TargetBehaviourName, "_Degrees", _CurrentDegrees);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}