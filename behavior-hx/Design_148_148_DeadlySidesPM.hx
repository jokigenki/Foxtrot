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



class Design_148_148_DeadlySidesPM extends ActorScript
{          	
	
public var _LeftIsDeadly:Bool;

public var _RightIsDeadly:Bool;

public var _TopIsDeadly:Bool;

public var _BottomIsDeadly:Bool;

public var _DeadlyToActorTypes:Array<Dynamic>;

public var _KillBehaviour:String;

public var _KillSelfOnContact:Bool;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Left Is Deadly?", "_LeftIsDeadly");
_LeftIsDeadly = false;
nameMap.set("Right Is Deadly?", "_RightIsDeadly");
_RightIsDeadly = false;
nameMap.set("Top Is Deadly?", "_TopIsDeadly");
_TopIsDeadly = false;
nameMap.set("Bottom Is Deadly?", "_BottomIsDeadly");
_BottomIsDeadly = false;
nameMap.set("Deadly To Actor Types", "_DeadlyToActorTypes");
_DeadlyToActorTypes = [];
nameMap.set("Kill Behaviour", "_KillBehaviour");
_KillBehaviour = "";
nameMap.set("Kill Self On Contact?", "_KillSelfOnContact");
_KillSelfOnContact = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(Utils.contains(_DeadlyToActorTypes, ("" + event.otherActor.getType())))
{
            if((event.otherFromTop && _BottomIsDeadly))
{
                scripts.Design_27_27_ActorExtrasPM._customBlock_TriggerKilledInActor(event.otherActor,_KillBehaviour,randomInt(Math.floor(-1), Math.floor(1)),-2);
}

            else if((event.otherFromLeft && _RightIsDeadly))
{
                scripts.Design_27_27_ActorExtrasPM._customBlock_TriggerKilledInActor(event.otherActor,_KillBehaviour,1,-2);
}

            else if((event.otherFromBottom && _TopIsDeadly))
{
                scripts.Design_27_27_ActorExtrasPM._customBlock_TriggerKilledInActor(event.otherActor,_KillBehaviour,randomInt(Math.floor(-1), Math.floor(1)),-2);
}

            else if((event.otherFromRight && _LeftIsDeadly))
{
                scripts.Design_27_27_ActorExtrasPM._customBlock_TriggerKilledInActor(event.otherActor,_KillBehaviour,-1,-2);
}

}

        if(_KillSelfOnContact)
{
            recycleActor(actor);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}