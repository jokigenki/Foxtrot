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



class Design_191_191_DisplayOnCollectedPM extends ActorScript
{          	
	
public var _GrowTime:Float;

public var _FadeTime:Float;

public var _IsDisplaying:Bool;

public var _GrowPercent:Float;

public var _StartSizePercent:Float;

public var _CollectionDisplayType:ActorType;
    

/* Params are:__Self */
public function _customBlock_DisplayOnCollect():Void
{
var __Self:Actor = actor;
        if(!(_IsDisplaying))
{
            createRecycledActor(_CollectionDisplayType, ((getScreenWidth() / 2) + getScreenX()), ((getScreenHeight() / 2) + getScreenY()), Script.FRONT);
            getLastCreatedActor().setValue("Display On Collected PM", "_IsDisplaying", true);
            getLastCreatedActor().setAnimation("" + ("" + (("" + ("" + actor.getAnimation())) + ("" + " Collected"))));
}

        else
{
            actor.growTo(_GrowPercent/100, _GrowPercent/100, _GrowTime, Quad.easeInOut);
            runLater(1000 * _GrowTime, function(timeTask:TimedTask):Void {
                        actor.fadeTo(0, _FadeTime, Quad.easeOut);
                        runLater(1000 * _FadeTime, function(timeTask:TimedTask):Void {
                                    recycleActor(actor);
}, actor);
}, actor);
}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Grow Time", "_GrowTime");
_GrowTime = 0.0;
nameMap.set("Fade Time", "_FadeTime");
_FadeTime = 0.0;
nameMap.set("Is Displaying?", "_IsDisplaying");
_IsDisplaying = false;
nameMap.set("Grow Percent", "_GrowPercent");
_GrowPercent = 0.0;
nameMap.set("Start Size Percent", "_StartSizePercent");
_StartSizePercent = 0.0;
nameMap.set("Collection Display Type", "_CollectionDisplayType");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if(!((hasValue(_CollectionDisplayType) != false)))
{
            _CollectionDisplayType = actor.getType();
            propertyChanged("_CollectionDisplayType", _CollectionDisplayType);
}

        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    if(_IsDisplaying)
{
                        actor.say("Display On Collected PM", "_customBlock_DisplayOnCollect");
}

}, actor);
    addWhenKilledListener(actor, function(list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(!(_IsDisplaying))
{
            actor.say("Display On Collected PM", "_customBlock_DisplayOnCollect");
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}