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



class Design_386_386_TypewriterTextPM extends SceneScript
{          	
	
public var _CancelDrawing:Bool;

public var _UseFont:Font;

public var _XPos:Float;

public var _YPos:Float;

public var _CurrentText:String;

public var _DrawCharacterEveryNSeconds:Float;

public var _TextToDraw:String;

public var _CurrentIndex:Float;

public var _Lines:Array<Dynamic>;

public var _CurrentY:Float;

public var _Leading:Float;

public var _SFX:Sound;

public var _TotalTime:Float;

public var _SFX2:Sound;
    

/* Params are:__Text */
public function _customBlock_SetText(__Text:String):Void
{
        _TextToDraw = __Text;
propertyChanged("_TextToDraw", _TextToDraw);
        _TotalTime = asNumber((_DrawCharacterEveryNSeconds * ("" + _TextToDraw).length));
propertyChanged("_TotalTime", _TotalTime);
        runPeriodically(1000 * _DrawCharacterEveryNSeconds, function(timeTask:TimedTask):Void {
                    if(_CancelDrawing)
{
                        timeTask.repeats = false;
return;
}

                    else
{
                        if((_CurrentIndex >= ("" + _TextToDraw).length))
{
                            sayToScene("Sound Manager PM", "_customBlock_StopSceneSound", ["Typewriter SFX",getCurrentSceneName()]);
                            timeTask.repeats = false;
return;
}

                        else
{
                            _CurrentText = ("" + _TextToDraw).substring(Std.int(0), Std.int((_CurrentIndex + 1)));
propertyChanged("_CurrentText", _CurrentText);
                            _Lines = ("" + _CurrentText).split("|");
propertyChanged("_Lines", _Lines);
                            if(!(("" + _TextToDraw).substring(Std.int(_CurrentIndex), Std.int((_CurrentIndex + 1))) == " "))
{
                                if((randomFloat() < 0.5))
{
                                    sayToScene("Sound Manager PM", "_customBlock_PlaySound", [_SFX]);
}

                                else
{
                                    sayToScene("Sound Manager PM", "_customBlock_PlaySound", [_SFX2]);
}

}

}

                        _CurrentIndex += 1;
propertyChanged("_CurrentIndex", _CurrentIndex);
}

}, null);
}

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Cancel Drawing?", "_CancelDrawing");
_CancelDrawing = false;
nameMap.set("Use Font", "_UseFont");
nameMap.set("X Pos", "_XPos");
_XPos = 0.0;
nameMap.set("Y Pos", "_YPos");
_YPos = 0.0;
nameMap.set("Current Text", "_CurrentText");
_CurrentText = "";
nameMap.set("Draw Character Every N Seconds", "_DrawCharacterEveryNSeconds");
_DrawCharacterEveryNSeconds = 0.1;
nameMap.set("Text To Draw", "_TextToDraw");
_TextToDraw = "";
nameMap.set("Current Index", "_CurrentIndex");
_CurrentIndex = 0.0;
nameMap.set("Lines", "_Lines");
_Lines = [];
nameMap.set("Current Y", "_CurrentY");
_CurrentY = 0.0;
nameMap.set("Leading", "_Leading");
_Leading = 0.0;
nameMap.set("SFX", "_SFX");
nameMap.set("Total Time", "_TotalTime");
_TotalTime = 0.0;
nameMap.set("SFX 2", "_SFX2");

	}
	
	override public function init()
	{
		            _Lines = new Array<Dynamic>();
propertyChanged("_Lines", _Lines);
        if(!(("" + _TextToDraw) == ("")))
{
            sayToScene("Typewriter Text PM", "_customBlock_SetText", [_TextToDraw]);
}

    addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((hasValue(_UseFont) != false))
{
            g.setFont(_UseFont);
}

        _CurrentY = asNumber((_YPos - getScreenY()));
propertyChanged("_CurrentY", _CurrentY);
        for(index0 in 0...Std.int(_Lines.length))
{
            g.drawString("" + _Lines[Std.int(index0)], (_XPos - getScreenX()), _CurrentY);
            _CurrentY += (g.font.getHeight()/Engine.SCALE + _Leading);
propertyChanged("_CurrentY", _CurrentY);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}