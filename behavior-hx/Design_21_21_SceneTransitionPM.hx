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



class Design_21_21_SceneTransitionPM extends SceneScript
{          	
	
public var _LastAtlases:String;

public var _NewAtlases:String;

public var _Index:Float;
    public function _customEvent_SwitchScene():Void
{
        if(isTransitioning())
{
            runLater(1000 * 1, function(timeTask:TimedTask):Void {
                        sayToScene("Scene Transition PM", "_customBlock_DoSwitchScene");
}, null);
}

        else
{
            sayToScene("Scene Transition PM", "_customBlock_DoSwitchScene");
}

}

    

/* Params are:*/
public function _customBlock_DoSwitchScene():Void
{
        trace("" + (("" + "SWITCH TO ") + ("" + getGameAttribute("Last Destination"))));
        /* 0 = Shared, 1 = Factory, 2 = Farm, 3 = Home, 4 = Levels, 5 = Humpty */
        if(("" + getGameAttribute("Last Destination")) == (""))
{
            return;
}

        var nextScene = getGameAttribute("Last Destination").split("|")[1];
        if((nextScene == getCurrentSceneName()))
{
            return;
}

        if(sceneHasBehavior("Speed Run Timer PM"))
{
            sayToScene("Speed Run Timer PM", "_customBlock_SaveSpeedRunData");
}

        _LastAtlases = getGameAttribute("Current Atlases");
propertyChanged("_LastAtlases", _LastAtlases);
        if((nextScene.indexOf("Farm") > -1))
{
            _NewAtlases = "024";
propertyChanged("_NewAtlases", _NewAtlases);
}

        else if((nextScene.indexOf("Factory") > -1))
{
            _NewAtlases = "014";
propertyChanged("_NewAtlases", _NewAtlases);
}

        else if((nextScene.indexOf("Final Boss") > -1))
{
            _NewAtlases = "045";
propertyChanged("_NewAtlases", _NewAtlases);
}

        else
{
            _NewAtlases = "03";
propertyChanged("_NewAtlases", _NewAtlases);
}

        _Index = asNumber(0);
propertyChanged("_Index", _Index);
        trace("" + (("" + "ATLASES WERE: ") + ("" + (("" + _LastAtlases) + ("" + (("" + " ATLASES ARE NOW: ") + ("" + _NewAtlases)))))));
        for(index0 in 0...Std.int(("" + _LastAtlases).length))
{
            if((("" + _NewAtlases).indexOf(("" + _LastAtlases).charAt(Std.int(_Index))) == -1))
{
                trace("" + (("" + "UNLOAD: ") + ("" + ("" + _LastAtlases).charAt(Std.int(_Index)))));
                unloadAtlas(Std.int(asNumber(("" + _LastAtlases).charAt(Std.int(_Index)))));
}

            _Index += 1;
propertyChanged("_Index", _Index);
}

        _Index = asNumber(0);
propertyChanged("_Index", _Index);
        for(index0 in 0...Std.int(("" + _NewAtlases).length))
{
            if((("" + _LastAtlases).indexOf(("" + _NewAtlases).charAt(Std.int(_Index))) == -1))
{
                trace("" + (("" + "LOAD: ") + ("" + ("" + _NewAtlases).charAt(Std.int(_Index)))));
                loadAtlas(Std.int(asNumber(("" + _NewAtlases).charAt(Std.int(_Index)))));
}

            _Index += 1;
propertyChanged("_Index", _Index);
}

        setGameAttribute("Current Atlases", _NewAtlases);
        switchScene(GameModel.get().scenes.get(getIDForScene(("" + getGameAttribute("Last Destination")).split("|")[Std.int(1)])).getID(), createFadeOut((0.5)),createFadeIn((0.5)));
}

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Last Atlases", "_LastAtlases");
_LastAtlases = "";
nameMap.set("New Atlases", "_NewAtlases");
_NewAtlases = "";
nameMap.set("Index", "_Index");
_Index = 0.0;

	}
	
	override public function init()
	{
		            trace("" + (("" + "Switched to scene ") + ("" + getCurrentSceneName())));
        if((getGameAttribute("Game Was Loaded") && !(getGameAttribute("Speed Run In Progress"))))
{
            saveGame("mySave", function(success:Bool):Void {

});
}


	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}