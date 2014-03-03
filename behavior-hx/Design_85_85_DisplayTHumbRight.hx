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



class Design_85_85_DisplayTHumbRight extends SceneScript
{          	
	
public var _Thumb:Actor;
    public function _customEvent_DisplayThumbRight():Void
{
        if(#if mobile true #else false #end)
{
            createRecycledActor(getActorType(131), (getScreenWidth() - 192), (getScreenHeight() - 138), Script.FRONT);
            getLastCreatedActor().growTo(-100/100, 100/100, 0, Linear.easeNone);
            _Thumb = getLastCreatedActor();
propertyChanged("_Thumb", _Thumb);
            _Thumb.setActorValue("_KillOnControl", "Right");
            for(actorOfType in getActorsOfType(getActorType(9)))
{
if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
                _Thumb.setActorValue("_TargetActor", actorOfType);
}
}

}

}

    public function _customEvent_RemoveThumbRight():Void
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