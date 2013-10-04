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



class Design_110_110_RotatingElevatorPM extends ActorScript
{          	
	
public var _MovementSpeed:Float;

public var _ActualPosition:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Movement Speed", "_MovementSpeed");
_MovementSpeed = 0.0;
nameMap.set("Actual Position", "_ActualPosition");
_ActualPosition = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            _ActualPosition = asNumber(actor.getY());
propertyChanged("_ActualPosition", _ActualPosition);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _ActualPosition = asNumber((_ActualPosition + _MovementSpeed));
propertyChanged("_ActualPosition", _ActualPosition);
        if(((_ActualPosition <= 0) && (_MovementSpeed < 0)))
{
            _ActualPosition = asNumber((getSceneHeight() - actor.getHeight()));
propertyChanged("_ActualPosition", _ActualPosition);
}

        else if(((_ActualPosition >= getSceneHeight()) && (_MovementSpeed > 0)))
{
            _ActualPosition = asNumber(0);
propertyChanged("_ActualPosition", _ActualPosition);
}

        actor.setY(_ActualPosition);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}