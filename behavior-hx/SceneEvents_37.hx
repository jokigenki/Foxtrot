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



class SceneEvents_37 extends SceneScript
{          	
	
public var _ExitName:String;

public var _GooseHead:Actor;

public var _OffDirection:Float;

public var _CrateMakers:Array<Dynamic>;

public var _CrateMaker:Actor;

public var _Crate:Actor;
    public function _customEvent_GooseHeadMaker6_GooseHeadComplete():Void
{
        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    sayToScene("SceneEvents_37", "_customBlock_ShootGrenade", [getActor(6)]);
}, null);
}

    public function _customEvent_GooseHeadMaker7_GooseHeadComplete():Void
{
        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    sayToScene("SceneEvents_37", "_customBlock_ShootGrenade", [getActor(7)]);
}, null);
}

    public function _customEvent_GooseHeadMaker8_GooseHeadComplete():Void
{
        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    sayToScene("SceneEvents_37", "_customBlock_ShootGrenade", [getActor(8)]);
}, null);
}

    public function _customEvent_ReducedHealth():Void
{
        trace("" + getActor(7));
        if((getActor(5).getValue("Reduce Health PM", "_CurrentHealth") == 2))
{
            getActor(7).say("Goose Head Maker PM", "_customEvent_" + "Activate");
}

        if((getActor(5).getValue("Reduce Health PM", "_CurrentHealth") == 1))
{
            getActor(8).say("Goose Head Maker PM", "_customEvent_" + "Activate");
}

}

    public function _customEvent_TimedSwitchLight13SwitchedOn():Void
{
        _CrateMaker = (scripts.Design_207_207_StencylExtrasPM._customBlock_GetRandomItemFromList(_CrateMakers));
propertyChanged("_CrateMaker", _CrateMaker);
        _CrateMaker.say("Spawn PM", "_customEvent_" + "Activated");
        _Crate = _CrateMaker.getValue("Spawn PM", "_LastSpawn");
propertyChanged("_Crate", _Crate);
}

    

/* Params are:__GrenadeMaker */
public function _customBlock_ShootGrenade(__GrenadeMaker:Actor):Void
{
        _GooseHead = __GrenadeMaker.getValue("Goose Head Maker PM", "_Head");
propertyChanged("_GooseHead", _GooseHead);
        createRecycledActor(getActorType(695), _GooseHead.getX(), _GooseHead.getY(), Script.FRONT);
        if((Utils.DEG * (_GooseHead.getAngle()) == 0))
{
            _OffDirection = asNumber((randomFloat() - 0.5));
propertyChanged("_OffDirection", _OffDirection);
            if((_GooseHead.realScaleY == 1))
{
                getLastCreatedActor().applyImpulse(_OffDirection, -1, 30);
}

            else
{
                getLastCreatedActor().applyImpulse(_OffDirection, 1, 30);
}

}

        else if((Utils.DEG * (_GooseHead.getAngle()) == 90))
{
            if((_GooseHead.realScaleY == 1))
{
                getLastCreatedActor().applyImpulse(1, _OffDirection, 30);
}

            else
{
                getLastCreatedActor().applyImpulse(-1, _OffDirection, 30);
}

}

        else if((Utils.DEG * (_GooseHead.getAngle()) == 180))
{
            if((_GooseHead.realScaleY == 1))
{
                getLastCreatedActor().applyImpulse(_OffDirection, -1, 30);
}

            else
{
                getLastCreatedActor().applyImpulse(_OffDirection, 1, 30);
}

}

        else
{
            if((_GooseHead.realScaleY == 1))
{
                getLastCreatedActor().applyImpulse(-1, _OffDirection, 30);
}

            else
{
                getLastCreatedActor().applyImpulse(1, _OffDirection, 30);
}

}

}
    public function _customEvent_GooseTankKilled():Void
{
        scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_UnlockActor(getActor(4));
        recycleActor(getActor(6));
        recycleActor(getActor(7));
        recycleActor(getActor(8));
}

    public function _customEvent_TimedSwitchLight13PreSwitchedOn():Void
{
        if(((hasValue(_Crate) != false) && _Crate.isAlive()))
{
            _Crate.setValue("Explode After Time PM", "_ExplodeAfterSeconds", 0.5);
}

}


 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";
nameMap.set("Goose Head", "_GooseHead");
nameMap.set("Off Direction", "_OffDirection");
_OffDirection = 0.0;
nameMap.set("Crate Makers", "_CrateMakers");
_CrateMakers = [];
nameMap.set("Crate Maker", "_CrateMaker");
nameMap.set("Crate", "_Crate");

	}
	
	override public function init()
	{
		            runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_LockDoorActor(getActor(4));
}, null);
        _CrateMakers = new Array<Dynamic>();
propertyChanged("_CrateMakers", _CrateMakers);
        _CrateMakers.push(getActor(12));
        _CrateMakers.push(getActor(9));
        _CrateMakers.push(getActor(10));
        _CrateMakers.push(getActor(11));
    addWhenTypeGroupKilledListener(getActorType(653), function(eventActor:Actor, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        getActor(13).say("Single Use Region Switch PM", "_customBlock_ResetSwitch");
        for(item in cast(_CrateMakers, Array<Dynamic>))
{
            item.setValue("Spawn PM", "_IsActive", false);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}