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



class SceneEvents_52 extends SceneScript
{          	
	
public var _LocalCollected:Array<Dynamic>;

public var _TotalEggs:Float;

public var _ConfirmPanelY:Float;

public var _ConfirmButtonY:Float;

public var _CancelButtonY:Float;
    public function _customEvent_ShowConfirm():Void
{
        getActor(12).setY(_CancelButtonY);
        getActor(11).setY(_ConfirmButtonY);
        getActor(10).setY(_ConfirmPanelY);
        getActor(10).enableActorDrawing();
        getActor(11).enableActorDrawing();
        getActor(12).enableActorDrawing();
}

    public function _customEvent_HideConfirm():Void
{
        getActor(12).setY(getSceneHeight());
        getActor(11).setY(getSceneHeight());
        getActor(10).setY(getSceneHeight());
        getActor(10).disableActorDrawing();
        getActor(11).disableActorDrawing();
        getActor(12).disableActorDrawing();
}

    public function _customEvent_ResetGame():Void
{
        shoutToScene("_customEvent_" + "HideConfirm");
}


 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Local Collected", "_LocalCollected");
_LocalCollected = [];
nameMap.set("Total Eggs", "_TotalEggs");
_TotalEggs = 0.0;
nameMap.set("Confirm Panel Y", "_ConfirmPanelY");
_ConfirmPanelY = 0.0;
nameMap.set("Confirm Button Y", "_ConfirmButtonY");
_ConfirmButtonY = 0.0;
nameMap.set("Cancel Button Y", "_CancelButtonY");
_CancelButtonY = 0.0;

	}
	
	override public function init()
	{
		            shoutToScene("_customEvent_" + "HideConfirm");
        _ConfirmPanelY = asNumber(140);
propertyChanged("_ConfirmPanelY", _ConfirmPanelY);
        _CancelButtonY = asNumber(203);
propertyChanged("_CancelButtonY", _CancelButtonY);
        _ConfirmButtonY = asNumber(203);
propertyChanged("_ConfirmButtonY", _ConfirmButtonY);
        if(!(getGameAttribute("Game Was Loaded")))
{
            loadGame("mySave", function(success:Bool):Void {
                if(success)
{
                    trace("" + (("" + "LOADED : ") + ("" + getGameAttribute("ControlMode"))));
                    if(("" + getGameAttribute("ControlMode")) == (""))
{
                        setGameAttribute("ControlMode", "Split");
}

                    setGameAttribute("Current Music", "None");
                    setGameAttribute("Current Atlases", "0");
                    setGameAttribute("Game Was Loaded", true);
                    setGameAttribute("Speed Run In Progress", false);
                    setGameAttribute("Scene Sounds", new Array<Dynamic>());
                    _LocalCollected = getGameAttribute("Collected Items");
propertyChanged("_LocalCollected", _LocalCollected);
                    for(item in cast(_LocalCollected, Array<Dynamic>))
{
                        if(((("" + item).indexOf("Egg") > -1) && (("" + item).indexOf("_") > -1)))
{
                            _TotalEggs += 1;
propertyChanged("_TotalEggs", _TotalEggs);
}

}

                    trace("" + (("" + "TOTAL EGGS:") + ("" + _TotalEggs)));
                    setGameAttribute("Game Complete", (_TotalEggs == 25));
}

                else
{
                    setGameAttribute("Game Was Loaded", false);
}

                if(!(getGameAttribute("Save Destination") == "none"))
{
                    setGameAttribute("Last Destination", "" + (scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ReverseDestination(getGameAttribute("Save Destination"))));
}

});
}

        else
{
            if(!(getGameAttribute("Save Destination") == "none"))
{
                setGameAttribute("Last Destination", "" + (scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ReverseDestination(getGameAttribute("Save Destination"))));
}

}


	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}