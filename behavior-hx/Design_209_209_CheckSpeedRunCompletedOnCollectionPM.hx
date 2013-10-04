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



class Design_209_209_CheckSpeedRunCompletedOnCollectionPM extends ActorScript
{          	
	
public var _RunComplete:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Run Complete?", "_RunComplete");
_RunComplete = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenKilledListener(actor, function(list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(getGameAttribute("Speed Run In Progress"))
{
            _RunComplete = true;
propertyChanged("_RunComplete", _RunComplete);
            for(item in cast(getGameAttribute("Speed Run Collectables"), Array<Dynamic>))
{
                if(!(Utils.contains(getGameAttribute("Collected Speed Run Items"), item)))
{
                    _RunComplete = false;
propertyChanged("_RunComplete", _RunComplete);
                    break;
}

}

            if(_RunComplete)
{
                trace("" + "SPEED RUN COMPLETE!");
                sayToScene("Speed Run Timer PM", "_customEvent_" + "CompleteSpeedRun");
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}