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



class SceneEvents_24 extends SceneScript
{          	
	
public var _ExitName:String;

public var _ChocolateLevel:Float;

public var _ChocolateActor:Actor;

public var _IsGateClosed:Bool;

public var _IsFunnelClosed:Bool;
    public function _customEvent_BlockMelted():Void
{
        if(!(_IsFunnelClosed))
{
            return;
}

        if((cast((getActor(32).say("Particle Emitter PM", "_customBlock_GetParticleCount")), Float) > 0))
{
            getActor(32).say("Particle Emitter PM", "_customBlock_ChangeParticleCount", [-16]);
}

        sayToScene("Sound Manager PM", "_customBlock_PlayNamedSound", ["Gloop SFX"]);
        getActor(32).say("Activate On Event PM", "_customEvent_" + "Deactivate");
        getActor(32).say("Activate On Event PM", "_customEvent_" + "Activate");
}

    public function _customEvent_TimedSwitchLight12SwitchedOn():Void
{
        _IsGateClosed = true;
propertyChanged("_IsGateClosed", _IsGateClosed);
}

    public function _customEvent_TimedSwitchLight12SwitchedOff():Void
{
        _IsGateClosed = false;
propertyChanged("_IsGateClosed", _IsGateClosed);
}

    public function _customEvent_TimedSwitchLight35SwitchedOn():Void
{
        _IsFunnelClosed = true;
propertyChanged("_IsFunnelClosed", _IsFunnelClosed);
}

    public function _customEvent_TimedSwitchLight35SwitchedOff():Void
{
        _IsFunnelClosed = false;
propertyChanged("_IsFunnelClosed", _IsFunnelClosed);
}


 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";
nameMap.set("Chocolate Level", "_ChocolateLevel");
_ChocolateLevel = 16.0;
nameMap.set("Chocolate Actor", "_ChocolateActor");
nameMap.set("Is Gate Closed?", "_IsGateClosed");
_IsGateClosed = false;
nameMap.set("Is Funnel Closed?", "_IsFunnelClosed");
_IsFunnelClosed = false;

	}
	
	override public function init()
	{
		    addActorEntersRegionListener(getRegion(0), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(440),a.getType(),a.getGroup())){
        if(_IsGateClosed)
{
            recycleActor(a);
            _ChocolateLevel += 1;
propertyChanged("_ChocolateLevel", _ChocolateLevel);
}

}
});
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((!(_IsGateClosed) && (_ChocolateLevel > 16)))
{
            _ChocolateLevel -= 1;
propertyChanged("_ChocolateLevel", _ChocolateLevel);
}

        getActor(33).setValue("Filling Liquid PM", "_LiquidLevel", _ChocolateLevel);
}
});
    addActorEntersRegionListener(getRegion(0), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(360),a.getType(),a.getGroup())){
        recycleActor(a);
}
});
    addWhenTypeGroupKilledListener(getActorType(156), function(eventActor:Actor, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        getActor(52).say("Single Use Region Switch PM", "_customBlock_ResetSwitch");
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}