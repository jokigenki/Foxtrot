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



class SceneEvents_32 extends SceneScript
{          	
	
public var _ExitName:String;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";

	}
	
	override public function init()
	{
		    addActorEntersRegionListener(getRegion(2), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(156),a.getType(),a.getGroup())){
        getActor(14).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 1.25, function(timeTask:TimedTask):Void {
                    getActor(14).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(0), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(156),a.getType(),a.getGroup())){
        getActor(21).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 1.25, function(timeTask:TimedTask):Void {
                    getActor(21).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(3), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(156),a.getType(),a.getGroup())){
        getActor(19).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 0.25, function(timeTask:TimedTask):Void {
                    getActor(19).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(1), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(156),a.getType(),a.getGroup())){
        getActor(20).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 0.25, function(timeTask:TimedTask):Void {
                    getActor(20).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(2), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(9),a.getType(),a.getGroup())){
        trace("" + "LFT!");
        getActor(14).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 1.75, function(timeTask:TimedTask):Void {
                    getActor(14).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(0), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorType(9),a.getType(),a.getGroup())){
        getActor(21).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 1.75, function(timeTask:TimedTask):Void {
                    getActor(21).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(2), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(8),a.getType(),a.getGroup())){
        getActor(14).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 1.25, function(timeTask:TimedTask):Void {
                    getActor(14).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(0), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(8),a.getType(),a.getGroup())){
        getActor(21).say("Activate On Event PM", "_customEvent_" + "Activate");
        runLater(1000 * 1.25, function(timeTask:TimedTask):Void {
                    getActor(21).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(1), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(8),a.getType(),a.getGroup())){
        getActor(20).say("Activate On Event PM", "_customEvent_" + "Activate");
        a.setActorValue("Facing Right?", true);
        runLater(1000 * 0.25, function(timeTask:TimedTask):Void {
                    getActor(20).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});
    addActorEntersRegionListener(getRegion(3), function(a:Actor, list:Array<Dynamic>):Void  {
if(wrapper.enabled && sameAsAny(getActorGroup(8),a.getType(),a.getGroup())){
        getActor(19).say("Activate On Event PM", "_customEvent_" + "Activate");
        a.setActorValue("Facing Right?", false);
        runLater(1000 * 0.25, function(timeTask:TimedTask):Void {
                    getActor(19).say("Activate On Event PM", "_customEvent_" + "Deactivate");
}, null);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}