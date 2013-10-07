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

public var _YOffset:Float;
    public function _customEvent_MakeSpawn():Void
{
        _IsRunning = false;
propertyChanged("_IsRunning", _IsRunning);
        if((!(_IsActive) || !(cast((actor.say("Spawn PM", "_customBlock_CanSpawn")), Bool))))
{
            return;
}

        trace("" + (("" + "Make ") + ("" + ("" + _SpawnType))));
        createRecycledActor(_SpawnType, actor.getX(), actor.getY(), Script.FRONT);
        getLastCreatedActor().moveToLayer(actor.getLayerID());
        getLastCreatedActor().setX(((actor.getX() + ((actor.getWidth() - getLastCreatedActor().getWidth()) / 2)) + _XOffset));
        getLastCreatedActor().setY(((actor.getY() + ((actor.getHeight() - getLastCreatedActor().getHeight()) / 2)) + _YOffset));
        actor.say("Spawn PM", "_customBlock_MakeAppear", [getLastCreatedActor()]);
        _CurrentSpawnCount += 1;
propertyChanged("_CurrentSpawnCount", _CurrentSpawnCount);
        scripts.Design_27_27_ActorExtrasPM._customBlock_SetActorValues(_CreationAttributes,getLastCreatedActor());
        actor.shout("_customEvent_" + "Spawned");
        if(cast((actor.say("Spawn PM", "_customBlock_CanSpawn")), Bool))
{
            actor.say("Spawn PM", "_customBlock_ContinueSpawn");
}

}

    

/* Params are: __SpawnedActor */
public function _customBlock_MakeAppear(__SpawnedActor:Actor):Void
{
var __Self:Actor = actor;
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
nameMap.set("Y Offset", "_YOffset");
_YOffset = 0.0;

	}
	
	override public function init()
	{
		            actor.say("Spawn PM", "_customBlock_StartSpawn");
        actor.disableActorDrawing();
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