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



class Design_84_84_DisplayThumbLeft extends SceneScript
{          	
	
public var _Thumb:Actor;
    public function _customEvent_DisplayThumbLeft():Void
{
        if(#if mobile true #else false #end)
{
            createRecycledActor(getActorType(131), 0, (getScreenHeight() - 138), Script.FRONT);
            _Thumb = getLastCreatedActor();
propertyChanged("_Thumb", _Thumb);
            _Thumb.setActorValue("_KillOnControl", "Left");
            for(actorOfType in getActorsOfType(getActorType(9)))
{
if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
                _Thumb.setActorValue("_TargetActor", actorOfType);
}
}

}

}

    public function _customEvent_RemoveThumbLeft():Void
{
        recycleActor(_Thumb);
}


 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Thumb", "_Thumb");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}