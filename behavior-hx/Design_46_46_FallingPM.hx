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



class Design_46_46_FallingPM extends ActorScript
{          	
	
public var _OldY:Float;

public var _CanFall:Bool;

public var _FallRightAnimation:String;

public var _FallLeftAnimation:String;

public var _GroundY:Float;

public var _AnimationCategory:String;

public var _PreventFalling:Bool;
    public function _customEvent_CheckFalling():Void
{
        _CanFall = false;
propertyChanged("_CanFall", _CanFall);
        if((actor.getActorValue("On Ground?") || (actor.getY() <= _OldY)))
{
            return;
}

        if(asBoolean(actor.getActorValue("Is Wall Sliding?")))
{
            return;
}

        if((!(_CanFall) && (Math.abs((_GroundY - actor.getY())) <= 3)))
{
            return;
}

        _CanFall = true;
propertyChanged("_CanFall", _CanFall);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Old Y", "_OldY");
_OldY = 0.0;
nameMap.set("Can Fall?", "_CanFall");
_CanFall = false;
nameMap.set("Fall Right Animation", "_FallRightAnimation");
nameMap.set("Fall Left Animation", "_FallLeftAnimation");
nameMap.set("Ground Y", "_GroundY");
_GroundY = 0.0;
nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Falling";
nameMap.set("Prevent Falling?", "_PreventFalling");
_PreventFalling = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            /* "Inputs:" */
        /* "\"Facing Right?\" -- <Boolean> Actor Level Attribute, from \"Walking\" Behavior (required)" */
        /* "Outputs:" */
        /* "\"Is Falling?\" -- <Boolean> Actor Level Attribute" */
        _PreventFalling = false;
propertyChanged("_PreventFalling", _PreventFalling);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_PreventFalling)
{
            /* "Clear Current Anim Category Is Same As <Animation Category>" */
            actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
            return;
}

        if(!(asBoolean(actor.getActorValue("On Ground?"))))
{
            _customEvent_CheckFalling();
            if(!(_CanFall))
{
                /* "Clear Current Anim Category Is Same As <Animation Category>" */
                actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
}

}

        else
{
            /* "Clear Current Anim Category Is Same As <Animation Category>" */
            actor.say("Animation Manager", "_customBlock_ClearAnimCat", [_AnimationCategory]);
            return;
}

        if(!(_CanFall))
{
            actor.setActorValue("Is Falling?", false);
}

        else
{
            actor.setActorValue("Is Falling?", true);
            if(asBoolean(actor.getActorValue("Facing Right?")))
{
                /* "Custom: Loop <Fall Right Animation> for Self Using <Animation Category>" */
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_FallRightAnimation,_AnimationCategory]);
}

            else
{
                /* "Custom: Loop <Fall Left Animation> for Self Using <Animation Category>" */
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_FallLeftAnimation,_AnimationCategory]);
}

}

        _OldY = asNumber(actor.getY());
propertyChanged("_OldY", _OldY);
        if(asBoolean(actor.getActorValue("On Ground?")))
{
            _GroundY = asNumber(actor.getY());
propertyChanged("_GroundY", _GroundY);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}