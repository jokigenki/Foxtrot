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



class Design_69_69_PlayerControlsPM extends ActorScript
{          	
	
public var _MoveLeftKey:String;

public var _MoveRightKey:String;

public var _DuckKey:String;

public var _GroundPoundKey:String;

public var _JumpKey:String;

public var _RunKey:String;

public var _JetPackKey:String;

public var _GrappleKey:String;

public var _UpKey:String;

public var _DownKey:String;

public var _UseObjectKey:String;
    

/* Params are: __AttributeName __Control */
public function _customBlock_UpdateControl(__AttributeName:String, __Control:String):Void
{
var __Self:Actor = actor;
        if((("" + __Control) == "No Control"))
{
            return;
}

        if(isKeyDown(__Control))
{
            /* "Custom: Set <Attribute Name> to <true> for Self" */
            actor.say("Control Adapter PM", "_customBlock_SetIsOn", [__AttributeName,true]);
}

        else if(isKeyReleased(__Control))
{
            /* "Custom: Set <Attribute Name> to <false> for Self" */
            actor.say("Control Adapter PM", "_customBlock_SetIsOn", [__AttributeName,false]);
}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Move Left Key", "_MoveLeftKey");
nameMap.set("Move Right Key", "_MoveRightKey");
nameMap.set("Duck Key", "_DuckKey");
nameMap.set("Ground Pound Key", "_GroundPoundKey");
nameMap.set("Jump Key", "_JumpKey");
nameMap.set("Run Key", "_RunKey");
nameMap.set("Jet Pack Key", "_JetPackKey");
nameMap.set("Grapple Key", "_GrappleKey");
nameMap.set("Up Key", "_UpKey");
nameMap.set("Down Key", "_DownKey");
nameMap.set("Use Object Key", "_UseObjectKey");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            if(#if mobile true #else false #end)
{
            disableThisBehavior();
}

    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        actor.say("Player Controls PM", "_customBlock_UpdateControl", ["Down",_DownKey]);
        actor.say("Player Controls PM", "_customBlock_UpdateControl", ["Duck",_DuckKey]);
        actor.say("Player Controls PM", "_customBlock_UpdateControl", ["Grapple",_GrappleKey]);
        actor.say("Player Controls PM", "_customBlock_UpdateControl", ["GroundPound",_GroundPoundKey]);
        actor.say("Player Controls PM", "_customBlock_UpdateControl", ["JetPack",_JetPackKey]);
        actor.say("Player Controls PM", "_customBlock_UpdateControl", ["Jump",_JumpKey]);
        actor.say("Player Controls PM", "_customBlock_UpdateControl", ["Left",_MoveLeftKey]);
        actor.say("Player Controls PM", "_customBlock_UpdateControl", ["Right",_MoveRightKey]);
        actor.say("Player Controls PM", "_customBlock_UpdateControl", ["Run",_RunKey]);
        actor.say("Player Controls PM", "_customBlock_UpdateControl", ["Up",_UpKey]);
        actor.say("Player Controls PM", "_customBlock_UpdateControl", ["UseObject",_UseObjectKey]);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}