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



class Design_52_52_SpawnPM extends ActorScript
{          	
	
public var _AppearAnimationType:String;

public var _TotalSpawnCount:Float;

public var _SpawnRepeatDelay:Float;

public var _ReduceCountWhenActorKilled:Bool;

public var _InitialSpawnDelay:Float;

public var _CurrentSpawnCount:Float;

public var _IsActive:Bool;

public var _IsRunning:Bool;

public var _SpawnType:ActorType;

public var _CreationAttributes:Array<Dynamic>;

public var _CreationValues:Array<Dynamic>;

public var _XOffset:Float;

public var _BehaviourValues:Array<Dynamic>;

public var _LastSpawn:Actor;

public var _YOffset:Float;

public var _PlaceSpawnedActorBehind:Bool;

public var _SwitchToAnimationNamed:String;

public var _SpawnSFXNumber:Float;

public var _SpawnSFXName:String;
    public function _customEvent_MakeSpawn():Void
{
        _IsRunning = false;
propertyChanged("_IsRunning", _IsRunning);
        if((!(_IsActive) || !(cast((actor.say("Spawn PM", "_customBlock_CanSpawn")), Bool))))
{
            return;
}

        sayToScene("Sound Manager PM", "_customBlock_PlayRandomSoundFromSet", [_SpawnSFXName,_SpawnSFXNumber]);
        createRecycledActor(_SpawnType, actor.getX(), actor.getY(), Script.FRONT);
        _LastSpawn = getLastCreatedActor();
propertyChanged("_LastSpawn", _LastSpawn);
        _LastSpawn.moveToLayer(actor.getLayerID());
        if(_PlaceSpawnedActorBehind)
{
            _LastSpawn.sendBackward();
}

        _LastSpawn.setX(((actor.getX() + ((actor.getWidth() - _LastSpawn.getWidth()) / 2)) + _XOffset));
        _LastSpawn.setY(((actor.getY() + ((actor.getHeight() - _LastSpawn.getHeight()) / 2)) + _YOffset));
        actor.say("Spawn PM", "_customBlock_MakeAppear", [_LastSpawn]);
        _CurrentSpawnCount += 1;
propertyChanged("_CurrentSpawnCount", _CurrentSpawnCount);
        scripts.Design_27_27_ActorExtrasPM._customBlock_SetActorValues(_CreationAttributes,_LastSpawn);
        if(_LastSpawn.hasBehavior("Inventory Collectable PM"))
{
            if(!(cast((scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_ItemHasBeenCollected(_LastSpawn.getValue("Inventory Collectable PM", "_CollectableId"))), Bool)))
{
                actor.shout("_customEvent_" + "Spawned");
                if(cast((actor.say("Spawn PM", "_customBlock_CanSpawn")), Bool))
{
                    actor.say("Spawn PM", "_customBlock_ContinueSpawn");
}

}

            else
{
                _LastSpawn.disableBehavior("Display On Collected PM");
                recycleActor(_LastSpawn);
}

}

        else
{
            actor.shout("_customEvent_" + "Spawned");
            if(cast((actor.say("Spawn PM", "_customBlock_CanSpawn")), Bool))
{
                actor.say("Spawn PM", "_customBlock_ContinueSpawn");
}

}

}

    

/* Params are: __SpawnedActor */
public function _customBlock_MakeAppear(__SpawnedActor:Actor):Void
{
var __Self:Actor = actor;
        if(((hasValue(_SwitchToAnimationNamed) != false) && !(("" + _SwitchToAnimationNamed) == (""))))
{
            __SpawnedActor.setAnimation("" + ("" + _SwitchToAnimationNamed));
}

        if((_AppearAnimationType == "fade"))
{
            __SpawnedActor.fadeTo(1, 1, Expo.easeIn);
}

        else if((_AppearAnimationType == "grow"))
{
            __SpawnedActor.growTo(100/100, 100/100, 0, Expo.easeIn);
}

}
    

/* Params are: */
public function _customBlock_CanSpawn():Bool
{
var __Self:Actor = actor;
        return ((_CurrentSpawnCount < _TotalSpawnCount) || (_TotalSpawnCount == 0));
}
    public function _customEvent_Activated():Void
{
        if(!(_IsActive))
{
            _IsActive = true;
propertyChanged("_IsActive", _IsActive);
}

}

