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



class Design_190_190_PopupManagerPM extends SceneScript
{          	
	
public var _Popup:Actor;
    

/* Params are:__PopupType */
public function _customBlock_DisplayPopup(__PopupType:ActorType):Void
{
        sayToScene("Popup Manager PM", "_customBlock_DisplayPopupAt", [__PopupType,(getScreenWidth() / 2),(getScreenHeight() / 2)]);
}
    

/* Params are:__PopupType __XPosition __YPosition */
public function _customBlock_DisplayPopupAt(__PopupType:ActorType, __XPosition:Float, __YPosition:Float):Void
{
        sayToScene("Popup Manager PM", "_customBlock_RemovePopup");
        createRecycledActor(__PopupType, __XPosition, __YPosition, Script.MIDDLE);
        _Popup = getLastCreatedActor();
propertyChanged("_Popup", _Popup);
}
    

/* Params are:*/
public function _customBlock_RemovePopup():Void
{
        if (_Popup != null)
{
	recycleActor(_Popup);
	_Popup = null;
}
}

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Popup", "_Popup");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}