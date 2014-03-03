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

            import com.stencyl.Data;


class Design_207_207_StencylExtrasPM extends ActorScript
{          	
	    

/* Params are:__Attribute __Value */
public static function _customBlock_SetGameAttribute(__Attribute:String, __Value:Dynamic):Void
{
        Engine.engine.setGameAttribute(__Attribute, __Value);
}
    

/* Params are:__Attribute */
public static function _customBlock_GetGameAttribute(__Attribute:String):Dynamic
{
        return Engine.engine.getGameAttribute(__Attribute);
}
    

/* Params are:*/
public static function _customBlock_GetCurrentScene():Scene
{
        return Engine.engine.scene;
}
    

/* Params are:*/
public static function _customBlock_CurrentSceneName():String
{
        return Engine.engine.scene.name;
}
    

/* Params are:__EventName */
public static function _customBlock_TriggerEventInAllForCurrentScene(__EventName:String):Void
{
        Engine.engine.shout(__EventName);
}
    

/* Params are:__SoundName */
public static function _customBlock_GetNamedSound(__SoundName:String):Sound
{
        for(r in Data.get().resources)
{
	if(r != null && __SoundName == r.name)
	{
		return cast(Data.get().resources.get(r.ID), Sound);
	}
}

return null;
}
    

/* Params are:__ResourceName */
public static function _customBlock_GetNamedResourceID(__ResourceName:String):Float
{
        for (r in Data.get().resources)
{
	if(r != null && __ResourceName == r.name)
	{
		return r.ID;	
	}
}
			
return 0;
}
    

/* Params are:__Text __Divider */
public static function _customBlock_SplitText(__Text:String, __Divider:String):Array<Dynamic>
{
        return __Text.split(__Divider);
}
    

/* Params are:__List */
public static function _customBlock_GetRandomItemFromList(__List:Array<Dynamic>):Dynamic
{
        return __List[Std.int(Math.floor(Math.random() * __List.length))];
}
    

/* Params are:__Colours */
public static function _customBlock_GetRandomColour(__Colours:Array<Dynamic>):Int
{
        var index = Math.floor(Math.random() * __Colours.length);
var colours = __Colours[index].split("|");
var r = Std.parseInt(colours[0]);
var g = Std.parseInt(colours[1]);
var b = Std.parseInt(colours[2]);
return Utils.getColorRGB(r, g, b);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}