    public function _customEvent_Deactivated():Void
{
        if(_IsActive)
{
            _IsActive = false;
propertyChanged("_IsActive", _IsActive);
}

}

    

/* Params are: */
public function _customBlock_StartSpawn():Void
{
var __Self:Actor = actor;
        if((_InitialSpawnDelay == 0))
{
            actor.say("Spawn PM", "_customEvent_" + "MakeSpawn");
}

        else if((_InitialSpawnDelay > 0))
{
            _IsRunning = true;
propertyChanged("_IsRunning", _IsRunning);
            runLater(1000 * _InitialSpawnDelay, function(timeTask:TimedTask):Void {
                        actor.say("Spawn PM", "_customEvent_" + "MakeSpawn");
}, actor);
}

}
    

/* Params are: */
public function _customBlock_ContinueSpawn():Void
{
var __Self:Actor = actor;
        if((_SpawnRepeatDelay == 0))
{
            actor.say("Spawn PM", "_customEvent_" + "MakeSpawn");
}

        else if((_SpawnRepeatDelay > 0))
{
            _IsRunning = true;
propertyChanged("_IsRunning", _IsRunning);
            runLater(1000 * _SpawnRepeatDelay, function(timeTask:TimedTask):Void {
                        actor.say("Spawn PM", "_customEvent_" + "MakeSpawn");
}, actor);
}

}
    

/* Params are:__Self */
public function _customBlock_KillLastSpawn():Void
{
var __Self:Actor = actor;
        if((hasValue(_LastSpawn) != false))
{
            trace("" + "KILLING LAST SPAWN");
            _LastSpawn.say("Default Kill Behaviour PM", "_customEvent_" + "Killed");
            if(!isPrimitive(_LastSpawn)) {_LastSpawn = getDefaultValue(_LastSpawn);}
}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Appear Animation Type", "_AppearAnimationType");
_AppearAnimationType = "";
nameMap.set("Total Spawn Count", "_TotalSpawnCount");
_TotalSpawnCount = 0.0;
nameMap.set("Spawn Repeat Delay", "_SpawnRepeatDelay");
_SpawnRepeatDelay = 0.0;
nameMap.set("Reduce Count When Actor Killed", "_ReduceCountWhenActorKilled");
_ReduceCountWhenActorKilled = false;
nameMap.set("Initial Spawn Delay", "_InitialSpawnDelay");
_InitialSpawnDelay = 0.0;
nameMap.set("Current Spawn Count", "_CurrentSpawnCount");
_CurrentSpawnCount = 0.0;
nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Is Running?", "_IsRunning");
_IsRunning = false;
nameMap.set("Spawn Type", "_SpawnType");
nameMap.set("Creation Attributes", "_CreationAttributes");
_CreationAttributes = [];
nameMap.set("Actor", "actor");
nameMap.set("Creation Values", "_CreationValues");
_CreationValues = [];
nameMap.set("X Offset", "_XOffset");
_XOffset = 0.0;
nameMap.set("Behaviour Values", "_BehaviourValues");
_BehaviourValues = [];
nameMap.set("Last Spawn", "_LastSpawn");
nameMap.set("Y Offset", "_YOffset");
_YOffset = 0.0;
nameMap.set("Place Spawned Actor Behind?", "_PlaceSpawnedActorBehind");
_PlaceSpawnedActorBehind = false;
nameMap.set("Switch To Animation Named", "_SwitchToAnimationNamed");
_SwitchToAnimationNamed = "";
nameMap.set("Spawn SFX Number", "_SpawnSFXNumber");
_SpawnSFXNumber = 1;
nameMap.set("Spawn SFX Name", "_SpawnSFXName");
_SpawnSFXName = "";

	}
	
	override public function init()
	{
		            actor.say("Spawn PM", "_customBlock_StartSpawn");
    addWhenTypeGroupKilledListener(_SpawnType, function(eventActor:Actor, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(_ReduceCountWhenActorKilled)
{
            _CurrentSpawnCount -= 1;
propertyChanged("_CurrentSpawnCount", _CurrentSpawnCount);
            if((!(_IsRunning) && ((_TotalSpawnCount > 0) && (_CurrentSpawnCount == (_TotalSpawnCount - 1)))))
{
                actor.say("Spawn PM", "_customBlock_ContinueSpawn");
}

}

}
});
    addPropertyChangeListener("_IsActive", null, function(property:Dynamic, list:Array<Dynamic>):Void {
if(wrapper.enabled && cast(property, Bool) == true){
        if((!(_IsRunning) && cast((actor.say("Spawn PM", "_customBlock_CanSpawn")), Bool)))
{
            actor.say("Spawn PM", "_customBlock_StartSpawn");
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}