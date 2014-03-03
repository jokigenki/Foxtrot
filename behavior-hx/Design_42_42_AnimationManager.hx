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



class Design_42_42_AnimationManager extends ActorScript
{          	
	
public var _PlayingOneTime:Bool;

public var _CurrentCategory:String;

public var _DefaultRightAnimation:String;

public var _DefaultLeftAnimation:String;

public var _CategoryHierarchy:Array<Dynamic>;

public var _CurrentIndex:Bool;

public var _RequestedIndex:Bool;
    

/* Params are:__Self __Animation */
public function _customBlock_PlayOnce(__Animation:String):Void
{
var __Self:Actor = actor;
        __Self.setAnimation("" + __Animation);
        _PlayingOneTime = true;
propertyChanged("_PlayingOneTime", _PlayingOneTime);
}
    

/* Params are:__Self __Animation __Category */
public function _customBlock_LoopAnim(__Animation:String, __Category:String):Void
{
var __Self:Actor = actor;
        if(_PlayingOneTime)
{
            return;
}

        if((hasValue(_CurrentCategory) == false))
{
            _CurrentCategory = __Category;
propertyChanged("_CurrentCategory", _CurrentCategory);
}

        _CurrentIndex = false;
propertyChanged("_CurrentIndex", _CurrentIndex);
        _RequestedIndex = false;
propertyChanged("_RequestedIndex", _RequestedIndex);
        for(item in cast(_CategoryHierarchy, Array<Dynamic>))
{
            if((item == __Category))
{
                _RequestedIndex = true;
propertyChanged("_RequestedIndex", _RequestedIndex);
}

            if((item == _CurrentCategory))
{
                _CurrentIndex = true;
propertyChanged("_CurrentIndex", _CurrentIndex);
}

            if((_CurrentIndex && !(_RequestedIndex)))
{
                return;
}

}

        __Self.setAnimation("" + __Animation);
        _CurrentCategory = __Category;
propertyChanged("_CurrentCategory", _CurrentCategory);
}
    

/* Params are:__Self */
public function _customBlock_ClearCat():Void
{
var __Self:Actor = actor;
        if(!isPrimitive(_CurrentCategory)) {_CurrentCategory = getDefaultValue(_CurrentCategory);}
}
    

/* Params are:__Self */
public function _customBlock_GetCat():String
{
var __Self:Actor = actor;
        return _CurrentCategory;
}
    

/* Params are: __CheckCategory */
public function _customBlock_CategorySameAs(__CheckCategory:String):Bool
{
var __Self:Actor = actor;
        return (__CheckCategory == _CurrentCategory);
}
    

/* Params are: __ChkCat */
public function _customBlock_ClearAnimCat(__ChkCat:String):Void
{
var __Self:Actor = actor;
        if((__ChkCat == _CurrentCategory))
{
            if(!isPrimitive(_CurrentCategory)) {_CurrentCategory = getDefaultValue(_CurrentCategory);}
}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Playing One Time?", "_PlayingOneTime");
_PlayingOneTime = false;
nameMap.set("Current Category", "_CurrentCategory");
_CurrentCategory = "";
nameMap.set("Default Right Animation", "_DefaultRightAnimation");
nameMap.set("Default Left Animation", "_DefaultLeftAnimation");
nameMap.set("Category Hierarchy", "_CategoryHierarchy");
_CategoryHierarchy = ["Ground Pounding", "Ducking", "Wall Sliding", "Falling", "Wall Jumping", "Air Jumping", "Jumping", "Running", "Walking"];
nameMap.set("Current Index", "_CurrentIndex");
_CurrentIndex = false;
nameMap.set("Requested Index", "_RequestedIndex");
_RequestedIndex = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_PlayingOneTime)
{
            if(!(actor.isAnimationPlaying()))
{
                _PlayingOneTime = false;
propertyChanged("_PlayingOneTime", _PlayingOneTime);
}

            else
{
                return;
}

}

        if((hasValue(_CurrentCategory) == false))
{
            if(asBoolean(actor.getActorValue("Facing Right?")))
{
                actor.setAnimation("" + _DefaultRightAnimation);
}

            else
{
                actor.setAnimation("" + _DefaultLeftAnimation);
}

            return;
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}