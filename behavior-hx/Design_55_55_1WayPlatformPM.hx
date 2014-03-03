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



class Design_55_55_1WayPlatformPM extends ActorScript
{          	
	
public var _ShouldCollide:Bool;

public var _CollideAnimation:String;

public var _NoCollideAnimation:String;

public var _PreventCollision:Bool;

public var _MarginOfError:Float;

public var _TargetAnimation:String;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Should Collide?", "_ShouldCollide");
_ShouldCollide = false;
nameMap.set("Collide Animation", "_CollideAnimation");
nameMap.set("No Collide Animation", "_NoCollideAnimation");
nameMap.set("Prevent Collision?", "_PreventCollision");
_PreventCollision = false;
nameMap.set("Margin Of Error", "_MarginOfError");
_MarginOfError = 0.0;
nameMap.set("Target Animation", "_TargetAnimation");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_PreventCollision)
{
            if(!(actor.getAnimation() == _NoCollideAnimation))
{
                actor.setAnimation("" + _NoCollideAnimation);
}

}

        else
{
            _ShouldCollide = true;
propertyChanged("_ShouldCollide", _ShouldCollide);
            /* "note that this behaviour only really works with a single player..." */
            for(actorInGroup in getActorGroup(0).list)
{
if(actorInGroup != null && !actorInGroup.dead && !actorInGroup.recycled){
                /* "Custom: <member of group> and Self overlap on x axis" */
                if(!(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorsOverlapOnX(actorInGroup,actor)), Bool)))
{
                    _ShouldCollide = false;
propertyChanged("_ShouldCollide", _ShouldCollide);
                    break;
}

                /* "Custom: Get bottom for <member of group>, Get top for Self" */
                if((cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorBottom(actorInGroup)), Float) > (cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop(actor)), Float) + _MarginOfError)))
{
                    _ShouldCollide = false;
propertyChanged("_ShouldCollide", _ShouldCollide);
                    break;
}

}
}

            if(_ShouldCollide)
{
                _TargetAnimation = _CollideAnimation;
propertyChanged("_TargetAnimation", _TargetAnimation);
}

            else
{
                _TargetAnimation = _NoCollideAnimation;
propertyChanged("_TargetAnimation", _TargetAnimation);
}

            if(!(actor.getAnimation() == _TargetAnimation))
{
                actor.setAnimation("" + _TargetAnimation);
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}