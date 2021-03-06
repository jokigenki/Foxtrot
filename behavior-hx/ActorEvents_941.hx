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



class ActorEvents_941 extends ActorScript
{          	
	
public var _Random:Float;

public var _Scale:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Random", "_Random");
_Random = 0.0;
nameMap.set("Scale", "_Scale");
_Scale = 0.0;

	}
	
	override public function init()
	{
		            _Random = asNumber(randomFloat());
propertyChanged("_Random", _Random);
        if((_Random < 0.17))
{
            actor.setAnimation("" + ("" + "Blue"));
}

        else if((_Random < 0.34))
{
            actor.setAnimation("" + ("" + "Green"));
}

        else if((_Random < 0.51))
{
            actor.setAnimation("" + ("" + "Red"));
}

        else if((_Random < 0.55))
{
            actor.setAnimation("" + ("" + "Gold"));
}

        else if((_Random < 0.86))
{
            actor.setAnimation("" + ("" + "Purple"));
}

        else
{
            actor.setAnimation("" + ("" + "White"));
}

        _Scale = asNumber((100 + (200 * randomFloat())));
propertyChanged("_Scale", _Scale);
        actor.applyImpulse(0, -1, randomFloat());
        actor.growTo(_Scale/100, _Scale/100, 0, Linear.easeNone);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}