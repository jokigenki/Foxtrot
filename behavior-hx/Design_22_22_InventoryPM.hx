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

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_22_22_InventoryPM extends SceneScript
{          	
	
public var _CurrentWidth:Float;

public var _InventoryBorderX:Float;

public var _InventoryBorderY:Float;

public var _ItemList:Array<Dynamic>;

public var _InventoryHolder:Actor;

public var _ItemSpacing:Float;

public var _LastActor:Actor;

public var _InventoryItemsCreated:Array<Dynamic>;

public var _ActorList:Array<Dynamic>;
    public function _customEvent_InventoryHolderReady():Void
{
        _CurrentWidth = asNumber(_InventoryBorderX);
propertyChanged("_CurrentWidth", _CurrentWidth);
        /* "Custom: Create New Inventory, Update Inventory" */
        sayToScene("Inventory PM", "_customBlock_CreateNewInventory");
        sayToScene("Inventory PM", "_customBlock_UpdateInventory");
}

    public function _customEvent_ItemAddedToInventory():Void
{
        /* "Custom: Create New Inventory, Update Inventory" */
        sayToScene("Inventory PM", "_customBlock_CreateNewInventory");
        sayToScene("Inventory PM", "_customBlock_UpdateInventory");
        shoutToScene("_customEvent_" + "InventoryUpdated");
}

    

/* Params are:*/
public function _customBlock_CreateNewInventory():Void
{
        /* "Items will be placed in Inventory New before being moved to the inventory proper, so they are only counted once" */
        /* "GA: Inventory New" */
        for(item in cast(getGameAttribute("Inventory New"), Array<Dynamic>))
{
            /* "GA: Inventory" */
            getGameAttribute("Inventory").push(item);
            /* "Custom: Increment <item>" */
            sayToScene("Inventory PM", "_customBlock_IncrementGameAttributeForType", [item]);
}

        /* "GA: Inventory New" */
        Utils.clear(getGameAttribute("Inventory New"));
}
    

/* Params are:*/
public function _customBlock_UpdateInventory():Void
{
        /* "Custom: Clear Inventory Actors" */
        sayToScene("Inventory PM", "_customBlock_ClearInventoryActors");
        Utils.clear(_InventoryItemsCreated);
        /* "GA: Inventory" */
        for(item in cast(getGameAttribute("Inventory"), Array<Dynamic>))
{
            if(!(Utils.contains(_ItemList, item)))
{
                trace("" + (("" + "Adding from inventory: ") + ("" + item)));
                _ItemList.push(item);
                /* "Try to create an inventory item (only once per item type!)" */
                if(!(Utils.contains(_InventoryItemsCreated, item)))
{
                    _InventoryItemsCreated.push(item);
                    /* "Custom: Create Actor for \"<item> & \" Inventory\"\" at x:\"<x (on screen)> of <Inventory Holder>\" + <Current Width>\" y:\"<y (on screen)> of <Inventory Holder> + <Inventory Border Y>\"" */
                    _LastActor = cast((sayToScene("Inventory PM", "_customBlock_CreateActorFromType", [(("" + item) + ("" + " Inventory")),(_InventoryHolder.getScreenX() + _CurrentWidth),(_InventoryHolder.getScreenY() + _InventoryBorderY)])), Actor);
propertyChanged("_LastActor", _LastActor);
                    /* "Custom: <Last Actor> is null" */
                    if(!(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorIsNull(_LastActor)), Bool)))
{
                        _CurrentWidth += ((_LastActor.getWidth()) + _ItemSpacing);
propertyChanged("_CurrentWidth", _CurrentWidth);
}

}

}

}

}
    

/* Params are:__ItemName */
public function _customBlock_IsInInventory(__ItemName:String):Bool
{
        for(item in cast(_ItemList, Array<Dynamic>))
{
            if((__ItemName == item))
{
                return true;
}

}

        return false;
}
    

/* Params are:__TypeName __x __y */
public function _customBlock_CreateActorFromType(__TypeName:String, __x:Float, __y:Float):Actor
{
        if (getActorTypeByName(__TypeName) == null) return null;
return createRecycledActor(getActorTypeByName(__TypeName), __x, __y, Script.FRONT);
}
    

/* Params are:__TypeName */
public function _customBlock_IncrementGameAttributeForType(__TypeName:String):Void
{
        /* "Custom: \"Get Number of <Type Name>\"" */
        setGameAttribute((("" + __TypeName) + ("" + "s")), (cast((sayToScene("Inventory PM", "_customBlock_GetCountForType", [__TypeName])), Float) + 1));
}
    

/* Params are:__TypeName */
public function _customBlock_GetCountForType(__TypeName:String):Float
{
        return (getGameAttribute((("" + StringTools.trim(("" + __TypeName))) + ("" + "s"))));
}
    

/* Params are:__TypeName */
public function _customBlock_RemoveFromInventory(__TypeName:String):Void
{
        /* "Custom: \"Get Number of <Type Name>\"" */
        setGameAttribute((("" + __TypeName) + ("" + "s")), (cast((sayToScene("Inventory PM", "_customBlock_GetCountForType", [__TypeName])), Float) - 1));
        /* "GA: Inventory" */
        getGameAttribute("Inventory").remove(__TypeName);
        _ItemList.remove(__TypeName);
        /* "GA: Inventory" */
        trace("" + getGameAttribute("Inventory").length);
        trace("" + __TypeName);
        /* "Custom: Update Inventory" */
        sayToScene("Inventory PM", "_customBlock_UpdateInventory");
}
    

/* Params are:*/
public function _customBlock_ClearInventoryActors():Void
{
        for(item in cast(_ActorList, Array<Dynamic>))
{
            recycleActor(item);
}

        _CurrentWidth = asNumber(_InventoryBorderX);
propertyChanged("_CurrentWidth", _CurrentWidth);
        Utils.clear(_ItemList);
}

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Current Width", "_CurrentWidth");
_CurrentWidth = 0.0;
nameMap.set("Inventory Border X", "_InventoryBorderX");
_InventoryBorderX = 0.0;
nameMap.set("Inventory Border Y", "_InventoryBorderY");
_InventoryBorderY = 0.0;
nameMap.set("Item List", "_ItemList");
_ItemList = [];
nameMap.set("Inventory Holder", "_InventoryHolder");
nameMap.set("Item Spacing", "_ItemSpacing");
_ItemSpacing = 0.0;
nameMap.set("Last Actor", "_LastActor");
nameMap.set("Inventory Items Created", "_InventoryItemsCreated");
_InventoryItemsCreated = [];
nameMap.set("Actor List", "_ActorList");
_ActorList = [];

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}