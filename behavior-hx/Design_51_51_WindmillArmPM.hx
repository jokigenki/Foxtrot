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

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Back;
import com.eclecticdesignstudio.motion.easing.Cubic;
import com.eclecticdesignstudio.motion.easing.Elastic;
import com.eclecticdesignstudio.motion.easing.Expo;
import com.eclecticdesignstudio.motion.easing.Linear;
import com.eclecticdesignstudio.motion.easing.Quad;
import com.eclecticdesignstudio.motion.easing.Quart;
import com.eclecticdesignstudio.motion.easing.Quint;
import com.eclecticdesignstudio.motion.easing.Sine;



class Design_51_51_WindmillArmPM extends ActorScript
{          	
	
public var _XOffset:Float;

public var _YOffset:Float;

public var _Radius:Float;

public var _StartAngle:Float;

public var _Pivot:Actor;

public var _TargetX:Float;

public var _TargetY:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("X Offset", "_XOffset");
_XOffset = 0.0;
nameMap.set("Y Offset", "_YOffset");
_YOffset = 0.0;
nameMap.set("Radius", "_Radius");
_Radius = 0.0;
nameMap.set("Start Angle", "_StartAngle");
_StartAngle = 0.0;
nameMap.set("Pivot", "_Pivot");
nameMap.set("Target X", "_TargetX");
_TargetX = 0.0;
nameMap.set("Target Y", "_TargetY");
_TargetY = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if((hasValue(_Pivot) != false))
{
            /* "Custom: distance between <Pivot> and Self" */
            _Radius = asNumber(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_CalculateDistance(_Pivot,actor)), Float));
propertyChanged("_Radius", _Radius);
            _StartAngle = asNumber(Math.atan2((actor.getYCenter() - _Pivot.getYCenter()), (actor.getXCenter() - _Pivot.getXCenter())));
propertyChanged("_StartAngle", _StartAngle);
}

        _XOffset = asNumber((actor.getX() - actor.getXCenter()));
propertyChanged("_XOffset", _XOffset);
        _YOffset = asNumber((actor.getY() - actor.getYCenter()));
propertyChanged("_YOffset", _YOffset);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((hasValue(_Pivot) != false))
{
            _TargetX = asNumber((_XOffset + (_Pivot.getXCenter() + (Math.sin((Utils.RAD * (Utils.DEG * (_Pivot.getAngle())) + _StartAngle)) * _Radius))));
propertyChanged("_TargetX", _TargetX);
            _TargetY = asNumber((_YOffset + (_Pivot.getYCenter() + (Math.cos((Utils.RAD * (Utils.DEG * (_Pivot.getAngle())) + _StartAngle)) * _Radius))));
propertyChanged("_TargetY", _TargetY);
            actor.say("Rideable Platform PM", "_customBlock_MovePlatform", [_TargetX,_TargetY]);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}