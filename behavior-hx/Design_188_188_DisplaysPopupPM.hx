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



class Design_188_188_DisplaysPopupPM extends ActorScript
{          	
	
public var _ActivationRegion:Region;

public var _PopupType:ActorType;

public var _XOffset:Float;

public var _YOffset:Float;

public var _InactivePopupType:ActorType;

public var _IsDisplaying:Bool;

public var _DisappearDelay:Float;

public var _XPos:Float;

public var _YPos:Float;

public var _IsEnabled:Bool;
    public function _customEvent_RefreshPopup():Void
{
        if((actor.hasBehavior("Usable Item PM") && (actor.getValue("Usable Item PM", "_CurrentNumberOfUses") < (actor.getValue("Usable Item PM", "_ActivateAfterNumberOfUses") - 1))))
{
            sayToScene("Popup Manager PM", "_customBlock_DisplayPopupAt", [_InactivePopupType,_XPos,_YPos]);
}

        else
{
            sayToScene("Popup Manager PM", "_customBlock_DisplayPopupAt", [_PopupType,_XPos,_YPos]);
}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Activation Region", "_ActivationRegion");
nameMap.set("Popup Type", "_PopupType");
nameMap.set("X Offset", "_XOffset");
_XOffset = 0.0;
nameMap.set("Y Offset", "_YOffset");
_YOffset = 0.0;
nameMap.set("Inactive Popup Type", "_InactivePopupType");
nameMap.set("Is Displaying?", "_IsDisplaying");
_IsDisplaying = false;
nameMap.set("Disappear Delay", "_DisappearDelay");
_DisappearDelay = 0.0;
nameMap.set("X Pos", "_XPos");
_XPos = 0.0;
nameMap.set("Y Pos", "_YPos");
_YPos = 0.0;
nameMap.set("Is Enabled?", "_IsEnabled");
_IsEnabled = true;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if(!(asBoolean(_ActivationRegion)))
{
            createBoxRegion(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorLeft(actor)), Float), cast((scripts.Design_27_27_ActorExtrasPM._customBlock_GetActorTop(actor)), Float), (actor.getWidth()), (actor.getHeight()));
            _XPos = asNumber((actor.getX() + _XOffset));
propertyChanged("_XPos", _XPos);
            _YPos = asNumber((actor.getY() + _YOffset));
propertyChanged("_YPos", _YPos);
            _ActivationRegion = getLastCreatedRegion();
propertyChanged("_ActivationRegion", _ActivationRegion);
}

    addActorEntersRegionListener(_ActivationRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(0),a.getType(),a.getGroup())){
        if(_IsEnabled)
{
            actor.say("Displays Popup PM", "_customEvent_" + "RefreshPopup");
            _IsDisplaying = true;
propertyChanged("_IsDisplaying", _IsDisplaying);
}

}
});
    addActorExitsRegionListener(_ActivationRegion, function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(0),a.getType(),a.getGroup())){
        _IsDisplaying = false;
propertyChanged("_IsDisplaying", _IsDisplaying);
        if((_DisappearDelay > 0))
{
            runLater(1000 * _DisappearDelay, function(timeTask:TimedTask):Void {
                        if(!(_IsDisplaying))
{
                            sayToScene("Popup Manager PM", "_customBlock_RemovePopup");
}

}, actor);
}

        else
{
            sayToScene("Popup Manager PM", "_customBlock_RemovePopup");
}

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