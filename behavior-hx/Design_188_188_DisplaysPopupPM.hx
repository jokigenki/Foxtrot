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



class Design_188_188_DisplaysPopupPM extends ActorScript
{          	
	
public var _ActivationRegion:Region;

public var _PopupActivationActorType:ActorType;

public var _PopupType:ActorType;

public var _XOffset:Float;

public var _YOffset:Float;

public var _InactivePopupType:ActorType;
    public function _customEvent_RefreshPopup():Void
{
        if((actor.hasBehavior("Usable Item PM") && (actor.getValue("Usable Item PM", "_CurrentNumberOfUses") < (actor.getValue("Usable Item PM", "_ActivateAfterNumberOfUses") - 1))))
{
            sayToScene("Popup Manager PM", "_customBlock_DisplayPopupAt", [_InactivePopupType,(actor.getX() + _XOffset),(actor.getY() + _YOffset)]);
}

        else
{
            sayToScene("Popup Manager PM", "_customBlock_DisplayPopupAt", [_PopupType,(actor.getX() + _XOffset),(actor.getY() + _YOffset)]);
}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Activation Region", "_ActivationRegion");
nameMap.set("Popup Activation Actor Type", "_PopupActivationActorType");
nameMap.set("Popup Type", "_PopupType");
nameMap.set("X Offset", "_XOffset");
_XOffset = 0.0;
nameMap.set("Y Offset", "_YOffset");
_YOffset = 0.0;
nameMap.set("Inactive Popup Type", "_InactivePopupType");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if(!(asBoolean(_ActivationRegion)))
{
            createBoxRegion(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft(actor)), Float), cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop(actor)), Float), actor.getWidth(), actor.getHeight());
            _ActivationRegion = getLastCreatedRegion();
propertyChanged("_ActivationRegion", _ActivationRegion);
}

    addActorEntersRegionListener(_ActivationRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(_PopupActivationActorType,a.getType(),a.getGroup())){
        actor.say("Displays Popup PM", "_customEvent_" + "RefreshPopup");
}
});
    addActorExitsRegionListener(_ActivationRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(_PopupActivationActorType,a.getType(),a.getGroup())){
        sayToScene("Popup Manager PM", "_customBlock_RemovePopup");
        if(actor.hasBehavior("Usable Item PM"))
{
            actor.setValue("Usable Item PM", "_CurrentNumberOfUses", 0);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}