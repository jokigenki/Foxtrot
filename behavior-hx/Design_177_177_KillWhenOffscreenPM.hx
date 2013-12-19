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



class Design_177_177_KillWhenOffscreenPM extends ActorScript
{          	
	
public var _Boundary:Float;

public var _InX:Bool;

public var _InY:Bool;

public var _TimingOutOfBounds:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Boundary", "_Boundary");
_Boundary = 32.0;
nameMap.set("In X?", "_InX");
_InX = false;
nameMap.set("In Y?", "_InY");
_InY = false;
nameMap.set("Timing Out Of Bounds?", "_TimingOutOfBounds");
_TimingOutOfBounds = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            actor.makeAlwaysSimulate();
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((actor.getX() < -(_Boundary)))
{
            _InX = false;
propertyChanged("_InX", _InX);
}

        else if((actor.getX() > (getSceneWidth() + _Boundary)))
{
            _InX = false;
propertyChanged("_InX", _InX);
}

        else
{
            _InX = true;
propertyChanged("_InX", _InX);
}

        if((actor.getY() < -(_Boundary)))
{
            _InY = false;
propertyChanged("_InY", _InY);
}

        else if((actor.getY() > (getSceneHeight() + _Boundary)))
{
            _InY = false;
propertyChanged("_InY", _InY);
}

        else
{
            _InY = true;
propertyChanged("_InY", _InY);
}

        if(!(_TimingOutOfBounds))
{
            if((!(_InX) || !(_InY)))
{
                _TimingOutOfBounds = true;
propertyChanged("_TimingOutOfBounds", _TimingOutOfBounds);
                runLater(1000 * 1, function(timeTask:TimedTask):Void {
                            if((!(_InX) || !(_InY)))
{
                                if(isTransitioning())
{
                                    return;
}

                                recycleActor(actor);
}

                            _TimingOutOfBounds = false;
propertyChanged("_TimingOutOfBounds", _TimingOutOfBounds);
}, actor);
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}