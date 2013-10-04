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



class Design_206_206_DoorsAndInventoryExtrasPM extends ActorScript
{          	
	
public var _Destination:String;
    

/* Params are:__ExitName */
public static function _customBlock_IsDoorUnlocked(__ExitName:String):Bool
{
        if(("" + __ExitName) == (""))
{
            return false;
}

        if((scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.SPEED_RUN_IN_PROGRESS)))
{
            return Utils.contains((scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.UNLOCKED_SPEED_RUN_DOORS)), __ExitName);
}

        else
{
            return Utils.contains((scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.UNLOCKED_DOORS)), __ExitName);
}

}
    

/* Params are:__ExitName */
public static function _customBlock_UnlockExit(__ExitName:String):Void
{
        if(cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_IsDoorUnlocked(__ExitName)), Bool))
{
            return;
}

        if((scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.SPEED_RUN_IN_PROGRESS)))
{
            (scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.UNLOCKED_SPEED_RUN_DOORS)).push(__ExitName);
            (scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.UNLOCKED_SPEED_RUN_DOORS)).push("" + (scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ReverseDestination(__ExitName)));
}

        else
{
            (scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.UNLOCKED_DOORS)).push(__ExitName);
            (scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.UNLOCKED_DOORS)).push("" + (scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ReverseDestination(__ExitName)));
}

}
    

/* Params are:__ItemId */
public static function _customBlock_ItemHasBeenCollected(__ItemId:String):Bool
{
        if(("" + __ItemId) == (""))
{
            return false;
}

        if((scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.SPEED_RUN_IN_PROGRESS)))
{
            return Utils.contains((scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.COLLECTED_SPEED_RUN_ITEMS)), __ItemId);
}

        else
{
            return Utils.contains((scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.COLLECTED_ITEMS)), __ItemId);
}

}
    

/* Params are:__ItemId __ActorType */
public static function _customBlock_CollectItemWithType(__ItemId:String, __ActorType:ActorType):Void
{
        if(cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected(__ItemId)), Bool))
{
            return;
}

        if((scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.SPEED_RUN_IN_PROGRESS)))
{
            (scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.COLLECTED_SPEED_RUN_ITEMS)).push(__ItemId);
}

        else
{
            (scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.COLLECTED_ITEMS)).push(__ItemId);
            (scripts.Design_207_207_StencylExtrasPM._customBlock_GetGameAttribute(FoxtrotConstants.INVENTORY)).push(__ItemId);
}

        scripts.Design_207_207_StencylExtrasPM._customBlock_TriggerEventInAllForCurrentScene("ItemAddedToInventory");
}
    

/* Params are:*/
public static function _customBlock_LockAllSpeedRunDoors():Void
{
        scripts.Design_207_207_StencylExtrasPM._customBlock_SetGameAttribute(FoxtrotConstants.UNLOCKED_SPEED_RUN_DOORS,new Array<Dynamic>());
}
    

/* Params are:*/
public static function _customBlock_LockAllDoors():Void
{
        scripts.Design_207_207_StencylExtrasPM._customBlock_SetGameAttribute(FoxtrotConstants.UNLOCKED_DOORS,new Array<Dynamic>());
}
    

/* Params are:*/
public static function _customBlock_EmptyCollectedItems():Void
{
        scripts.Design_207_207_StencylExtrasPM._customBlock_SetGameAttribute(FoxtrotConstants.COLLECTED_ITEMS,new Array<Dynamic>());
}
    

/* Params are:*/
public static function _customBlock_EmptyInventory():Void
{
        scripts.Design_207_207_StencylExtrasPM._customBlock_SetGameAttribute(FoxtrotConstants.INVENTORY,new Array<Dynamic>());
        scripts.Design_207_207_StencylExtrasPM._customBlock_SetGameAttribute(FoxtrotConstants.INVENTORY_NEW,new Array<Dynamic>());
}
    

/* Params are:*/
public static function _customBlock_EmptySpeedRunCollected():Void
{
        scripts.Design_207_207_StencylExtrasPM._customBlock_SetGameAttribute(FoxtrotConstants.COLLECTED_SPEED_RUN_ITEMS,new Array<Dynamic>());
}
    

/* Params are:__LastExit __ThisExit */
public static function _customBlock_DoExitsMatch(__LastExit:String, __ThisExit:String):Bool
{
        var lastComps = __LastExit.split("|");
var thisComps = __ThisExit.split("|");

return lastComps[0] == thisComps[1] &&
	lastComps[1] == thisComps[0] &&
	lastComps[2] == thisComps[2];
}
    

/* Params are:__Destination */
public static function _customBlock_ReverseDestination(__Destination:String):String
{
        var comps = __Destination.split("|");
return comps[1] + "|" + comps[0] + "|" + comps[2];
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Destination", "_Destination");
_Destination = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}