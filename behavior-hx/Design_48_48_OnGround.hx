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



class Design_48_48_OnGround extends ActorScript
{          	
	
public var _HitGround:Bool;

public var _LimitToTiles:Bool;

public var _ExcludedGroups:Array<Dynamic>;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Hit Ground?", "_HitGround");
_HitGround = false;
nameMap.set("Limit To Tiles?", "_LimitToTiles");
_LimitToTiles = false;
nameMap.set("Excluded Groups", "_ExcludedGroups");
_ExcludedGroups = [];
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            /* "Inputs:" */
        /* "None" */
        /* "Outputs:" */
        /* "\"On Ground?\" -- <Boolean> Actor Level Attribute" */
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        actor.setActorValue("On Ground?", _HitGround);
        actor.setActorValue("In Liquid?", false);
        _HitGround = false;
propertyChanged("_HitGround", _HitGround);
}
});
    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        /* "Don't consider collisions with sensors as hitting the ground" */
        if(event.thisCollidedWithSensor)
{
            return;
}

        /* "If we only want to detect collions with Tiles, and the Actor hit something other than the tile -- Quit" */
        if((_LimitToTiles && !(event.thisCollidedWithTile)))
{
            return;
}

        /* "If we are excluding certain Actor Groups - check those here and quit if appropriate" */
        if((_ExcludedGroups.length > 0))
{
            for(item in cast(_ExcludedGroups, Array<Dynamic>))
{
                if((("" + item) == ("" + internalGetGroup(event.otherActor, event.otherShape))))
{
                    return;
}

}

}

        /* "If we get here and detect a bottom collision, we're on the ground" */
        for(point in event.points)
{
            if((Math.abs(Math.round(Engine.toPixelUnits(point.normalY))) > 0.1))
{
                _HitGround = true;
propertyChanged("_HitGround", _HitGround);
                return;
}

}

        if(event.thisFromBottom)
{
            _HitGround = true;
propertyChanged("_HitGround", _HitGround);
            return;
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}