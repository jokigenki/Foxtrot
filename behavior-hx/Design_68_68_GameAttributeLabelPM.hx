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



class Design_68_68_GameAttributeLabelPM extends ActorScript
{          	
	
public var _OffsetX:Float;

public var _OffsetY:Float;

public var _TextPrefix:String;

public var _AttributeName:String;

public var _CurrentText:String;
    public function _customEvent_InventoryUpdated():Void
{
        trace("" + "INVENTORY UPDATE");
        if(("" + _TextPrefix) == (""))
{
            _CurrentText = (getGameAttribute(_AttributeName));
propertyChanged("_CurrentText", _CurrentText);
}

        else
{
            _CurrentText = (("" + _TextPrefix) + ("" + (getGameAttribute(_AttributeName))));
propertyChanged("_CurrentText", _CurrentText);
}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Offset X", "_OffsetX");
_OffsetX = 0.0;
nameMap.set("Offset Y", "_OffsetY");
_OffsetY = 0.0;
nameMap.set("Text Prefix", "_TextPrefix");
_TextPrefix = "";
nameMap.set("Attribute Name", "_AttributeName");
_AttributeName = "";
nameMap.set("Current Text", "_CurrentText");
_CurrentText = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(!(("" + _CurrentText) == ("")))
{
            g.translateToActor(actor);
            g.setFont(getFont(575));
            g.drawString("" + _CurrentText, _OffsetX, _OffsetY);
}

}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(((getGameAttribute(_AttributeName)) == 0))
{
            recycleActor(actor);
}

        if(("" + _TextPrefix) == (""))
{
            _CurrentText = (getGameAttribute(_AttributeName));
propertyChanged("_CurrentText", _CurrentText);
}

        else
{
            _CurrentText = (("" + _TextPrefix) + ("" + (getGameAttribute(_AttributeName))));
propertyChanged("_CurrentText", _CurrentText);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}