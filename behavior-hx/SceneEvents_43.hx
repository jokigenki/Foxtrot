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



class SceneEvents_43 extends SceneScript
{          	
	
public var _ExitName:String;

public var _CurrentNev:Actor;

public var _LovelyKey:Actor;
    public function _customEvent_UsedWardrobe():Void
{
        if(getGameAttribute("In Pants?"))
{
            setGameAttribute("In Pants?", false);
}

        else
{
            setGameAttribute("In Pants?", true);
}

        sayToScene("SceneEvents_43", "_customBlock_UpdateWardrobe");
}

    

/* Params are:*/
public function _customBlock_UpdateWardrobe():Void
{
        if(getGameAttribute("In Pants?"))
{
            createRecycledActor(getActorType(9), _CurrentNev.getX(), _CurrentNev.getY(), Script.FRONT);
            getLastCreatedActor().setActorValue("Facing Right?", _CurrentNev.getActorValue("Facing Right?"));
            recycleActor(_CurrentNev);
            _CurrentNev = getLastCreatedActor();
propertyChanged("_CurrentNev", _CurrentNev);
            setValueForScene("Split Screen Button PM", "_ActorToControl", getLastCreatedActor());
            getActor(9).setValue("Activate Door PM", "_ActorToMove", getLastCreatedActor());
            getActor(8).setValue("Activate Door PM", "_ActorToMove", getLastCreatedActor());
            getActor(12).disableBehavior("Displays Popup PM");
            _LovelyKey.setY(240);
            _LovelyKey.fadeTo(100 / 100, 1, Linear.easeNone);
            getActor(11).setAnimation("" + ("" + "closed"));
}

        else
{
            createRecycledActor(getActorType(733), _CurrentNev.getX(), _CurrentNev.getY(), Script.FRONT);
            getLastCreatedActor().setActorValue("Facing Right?", _CurrentNev.getActorValue("Facing Right?"));
            recycleActor(_CurrentNev);
            _CurrentNev = getLastCreatedActor();
propertyChanged("_CurrentNev", _CurrentNev);
            setValueForScene("Split Screen Button PM", "_ActorToControl", getLastCreatedActor());
            getActor(9).setValue("Activate Door PM", "_ActorToMove", getLastCreatedActor());
            getActor(8).setValue("Activate Door PM", "_ActorToMove", getLastCreatedActor());
            getActor(12).enableBehavior("Displays Popup PM");
            getActor(11).setAnimation("" + ("" + "open"));
            if(_LovelyKey.isAlive())
{
                getActor(7).setY(174);
                getActor(7).fadeTo(0 / 100, 0, Linear.easeNone);
}

            else
{
                scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_LockDoorActor(getActor(9));
                scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_LoseItemWithId("Tutorial_05Key",getActorType(142));
                createRecycledActor(getActorType(142), 209, 174, Script.FRONT);
                getLastCreatedActor().fadeTo(0 / 100, 0, Linear.easeNone);
                _LovelyKey = getLastCreatedActor();
propertyChanged("_LovelyKey", _LovelyKey);
                getLastCreatedActor().sendToBack();
                getLastCreatedActor().setValue("Collectable Trigger PM", "_CollectionEvent", "KeyCollected");
                getLastCreatedActor().setValue("Collectable Trigger PM", "_CollectableId", "Tutorial_05Key");
                getLastCreatedActor().setValue("Collectable Trigger PM", "_TargetActor", getActor(9));
}

}

}

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";
nameMap.set("Current Nev", "_CurrentNev");
nameMap.set("Lovely Key", "_LovelyKey");

	}
	
	override public function init()
	{
		            _CurrentNev = getActor(10);
propertyChanged("_CurrentNev", _CurrentNev);
        _LovelyKey = getActor(7);
propertyChanged("_LovelyKey", _LovelyKey);
        getActor(7).fadeTo(0 / 100, 0, Linear.easeNone);
        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    sayToScene("SceneEvents_43", "_customBlock_UpdateWardrobe");
}, null);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}