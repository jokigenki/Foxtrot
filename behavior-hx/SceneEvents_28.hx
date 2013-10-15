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



class SceneEvents_28 extends SceneScript
{          	
	
public var _ExitName:String;

public var _RatOffset:Float;

public var _RatLeftTime:Float;

public var _RatHasLeft:Bool;
    public function _customEvent_RatExit1():Void
{
        /* "if rat leaves first, we need to time how long the player takes" */
        _RatLeftTime = asNumber(flash.Lib.getTimer());
propertyChanged("_RatLeftTime", _RatLeftTime);
        _RatHasLeft = true;
propertyChanged("_RatHasLeft", _RatHasLeft);
}

    public function _customEvent_PlayerExit1():Void
{
        if((!(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorIsNull(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorInScene(getGameAttribute("Last Rat"))), Actor))), Bool)) && !(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorIsNull(getActor(47))), Bool))))
{
            if(_RatHasLeft)
{
                /* "if the rat has already left, we need to calculate the time since it did so" */
                trace("" + (("" + "rat left: ") + ("" + "")));
}

            else
{
                /* "if the player leaves first, we need to find how long the rat would take to cover the remaining distance (~5ms/pixel)" */
                trace("" + (("" + "player left: ") + ("" + "")));
}

}

}


 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";
nameMap.set("Rat Offset", "_RatOffset");
_RatOffset = 0.0;
nameMap.set("Rat Left Time", "_RatLeftTime");
_RatLeftTime = 0.0;
nameMap.set("Rat Has Left?", "_RatHasLeft");
_RatHasLeft = false;

	}
	
	override public function init()
	{
		            if((getGameAttribute("Last Destination") == "Factory2_06|Factory2_07|B|A"))
{
            if(( < 0))
{
                /* "move the rat and egg spawners across to simulate the rat leaving the last scene earlier than the player" */
                _RatOffset = asNumber(Math.floor(( / -4)));
propertyChanged("_RatOffset", _RatOffset);
                if((_RatOffset > 400))
{
                    _RatOffset = asNumber(400);
propertyChanged("_RatOffset", _RatOffset);
}

                getActor(16).setX((getActor(16).getX() + _RatOffset));
                getActor(17).setX((getActor(17).getX() + _RatOffset));
}

            else if(( > 0))
{
                trace("" + (("" + "show rat after ") + ("" + "")));
                /* "remove the trigger, and manually trigger the rat after a certain time" */
                recycleActor(getActor(45));
                recycleActor(getActor(14));
                runLater(1000 * ( / 1000), function(timeTask:TimedTask):Void {
                            getActor(16).shout("_customEvent_" + "MakeSpawn");
                            getActor(17).shout("_customEvent_" + "MakeSpawn");
}, null);
}

}

        else
{
            recycleActor(getActor(45));
            recycleActor(getActor(14));
}


	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}