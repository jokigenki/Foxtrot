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



class SceneEvents_51 extends SceneScript
{          	
	
public var _ExitName:String;

public var _CurrentNev:Actor;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Exit Name", "_ExitName");
_ExitName = "";
nameMap.set("Current Nev", "_CurrentNev");

	}
	
	override public function init()
	{
		            runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    if(!(getGameAttribute("In Pants?")))
{
                        createRecycledActor(getActorType(9), getActor(13).getX(), getActor(13).getY(), Script.FRONT);
                        getLastCreatedActor().setActorValue("Facing Right?", getActor(13).getActorValue("Facing Right?"));
                        recycleActor(getActor(13));
                        sayToScene("Split Screen Button PM", "_customBlock_SetActorToControl", [getLastCreatedActor()]);
                        getActor(12).setValue("Activate Door PM", "_ActorToMove", getLastCreatedActor());
                        getActor(14).setValue("Activate Door PM", "_ActorToMove", getLastCreatedActor());
}

}, null);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}